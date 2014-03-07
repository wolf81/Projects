//
//  InvoicesViewController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 01/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "InvoicesViewController.h"
#import "EditInvoiceWindowController.h"
#import "Client.h"

#import "WTPDFWriter.h"


@interface InvoicesViewController ()

@property (nonatomic, copy) NSArray *invoices;
@property (nonatomic, strong) WTPDFWriter *writer;

@end


@implementation InvoicesViewController

- (id)initWithContext:(NSManagedObjectContext *)context
{
    self = [super initWithNibName:@"InvoicesView" context:context];
    if (self) {
    }
    return self;
}

- (void)reloadData
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Invoice" inManagedObjectContext:self.objectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSError *error;
    NSArray *array = [self.objectContext executeFetchRequest:request error:&error];
    if (array == nil) {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
    } else {
        self.invoices = array;
        [_tableView reloadData];
        
        if (_invoices.count > 0) {
            NSIndexSet *selectedRow = [NSIndexSet indexSetWithIndex:0];
            [_tableView selectRowIndexes:selectedRow byExtendingSelection:NO];
        }
    }
}

#pragma mark - Actions 

- (IBAction)addAction:(id)sender
{
    EditInvoiceWindowController *windowController = [[EditInvoiceWindowController alloc]
                                                     initWithInvoice:nil
                                                     context:self.objectContext];
    [windowController presentSheet:self.view.window];
    [self reloadData];
}

- (IBAction)editAction:(id)sender
{
    Invoice *invoice = _invoices[_tableView.selectedRow];
    EditInvoiceWindowController *windowController = [[EditInvoiceWindowController alloc]
                                                     initWithInvoice:invoice
                                                     context:self.objectContext];
    [windowController presentSheet:self.view.window];
    [self reloadData];
}

- (IBAction)deleteAction:(id)sender
{
    Invoice *invoice = _invoices[_tableView.selectedRow];
    
    [self.objectContext deleteObject:invoice];
    
    NSError *error = nil;
    BOOL success = [self.objectContext save:&error];
    if (success == NO) {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
    } else {
        [self reloadData];
    }
}

- (void)pdfAction:(id)sender
{
//    NSInteger rowIdx = [_tableView selectedRow];
//    if (rowIdx == -1) {
//        return;
//    }
    
    Invoice *invoice = [_invoices objectAtIndex:0];
    
    self.writer = [[WTPDFWriter alloc] initWithInvoice:invoice pageSize:kPaperSizeA4];
    [_writer write];
}

#pragma mark - Table view

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _invoices.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Invoice *invoice = [_invoices objectAtIndex:row];
    
    id value = nil;
    
    if ([tableColumn.identifier isEqualToString:@"serialNumber"]) {
        value = invoice.invoiceNumber;
    } else if ([tableColumn.identifier isEqualToString:@"client"]) {
        value = invoice.client.name;
    } else if ([tableColumn.identifier isEqualToString:@"date"]) {
        value = invoice.issueDate;
    }
    
    return value;
}

- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row
{
    return YES;
}

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return NO;
}

@end
