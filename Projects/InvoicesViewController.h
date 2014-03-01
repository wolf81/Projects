//
//  InvoicesViewController.h
//  Projects
//
//  Created by Wolfgang Schreurs on 01/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "WTViewController.h"


@interface InvoicesViewController : WTViewController
    <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, strong) IBOutlet NSTableView *tableView;

- (IBAction)addAction:(id)sender;
- (IBAction)editAction:(id)sender;
- (IBAction)deleteAction:(id)sender;

- (void)reloadData;

- (id)initWithContext:(NSManagedObjectContext *)context;

@end
