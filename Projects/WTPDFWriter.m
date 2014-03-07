//
//  WTPDFWriter.m
//  Projects
//
//  Created by Wolfgang Schreurs on 06/03/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "WTPDFWriter.h"
#import <WebKit/WebKit.h>
#import <Quartz/Quartz.h>


@interface WTPDFWriter ()

@property (nonatomic, strong) WebView *webView;
@property (nonatomic, strong) WebFrameView *webFrameView;
@property (nonatomic, strong) WebFrame *webFrame;
@property (nonatomic, strong) NSString *htmlString;
@property (nonatomic, assign) NSEdgeInsets pageMargins;
@property (nonatomic, assign) CGSize pageSize;
@property (nonatomic, assign) CGRect paperRect;

@end


@implementation WTPDFWriter

- (id)initWithHTMLString:(NSString *)htmlString pageSize:(CGSize)pageSize
{
    self = [super init];
    if (self) {
        self.htmlString = htmlString;
        self.pageSize = pageSize;
        
        self.webView = [[WebView alloc] initWithFrame:NSRectFromCGRect(CGRectMake(0.0f, 0.0f, pageSize.width, pageSize.height)) frameName:nil groupName:nil];
        _webView.shouldUpdateWhileOffscreen = YES;
        _webView.frameLoadDelegate = self;
    }
    return self;
}

- (void)write
{
    [self loadHTML];
}

- (void)loadHTML
{
    [_webView.mainFrame loadHTMLString:_htmlString baseURL:nil];
}

#pragma mark - Webview download delegate

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    NSLog(@"loaded");

    NSString *filePath = @"/Users/wolf/test.pdf";
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error = nil;
        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (success == NO) {
            NSLog(@"%@", error);
        }
    }
    
    WebFrame *mainFrame = sender.mainFrame;
    NSView *view = [[mainFrame frameView] documentView];
    
    NSPrintInfo *printInfo;
    NSPrintInfo *sharedInfo;
    NSMutableDictionary *printInfoDict;
    NSMutableDictionary *sharedDict;

    sharedInfo = [NSPrintInfo sharedPrintInfo];sharedDict = [sharedInfo dictionary];printInfoDict = [NSMutableDictionary dictionaryWithDictionary:sharedDict];
    
    //below we set the type of printing job to a save job.
    [printInfoDict setObject:NSPrintSaveJob forKey:NSPrintJobDisposition];
    
    //set the path to the file you want to print to
    [printInfoDict setObject:filePath forKey:NSPrintSavePath];
    
    //create our very own NSPrintInfo object with the settings we specified in printInfoDict
    printInfo = [[NSPrintInfo alloc] initWithDictionary: printInfoDict];
    [printInfo setHorizontalPagination:NSFitPagination];
    [printInfo setVerticallyCentered:NO];
    [printInfo setHorizontallyCentered:NO];

    /*
    NSSize paperSize = [printInfo paperSize];
    NSRect imageableBounds = [printInfo imageablePageBounds];

    if (NSWidth(imageableBounds) > paperSize.width) {
        imageableBounds.origin.x = 0;
        imageableBounds.size.width = paperSize.width;
    }
    
    if (NSHeight(imageableBounds) > paperSize.height) {
        imageableBounds.origin.y = 0;
        imageableBounds.size.height = paperSize.height;
    }
    
    [printInfo setBottomMargin:NSMinY(imageableBounds)];
    [printInfo setTopMargin:paperSize.height - NSMinY(imageableBounds) - NSHeight(imageableBounds)];
    [printInfo setLeftMargin:NSMinX(imageableBounds)];
    [printInfo setRightMargin:paperSize.width - NSMinX(imageableBounds) - NSWidth(imageableBounds)];
     */
    
    //create the NSPrintOperation object, specifying docView from the previous post as the NSView to print from.
    NSPrintOperation *printOp = [NSPrintOperation printOperationWithView:view printInfo:printInfo];
    
    //we don't want to show the printing panel
    [printOp setShowsPrintPanel:NO];
    [printOp setShowsProgressPanel:NO];
    

    
    //run the print operation
    [printOp runOperation];
}

@end
