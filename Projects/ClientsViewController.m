//
//  WTClientsViewController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 28/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "ClientsViewController.h"
#import "Client.h"
#import "Company.h"
#import "EditClientWindowController.h"


@interface ClientsViewController ()

@property (nonatomic, copy) NSArray *corporations;
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
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Corporation" inManagedObjectContext:self.objectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [self.objectContext executeFetchRequest:request error:&error];
    if (array == nil) {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
    } else {
        self.corporations = array;
        [_tableView reloadData];
        
        if (_corporations.count > 0) {
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
    Corporation *corporation = _corporations[_tableView.selectedRow];
    EditClientWindowController *windowController = [[EditClientWindowController alloc]
                                                    initWithCorporation:corporation
                                                    context:self.objectContext
                                                    isClient:YES];
    [windowController presentSheet:self.view.window];
    [self reloadData];
}

- (void)deleteAction:(id)sender
{
    Corporation *corporation = _corporations[_tableView.selectedRow];

    if (corporation.projects.count > 0) {
        NSAlert *alert = [NSAlert
                          alertWithMessageText:@"Cannot delete client."
                          defaultButton:@"OK"
                          alternateButton:nil
                          otherButton:nil
                          informativeTextWithFormat:@"First remove any projects linked to this client."];
        [alert runModal];
        return;
    }
    
    [self.objectContext deleteObject:corporation];
    
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
                                                    initWithCorporation:nil
                                                    context:self.objectContext
                                                    isClient:YES];
    [windowController presentSheet:self.view.window];
    [self reloadData];
}

#pragma mark - Private methods

- (void)updateClientInfoForSelectedRow:(NSInteger)rowIndex
{
    Corporation *corporation = _corporations[rowIndex];
    
    _zipField.stringValue = corporation.zip;
    _cityField.stringValue = corporation.city;
    _addressField.stringValue = corporation.address;
    _emailField.stringValue = corporation.email;
    _countryField.stringValue = corporation.country;
    
    BOOL showCompanyDetails = [corporation isKindOfClass:[Company class]];
    if (showCompanyDetails) {
        NSLog(@"show extended company details ...");
    }
}

#pragma mark - Table view

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _corporations.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Corporation *corporation = [_corporations objectAtIndex:row];
    return corporation.name;
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
