//
//  WTClientsViewController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 28/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "ClientsViewController.h"
#import "Client.h"
#import "EditClientWindowController.h"


@interface ClientsViewController ()

@property (nonatomic, copy) NSArray *clients;
@property (nonatomic, assign) BOOL editEnabled;

- (void)updateClientInfoForSelectedRow:(NSInteger)rowIndex;

@end


@implementation ClientsViewController

- (id)initWithContext:(NSManagedObjectContext *)context
{
    self = [super initWithNibName:@"ClientsView" context:context];
    if (self) {
    }
    return self;
}

#pragma mark - User interface updates

- (void)reloadData
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Client" inManagedObjectContext:self.objectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [self.objectContext executeFetchRequest:request error:&error];
    if (array == nil) {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
    } else {
        self.clients = array;
        [_tableView reloadData];
        
        if (_clients.count > 0) {
            NSIndexSet *selectedRow = [NSIndexSet indexSetWithIndex:0];
            [_tableView selectRowIndexes:selectedRow byExtendingSelection:NO];
            [self updateClientInfoForSelectedRow:0];
        }
    }
}

- (void)prepareForDisplay
{
    [_emailField setEnabled:NO];
    [_countryField setEnabled:NO];
    [_cityField setEnabled:NO];
    [_zipField setEnabled:NO];
    [_addressField setEnabled:NO];
}

#pragma mark - Actions

- (void)editAction:(id)sender
{
    Client *client = _clients[_tableView.selectedRow];
    EditClientWindowController *windowController = [[EditClientWindowController alloc]
                                                    initWithClient:client
                                                    context:self.objectContext];
    [windowController presentSheet:self.view.window];
    [self reloadData];
}

- (void)deleteAction:(id)sender
{
    Client *client = _clients[_tableView.selectedRow];

    if (client.projects.count > 0) {
        NSAlert *alert = [NSAlert
                          alertWithMessageText:@"Cannot delete client."
                          defaultButton:@"OK"
                          alternateButton:nil
                          otherButton:nil
                          informativeTextWithFormat:@"First remove any projects linked to this client."];
        [alert runModal];
        return;
    }
    
    [self.objectContext deleteObject:client];
    
    NSError *error = nil;
    BOOL success = [self.objectContext save:&error];
    if (success == NO) {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
    } else {
        [self reloadData];
    }
}

- (IBAction)addAction:(id)sender
{
    EditClientWindowController *windowController = [[EditClientWindowController alloc]
                                                    initWithClient:nil
                                                    context:self.objectContext];
    [windowController presentSheet:self.view.window];
    [self reloadData];
}

#pragma mark - Private methods

- (void)updateClientInfoForSelectedRow:(NSInteger)rowIndex
{
    Client *client = _clients[rowIndex];
    
    _zipField.stringValue = client.zip;
    _cityField.stringValue = client.city;
    _addressField.stringValue = client.address;
    _emailField.stringValue = client.email;
    _countryField.stringValue = client.country;
}

#pragma mark - Table view

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _clients.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Client *client = [_clients objectAtIndex:row];
    return client.name;
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row
{
    [self updateClientInfoForSelectedRow:row];
    
    return YES;
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return NO;
}

@end
