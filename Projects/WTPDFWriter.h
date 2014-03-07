//
//  WTPDFWriter.h
//  Projects
//
//  Created by Wolfgang Schreurs on 06/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Invoice.h"


#define kPaperSizeA4 CGSizeMake(595.2,841.8)
#define kPaperSizeLetter CGSizeMake(612,792)


@interface WTPDFWriter : NSObject

- (id)initWithInvoice:(Invoice *)invoice pageSize:(CGSize)pageSize;
- (void)write;

@end
