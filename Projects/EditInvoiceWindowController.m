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


@interface EditInvoiceWindowController ()

@property (nonatomic, copy) NSArray *clients;

@end


@implementation EditInvoiceWindowController

- (id)initWithInvoice:(Invoice *)invoice context:(NSManagedObjectContext *)context
{
    self = [super initWithWindowNibName:@"EditInvoiceWindow" context:context];
    if (self) {
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];

    [self reloadData];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [calendar components:NSMonthCalendarUnit fromDate:currentDate];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    for (int i = 0; i < 12; i++) {
        NSString *monthName = [dateFormatter.monthSymbols objectAtIndex:i];
        [_monthPopUpButton addItemWithTitle:monthName];

        if ((i + 1) == comps.month) {
            [_monthPopUpButton selectItemAtIndex:i];
        }
    }
    
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
            [_clientsPopUpButton selectItemAtIndex:0];
        }
    }
}

#pragma mark - Actions 

- (void)saveAction:(id)sender
{
}

- (void)cancelAction:(id)sender
{
    [self endSheet];
}

@end
