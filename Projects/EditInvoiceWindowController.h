//
//  InvoiceWindowController.h
//  Projects
//
//  Created by Wolfgang Schreurs on 02/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "WTWindowController.h"
#import "Invoice.h"


@interface EditInvoiceWindowController : WTWindowController

- (id)initWithInvoice:(Invoice *)invoice
              context:(NSManagedObjectContext *)context;

- (IBAction)saveAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end
