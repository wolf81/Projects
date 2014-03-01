//
//  WTViewController.h
//  Projects
//
//  Created by Wolfgang Schreurs on 28/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreData/CoreData.h>


@interface WTViewController : NSViewController

@property (nonatomic, strong) NSManagedObjectContext *objectContext;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                        context:(NSManagedObjectContext *)context;

@end
