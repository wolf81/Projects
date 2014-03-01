//
//  WTWindowController.m
//  Projects
//
//  Created by Wolfgang Schreurs on 28/02/14.
//  Copyright (c) 2014 Wolftrail. All rights reserved.
//

#import "WTWindowController.h"


@interface WTWindowController ()

@end


@implementation WTWindowController

- (instancetype)initWithWindowNibName:(NSString *)windowNibName
                              context:(NSManagedObjectContext *)context
{
    self = [super initWithWindowNibName:windowNibName];
    if (self) {
        self.objectContext = context;
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

#pragma mark - Using window as action sheet

- (void)presentSheet:(NSWindow *)parentWindow
{
    [NSApp beginSheet:self.window modalForWindow:parentWindow modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:NULL];
    [NSApp runModalForWindow:self.window];
}

- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    NSLog(@"Code: %ld", returnCode);
    
    [self.window orderOut:nil];
    
    [NSApp stopModal];
}

- (void)endSheet
{
    [NSApp endSheet:self.window returnCode:NSCancelButton];
}

@end
