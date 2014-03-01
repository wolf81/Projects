//
//  ProjectsViewController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 28/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "ProjectsViewController.h"
#import "EditProjectWindowController.h"
#import "Project.h"
#import "Client.h"
#import "Task.h"


@interface ProjectsViewController ()

@property (nonatomic, copy) NSArray *projects;

@end


@implementation ProjectsViewController

- (id)initWithContext:(NSManagedObjectContext *)context
{
    self = [super initWithNibName:@"ProjectsView" context:context];
    if (self) {
    }
    return self;
}

#pragma mark - User interface updates

- (void)reloadData
{
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Project"
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
        self.projects = array;
        [_tableView reloadData];
    }
}

#pragma mark - Actions 

- (IBAction)addAction:(id)sender
{
    EditProjectWindowController *windowController = [[EditProjectWindowController alloc] initWithWindowNibName:@"EditProjectWindow" context:self.objectContext];
    
    [windowController presentSheet:self.view.window];
    [self reloadData];
}

- (void)editAction:(id)sender
{
    Project *project = _projects[_tableView.selectedRow];
    EditProjectWindowController *windowController = [[EditProjectWindowController alloc]
                                                     initWithProject:project context:self.objectContext];
    [windowController presentSheet:self.view.window];
    [self reloadData];
}

- (void)deleteAction:(id)sender
{
    Project *project = _projects[_tableView.selectedRow];

    if (project.tasks.count > 0) {
        NSAlert *alert = [NSAlert
                          alertWithMessageText:@"Cannot delete project."
                          defaultButton:@"OK"
                          alternateButton:nil
                          otherButton:nil
                          informativeTextWithFormat:@"First remove any tasks linked to this project."];
        [alert runModal];
        return;
    }
    
    [self.objectContext deleteObject:project];
    
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
    return _projects.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Project *project = [_projects objectAtIndex:row];

    return [tableColumn.identifier isEqualToString:@"project"] ? project.name : project.client.name;
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return NO;
}

@end
