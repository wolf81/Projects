//
//  ProjectsWindowController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 28/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "MainWindowController.h"
#import "ProjectsViewController.h"
#import "ClientsViewController.h"
#import "TasksViewController.h"
#import "InvoicesViewController.h"


@interface MainWindowController ()

@property (nonatomic, copy) NSArray *clients;
@property (nonatomic, strong) ClientsViewController *clientsViewController;
@property (nonatomic, strong) ProjectsViewController *projectsViewController;
@property (nonatomic, strong) TasksViewController *tasksViewController;
@property (nonatomic, strong) InvoicesViewController *invoicesViewController;

@end


@implementation MainWindowController

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self.toolbar setSelectedItemIdentifier:@"tasks"];
    [self tasksAction:nil];
}

#pragma mark - Actions

- (IBAction)clientsAction:(id)sender
{
    if (self.clientsViewController == nil) {
        self.clientsViewController = [[ClientsViewController alloc] initWithContext:self.objectContext];
    }
    
    if (self.window.contentView != _clientsViewController.view) {
        self.window.contentView = _clientsViewController.view;
        [_clientsViewController prepareForDisplay];
        [_clientsViewController reloadData];
    }
}

- (IBAction)projectsAction:(id)sender
{
    if (self.projectsViewController == nil) {
        self.projectsViewController = [[ProjectsViewController alloc] initWithContext:self.objectContext];
    }
    
    if (self.window.contentView != _projectsViewController.view) {
        self.window.contentView = _projectsViewController.view;
        [_projectsViewController reloadData];
    }
}

- (IBAction)invoicesAction:(id)sender
{
    if (self.invoicesViewController == nil) {
        self.invoicesViewController = [[InvoicesViewController alloc] initWithContext:self.objectContext];
    }
    
    if (self.window.contentView != _invoicesViewController.view) {
        self.window.contentView = _invoicesViewController.view;
        [_invoicesViewController reloadData];
    }
}

- (IBAction)tasksAction:(id)sender
{
    if (self.tasksViewController == nil) {
        self.tasksViewController = [[TasksViewController alloc] initWithContext:self.objectContext];
    }
    
    if (self.window.contentView != _tasksViewController.view) {
        self.window.contentView = _tasksViewController.view;
        [_tasksViewController reloadData];
    }
}

@end
