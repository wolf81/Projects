//
//  InvoicesViewController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 01/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "InvoicesViewController.h"
#import "EditInvoiceWindowController.h"


@interface InvoicesViewController ()

@property (nonatomic, copy) NSArray *invoices;

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
}

@end
