//
//  AddProjectWindowController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 28/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "EditProjectWindowController.h"
#import "Client.h"


@interface EditProjectWindowController ()

@property (nonatomic, copy) NSArray *clients;
@property (nonatomic, strong) Project *project;

@end


@implementation EditProjectWindowController

- (id)initWithProject:(Project *)project context:(NSManagedObjectContext *)context
{
    self = [super initWithWindowNibName:@"EditProjectWindow" context:context];
    if (self) {
        self.project = project;
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];

    [self reloadData];

    if (self.project) {
        _projectNameField.stringValue = _project.name;

        for (NSMenuItem *menuItem in _clientsPopUpButton.itemArray) {
            if ([menuItem.representedObject isEqual:_project.corporation]) {
                [_clientsPopUpButton selectItem:menuItem];
                break;
            }
        }
    }
}

#pragma mark - User interface updates

- (void)reloadData
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Corporation" inManagedObjectContext:self.objectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [self.objectContext executeFetchRequest:request error:&error];
    if (array == nil) {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
    } else {
        self.clients = array;
        
        for (Client *client in _clients) {
            [_clientsPopUpButton addItemWithTitle:client.name];
            _clientsPopUpButton.lastItem.representedObject = client;
        }
        
        if (_clients.count > 0) {
            [_clientsPopUpButton selectItemAtIndex:0];
        }
    }
}

#pragma mark - Actions

- (IBAction)saveAction:(id)sender
{
    if (_project == nil) {
        self.project = (Project *) [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:self.objectContext];
    }
    
    NSInteger clientIdx = [_clientsPopUpButton indexOfSelectedItem];
    Corporation *client =_clients[clientIdx];
    
    _project.name = [_projectNameField stringValue];
    _project.corporation = client;
    
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
