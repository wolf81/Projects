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

@property (nonatomic, strong) IBOutlet NSPopUpButton *clientsPopUpButton;
@property (nonatomic, strong) IBOutlet NSTextField *rateField;
@property (nonatomic, strong) IBOutlet NSTextField  *serialNumberField;
@property (nonatomic, strong) IBOutlet NSPopUpButton *monthPopUpButton;

- (IBAction)saveAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

- (id)initWithInvoice:(Invoice *)invoice
              context:(NSManagedObjectContext *)context;

@end
