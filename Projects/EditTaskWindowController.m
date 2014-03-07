//
//  EditTaskWindowController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 01/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "EditTaskWindowController.h"
#import "Project.h"


@interface EditTaskWindowController ()

@property (nonatomic, copy) NSArray *projects;
@property (nonatomic, strong) Task *task;

@end


@implementation EditTaskWindowController

- (id)initWithTask:(Task *)task context:(NSManagedObjectContext *)context
{
    self = [super initWithWindowNibName:@"EditTaskWindow" context:context];
    if (self) {
        self.task = task;
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self reloadData];
    
    NSDate *now = [NSDate date];
    [_datePicker setDateValue:now];
    
    if (self.task) {
        _nameField.stringValue = _task.name;
        _datePicker.dateValue = _task.date;
        _infoView.string = _task.information;
        _timeField.intValue = _task.hours.intValue;
        _rateField.stringValue = _task.rate.stringValue;
        
        for (NSMenuItem *menuItem in _projectsPopUpButton.itemArray) {
            if ([menuItem.representedObject isEqual:_task.project]) {
                [_projectsPopUpButton selectItem:menuItem];
                break;
            }
        }
    }
}

- (void)reloadData
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Project" inManagedObjectContext:self.objectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [self.objectContext executeFetchRequest:request error:&error];
    if (array == nil) {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
    } else {
        self.projects = array;
        
        for (Project *project in _projects) {
            [_projectsPopUpButton addItemWithTitle:project.name];
            _projectsPopUpButton.lastItem.representedObject = project;
        }
        
        if (_projects.count > 0) {
            [_projectsPopUpButton selectItemAtIndex:0];
        }
    }
}

#pragma mark - Actions

- (IBAction)saveAction:(id)sender
{    
    if (_task == nil) {
        self.task = (Task *) [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:self.objectContext];
    }
    
    NSInteger projectIdx = [_projectsPopUpButton indexOfSelectedItem];
    Project *project =_projects[projectIdx];

    _task.name = [_nameField stringValue];
    _task.information = [_infoView string];
    _task.date = [_datePicker dateValue];
    _task.hours = [NSNumber numberWithInt:_timeField.intValue];
    _task.project = project;
    _task.rate = [NSDecimalNumber decimalNumberWithString:_rateField.stringValue];
    
    NSError *error = nil;
    BOOL success = [self.objectContext save:&error];
    
    if (!success) {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
    } else {
        [NSApp endSheet:self.window returnCode:NSOKButton];
    }
}

- (IBAction)cancelAction:(id)sender
{
    [NSApp endSheet:self.window returnCode:NSCancelButton];
}

@end
