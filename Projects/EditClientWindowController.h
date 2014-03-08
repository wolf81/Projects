//
//  AddContactWindowController.h
//  Projects
//
//  Created by Wolfgang Schreurs on 27/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "WTWindowController.h"
#import "Client.h"


@interface EditClientWindowController : WTWindowController

@property (nonatomic, strong) IBOutlet NSTextField *nameField;
@property (nonatomic, strong) IBOutlet NSTextField *emailField;
@property (nonatomic, strong) IBOutlet NSTextField *addressField;
@property (nonatomic, strong) IBOutlet NSTextField *zipField;
@property (nonatomic, strong) IBOutlet NSTextField *cityField;
@property (nonatomic, strong) IBOutlet NSTextField *countryField;
@property (nonatomic, strong) IBOutlet NSTextField *vatRateField;
@property (nonatomic, strong) IBOutlet NSTextField *bankNameField;
@property (nonatomic, strong) IBOutlet NSTextField *bankAccountField;
@property (nonatomic, strong) IBOutlet NSTextField *hourlyRateField;
@property (nonatomic, strong) IBOutlet NSTextField *cocNumberField;
@property (nonatomic, strong) IBOutlet NSTextField *vatNumberField;

@property (nonatomic, strong) IBOutlet NSButton *saveButton;
@property (nonatomic, strong) IBOutlet NSButton *cancelButton;
@property (nonatomic, strong) IBOutlet NSView *companyView;

- (IBAction)saveAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

- (id)initWithCorporation:(Corporation *)corporation
                  context:(NSManagedObjectContext *)context
                isClient:(BOOL)isClient;

@end
