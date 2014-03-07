//
//  Project+Extensions.m
//  Projects
//
//  Created by Wolfgang Schreurs on 07/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "Project+Helper.h"
#import "Task.h"


@implementation Project (Helper)

- (NSDecimalNumber *)totalCost {
    NSDecimalNumber *costTotal = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    for (Task *task in self.tasks) {
        NSDecimalNumber *hours = [NSDecimalNumber decimalNumberWithDecimal:task.hours.decimalValue];
        NSDecimalNumber *taskTotal = [task.rate decimalNumberByMultiplyingBy:hours];
        costTotal = [costTotal decimalNumberByAdding:taskTotal];
    }
    
    return costTotal;
}

@end
