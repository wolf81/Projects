//
//  WTClientsViewController.h
//  Projects
//
//  Created by Wolfgang Schreurs on 28/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "WTViewController.h"


@interface ClientsViewController : WTViewController
    <NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, strong) IBOutlet NSTableView *tableView;
@property (nonatomic, strong) IBOutlet NSTextField *zipField;
@property (nonatomic, strong) IBOutlet NSTextField *emailField;
@property (nonatomic, strong) IBOutlet NSTextField *cityField;
@property (nonatomic, strong) IBOutlet NSTextField *addressField;
@property (nonatomic, strong) IBOutlet NSTextField *countryField;

- (IBAction)addAction:(id)sender;
- (IBAction)editAction:(id)sender;
- (IBAction)deleteAction:(id)sender;

- (void)reloadData;
- (void)prepareForDisplay;

- (id)initWithContext:(NSManagedObjectContext *)context;

@end
