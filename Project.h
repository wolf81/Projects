//
//  Project.h
//  Projects
//
//  Created by Wolfgang Schreurs on 07-03-14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Corporation, Task;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Corporation *corporation;
@property (nonatomic, retain) NSSet *tasks;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;

@end
