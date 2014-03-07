//
//  Invoice.h
//  Projects
//
//  Created by Wolfgang Schreurs on 07-03-14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Client, Task;

@interface Invoice : NSManagedObject

@property (nonatomic, retain) NSDate * issueDate;
@property (nonatomic, retain) NSNumber * invoiceNumber;
@property (nonatomic, retain) NSDecimalNumber * taxRate;
@property (nonatomic, retain) Client *client;
@property (nonatomic, retain) NSSet *tasks;
@end

@interface Invoice (CoreDataGeneratedAccessors)

- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;

@end
