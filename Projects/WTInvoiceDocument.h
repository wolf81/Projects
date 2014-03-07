//
//  WTInvoiceDocument.h
//  Projects
//
//  Created by Wolfgang Schreurs on 07/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Invoice.h"
#import "Project.h"
#import "Client.h"
#import "Company.h"
#import "GRMustache.h"


@interface WTInvoiceDocument : NSObject

- (id)initWithInvoice:(Invoice *)invoice;

@property (nonatomic, readonly) Invoice *invoice;
@property (nonatomic, readonly) Client *client;
@property (nonatomic, readonly) NSArray *projects;
@property (nonatomic, strong) Company *company;

@end
