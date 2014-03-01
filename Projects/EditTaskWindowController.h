//
//  EditTaskWindowController.h
//  Projects
//
//  Created by Wolfgang Schreurs on 01/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "WTWindowController.h"
#import "Task.h"


@interface EditTaskWindowController : WTWindowController

@property (nonatomic, strong) IBOutlet NSPopUpButton *projectsPopUpButton;
@property (nonatomic, strong) IBOutlet NSTextField *nameField;
@property (nonatomic, strong) IBOutlet NSTextView *infoView;
@property (nonatomic, strong) IBOutlet NSTextField *timeField;
@property (nonatomic, strong) IBOutlet NSDatePicker *datePicker;

- (IBAction)saveAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

- (id)initWithTask:(Task *)task context:(NSManagedObjectContext *)context;

@end
