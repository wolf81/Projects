//
//  Task.h
//  Projects
//
//  Created by Wolfgang Schreurs on 01/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * hours;
@property (nonatomic, retain) NSDecimalNumber * rate;
@property (nonatomic, retain) NSString * information;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Project *project;

@end
