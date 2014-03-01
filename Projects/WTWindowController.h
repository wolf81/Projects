//
//  WTWindowController.h
//  Projects
//
//  Created by Wolfgang Schreurs on 28/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreData/CoreData.h>


@interface WTWindowController : NSWindowController

@property (nonatomic, strong) NSManagedObjectContext *objectContext;

- (instancetype)initWithWindowNibName:(NSString *)windowNibName
                              context:(NSManagedObjectContext *)context;


- (void)presentSheet:(NSWindow *)parentWindow;
- (void)endSheet;

@end
