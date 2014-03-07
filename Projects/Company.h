//
//  Company.h
//  Projects
//
//  Created by Wolfgang Schreurs on 08-03-14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Corporation.h"


@interface Company : Corporation

@property (nonatomic, retain) NSString * cocNumber;
@property (nonatomic, retain) NSString * vatNumber;
@property (nonatomic, retain) NSString * bankAccount;
@property (nonatomic, retain) NSString * bankName;
@property (nonatomic, retain) NSDecimalNumber * defaultHourlyRate;
@property (nonatomic, retain) NSDecimalNumber * defaultTaxRate;

@end
