//
//  InvoiceWindowController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 02/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "EditInvoiceWindowController.h"
#import "Invoice.h"
#import "Client.h"
#import "Project.h"
#import "Task.h"


// TODO: should be able to choose year as well - add controls and adjust code accordingly
// TODO: consider removing serial number field - not necessary, should be calculated anyway


@interface EditInvoiceWindowController ()

@property (nonatomic, strong) Invoice *invoice;
@property (nonatomic, copy) NSArray *clients;
@property (nonatomic, copy) NSArray *tasks;
@property (nonatomic, strong) Client *currentClient;
@property (nonatomic, strong) NSMutableArray *invoiceTasks;

- (void)updateTasks;

@end


@implementation EditInvoiceWindowController

- (id)initWithInvoice:(Invoice *)invoice context:(NSManagedObjectContext *)context
{
    self = [super initWithWindowNibName:@"EditInvoiceWindow" context:context];
    if (self) {
        self.invoice = invoice;
        self.invoiceTasks = [NSMutableArray array];
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];

    [self reloadData];
    
    _rateField.stringValue = @"21,5";
    _serialNumberField.stringValue = @"2014001";
}

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
        
        for (Client *client in _clients) {
            [_clientsPopUpButton addItemWithTitle:client.name];
            _clientsPopUpButton.lastItem.representedObject = client;
        }

        if (_clients.count > 0) {
            if (_invoice != nil) {
                for (NSMenuItem *item in _clientsPopUpButton.itemArray) {
                    if (item.representedObject == _invoice.client) {
                        [_clientsPopUpButton selectItem:item];
                        break;
                    }
                }
            } else {
                [_clientsPopUpButton selectItemAtIndex:0];
            }
            [self clientChangedAction:nil];
        }
    }
}

#pragma mark - Actions 

- (void)addTaskAction:(id)sender
{
}

- (void)saveAction:(id)sender
{
    if (_invoice == nil) {
        self.invoice = (Invoice *) [NSEntityDescription insertNewObjectForEntityForName:@"Invoice" inManagedObjectContext:self.objectContext];
    }
    
    NSInteger clientIdx = [_clientsPopUpButton indexOfSelectedItem];
    Client *client =_clients[clientIdx];
    
    _invoice.client = client;
    _invoice.serialNumber = [NSNumber numberWithInt:_serialNumberField.intValue];
    _invoice.taxRate = [NSDecimalNumber decimalNumberWithString:_rateField.stringValue];

    // BUG - needs fixing!
    for (Task *task in _invoice.tasks) {
        task.invoice = [_invoiceTasks containsObject:task] ? _invoice : nil;
    }
    
    NSError *error = nil;
    BOOL success = [self.objectContext save:&error];
    
    if (!success) {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
    } else {
        [NSApp endSheet:self.window returnCode:NSOKButton];
    }
}

- (void)cancelAction:(id)sender
{
    [self endSheet];
}

- (IBAction)clientChangedAction:(id)sender
{
    self.currentClient = (Client *)[_clientsPopUpButton selectedItem].representedObject;
    
    if (self.currentClient) {
        [self updateTasks];
    }
}

- (void)updateTasks
{
    // if existing invoice:
    //  1) select only tasks that are part of the invoice
    //  2) allow selection of tasks that are not part of any invoice

    // if new invoice:
    //  1) preselect any tasks not part of any invoice
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:self.objectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *tasks = [self.objectContext executeFetchRequest:request error:&error];
    if (tasks == nil) {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
        return;
    }

    NSPredicate *predicate = nil;
    if (_invoice) {
        predicate = [NSPredicate predicateWithFormat:@"project.client = %@ AND (invoice = %@ OR invoice = nil)", _currentClient, _invoice];
        
        for (Task *task in _invoice.tasks) {
            [_invoiceTasks addObject:task];
        }
    } else {
        predicate = [NSPredicate predicateWithFormat:@"project.client = %@ AND invoice = nil", _currentClient];
    }
    self.tasks = [tasks filteredArrayUsingPredicate:predicate];
    
    [self.tableView reloadData];
}

#pragma mark - Table view

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _tasks.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Task *task = [_tasks objectAtIndex:row];

    id value = nil;
    
    if ([tableColumn.identifier isEqualToString:@"name"]) {
        value = task.name;
    } else if ([tableColumn.identifier isEqualToString:@"hours"]) {
        value = task.hours;
    } else if ([tableColumn.identifier isEqualToString:@"add"]) {
        BOOL isChecked = [_invoiceTasks containsObject:task];
        value = isChecked ? @YES : @NO;
    }
    
    return value;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if ([tableColumn.identifier isEqualToString:@"add"]) {
        Task *task = [_tasks objectAtIndex:row];
        
        if ([_invoiceTasks containsObject:task] == NO) {
            [_invoiceTasks addObject:task];
        } else {
            [_invoiceTasks removeObject:task];
        }
    }
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row
{
    return YES;
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [tableColumn.identifier isEqualToString:@"add"];
}

@end
