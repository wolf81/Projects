//
//  ProjectsWindowController.h
//  Projects
//
//  Created by Wolfgang Schreurs on 28/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WTWindowController.h"


@interface MainWindowController : WTWindowController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet NSToolbar *toolbar;

- (IBAction)clientsAction:(id)sender;
- (IBAction)projectsAction:(id)sender;
- (IBAction)invoicesAction:(id)sender;
- (IBAction)tasksAction:(id)sender;

@end
