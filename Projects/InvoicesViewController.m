//
//  InvoicesViewController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 01/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "InvoicesViewController.h"


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
}

- (IBAction)editAction:(id)sender
{
}

- (IBAction)deleteAction:(id)sender
{
}

@end
