//
//  Invoice.h
//  Projects
//
//  Created by Wolfgang Schreurs on 02/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Client;

@interface Invoice : NSManagedObject

@property (nonatomic, retain) NSDate * issueDate;
@property (nonatomic, retain) NSDecimalNumber * taxRate;
@property (nonatomic, retain) NSNumber * serialNumber;
@property (nonatomic, retain) NSNumber * month;
@property (nonatomic, retain) Client *client;

@end
