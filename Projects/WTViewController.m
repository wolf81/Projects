//
//  WTViewController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 28/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "WTViewController.h"


@interface WTViewController ()

@end


@implementation WTViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                        context:(NSManagedObjectContext *)context
{
    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if (self) {
        self.objectContext = context;
    }
    return self;
}

@end
