//
//  WTInvoiceDocument.m
//  Projects
//
//  Created by Wolfgang Schreurs on 07/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "WTInvoiceDocument.h"
#import "Project.h"
#import "Task.h"


@interface WTInvoiceDocument ()

@property (nonatomic, strong) Invoice *invoice;
@property (nonatomic, strong) NSArray *projects;

@end


@implementation WTInvoiceDocument

- (id)initWithInvoice:(Invoice *)invoice
{
    self = [super init];
    if (self) {
        self.invoice = invoice;
    }
    return self;
}

- (Client *)client
{
    return _invoice.client;
}

- (NSArray *)projects
{
    if (_projects == nil) {
        NSMutableArray *projects = [NSMutableArray array];
        for (Task *task in _invoice.tasks) {
            if ([projects containsObject:task.project] == NO) {
                [projects addObject:task.project];
            }
        }
        self.projects = projects;
    }
    
    return _projects;
}

@end
