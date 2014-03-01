//
//  AddProjectWindowController.h
//  Projects
//
//  Created by Wolfgang Schreurs on 28/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "WTWindowController.h"
#import "Project.h"


@interface EditProjectWindowController : WTWindowController

@property (nonatomic, strong) IBOutlet NSPopUpButton *clientsPopUpButton;
@property (nonatomic, strong) IBOutlet NSTextField *projectNameField;

- (IBAction)saveAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

- (id)initWithProject:(Project *)project context:(NSManagedObjectContext *)context;

@end
