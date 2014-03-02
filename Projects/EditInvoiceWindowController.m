//
//  InvoiceWindowController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 02/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "EditInvoiceWindowController.h"
#import "Invoice.h"


@interface EditInvoiceWindowController ()

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
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
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
