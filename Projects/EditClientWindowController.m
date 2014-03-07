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
}

- (IBAction)saveAction:(id)sender
{
    if (_corporation == nil) // insert
    {
        if (_isClient) {
            self.corporation = (Client *) [NSEntityDescription insertNewObjectForEntityForName:@"Client" inManagedObjectContext:self.objectContext];
        } else {
            self.corporation = (Company *) [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.objectContext];
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
