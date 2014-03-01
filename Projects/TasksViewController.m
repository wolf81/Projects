//
//  TasksViewController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 01/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "TasksViewController.h"
#import "EditTaskWindowController.h"
#import "Project.h"
#import "Task.h"


@interface TasksViewController ()

@property (nonatomic, copy) NSArray *tasks;

@end


@implementation TasksViewController

- (id)initWithContext:(NSManagedObjectContext *)context
{
    self = [super initWithNibName:@"TasksView" context:context];
    if (self) {
    
    }
    return self;
}

#pragma mark - User interface updates

- (void)reloadData
{
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Task"
                                              inManagedObjectContext:self.objectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [self.objectContext executeFetchRequest:request error:&error];
    if (array == nil)
    {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
    } else {
        self.tasks = array;
        [_tableView reloadData];
        
        if (_tasks.count > 0) {
            NSIndexSet *selectedRow = [NSIndexSet indexSetWithIndex:0];
            [_tableView selectRowIndexes:selectedRow byExtendingSelection:NO];
        }
    }
}

#pragma mark - Actions

- (IBAction)addAction:(id)sender
{
    EditTaskWindowController *windowController = [[EditTaskWindowController alloc]
                                                  initWithTask:nil context:self.objectContext];
    [windowController presentSheet:self.view.window];
    [self reloadData];
}

- (IBAction)editAction:(id)sender
{
    Task *task = _tasks[_tableView.selectedRow];
    EditTaskWindowController *windowController = [[EditTaskWindowController alloc]
                                                  initWithTask:task context:self.objectContext];
    [windowController presentSheet:self.view.window];
    [self reloadData];
}

- (IBAction)deleteAction:(id)sender
{
    Task *task = _tasks[_tableView.selectedRow];
    [self.objectContext deleteObject:task];
    
    NSError *error = nil;
    BOOL success = [self.objectContext save:&error];
    if (success == NO) {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
    } else {
        [self reloadData];
    }
}

#pragma mark - Table view

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _tasks.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Task *task = [_tasks objectAtIndex:row];
    
    id value = nil;
    
    if ([tableColumn.identifier isEqualToString:@"name"]) {
        return task.name;
    } else if ([tableColumn.identifier isEqualToString:@"hours"]) {
        return task.hours;
    } else if ([tableColumn.identifier isEqualToString:@"date"]) {
        return task.date;
    } else if ([tableColumn.identifier isEqualToString:@"project"]) {
        return task.project.name;
    }
    
    return value;
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return NO;
}

@end
