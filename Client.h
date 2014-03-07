//
//  Client.h
//  Projects
//
//  Created by Wolfgang Schreurs on 07-03-14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Corporation.h"

@class Invoice;

@interface Client : Corporation

@property (nonatomic, retain) NSSet *invoices;
@end

@interface Client (CoreDataGeneratedAccessors)

- (void)addInvoicesObject:(Invoice *)value;
- (void)removeInvoicesObject:(Invoice *)value;
- (void)addInvoices:(NSSet *)values;
- (void)removeInvoices:(NSSet *)values;

@end
