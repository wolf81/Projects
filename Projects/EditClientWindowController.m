//
//  AddContactWindowController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 27/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "EditClientWindowController.h"


@interface EditClientWindowController ()

@property (nonatomic, strong) Client *client;

@end


@implementation EditClientWindowController

- (id)initWithClient:(Client *)client context:(NSManagedObjectContext *)context
{
    self = [super initWithWindowNibName:@"EditClientWindow" context:context];
    if (self)
    {
        self.client = client;
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    if (self.client != nil) {
        _nameField.stringValue = _client.name;
        _addressField.stringValue = _client.address;
        _zipField.stringValue = _client.zip;
        _cityField.stringValue = _client.city;
        _emailField.stringValue = _client.email;
        _countryField.stringValue = _client.country;
    }
}

- (IBAction)saveAction:(id)sender
{
    if (_client == nil) // insert
    {
        self.client = (Client *) [NSEntityDescription insertNewObjectForEntityForName:@"Client" inManagedObjectContext:self.objectContext];
    }

    _client.name = [_nameField stringValue];
    _client.address = [_addressField stringValue];
    _client.zip = [_zipField stringValue];
    _client.city = [_cityField stringValue];
    _client.email = [_emailField stringValue];
    _client.country = [_countryField stringValue];
        
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
