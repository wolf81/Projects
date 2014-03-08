//
//  AddContactWindowController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 27/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "EditClientWindowController.h"
#import "Company.h"


@interface EditClientWindowController ()

@property (nonatomic, strong) Corporation *corporation;
@property (nonatomic, assign) BOOL isClient;

@end


@implementation EditClientWindowController

- (id)initWithCorporation:(Corporation *)corporation
                  context:(NSManagedObjectContext *)context
                 isClient:(BOOL)isClient
{
    self = [super initWithWindowNibName:@"EditClientWindow" context:context];
    if (self)
    {
        self.corporation = corporation;
        self.isClient = isClient;
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    if (self.corporation != nil) {
        _nameField.stringValue = _corporation.name;
        _addressField.stringValue = _corporation.address;
        _zipField.stringValue = _corporation.zip;
        _cityField.stringValue = _corporation.city;
        _emailField.stringValue = _corporation.email;
        _countryField.stringValue = _corporation.country;
    }
    
    if (_isClient == NO) {
        NSRect windowRect = [self.window.contentView bounds];
        NSRect companyRect = _companyView.bounds;
        windowRect.size.height += companyRect.size.height + 20.0f;

        NSRect saveButtonFrame = _saveButton.frame;
        saveButtonFrame.origin.y += companyRect.size.height;
        _saveButton.frame = saveButtonFrame;
        
        NSRect cancelButtonFrame = _cancelButton.frame;
        cancelButtonFrame.origin.y += companyRect.size.height;
        _cancelButton.frame = cancelButtonFrame;

        [self.window setFrame:windowRect display:NO animate:NO];

        [self.window.contentView addSubview:_companyView];
        companyRect.origin.y = _saveButton.frame.origin.y + 40.0f;
        _companyView.frame = companyRect;
    }
}

- (IBAction)saveAction:(id)sender
{
    if (_corporation == nil) // insert
    {
        if (_isClient) {
            self.corporation = (Client *) [NSEntityDescription insertNewObjectForEntityForName:@"Client" inManagedObjectContext:self.objectContext];
        } else {
            self.corporation = (Company *) [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.objectContext];
            
            Company *company = (Company *)_corporation;
            company.vatNumber = [_vatNumberField stringValue];
            company.cocNumber = [_cocNumberField stringValue];
            company.bankAccount = [_bankAccountField stringValue];
            company.bankName = [_bankNameField stringValue];
        }
    }

    _corporation.name = [_nameField stringValue];
    _corporation.address = [_addressField stringValue];
    _corporation.zip = [_zipField stringValue];
    _corporation.city = [_cityField stringValue];
    _corporation.email = [_emailField stringValue];
    _corporation.country = [_countryField stringValue];
        
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
    [self endSheet];
}

@end
