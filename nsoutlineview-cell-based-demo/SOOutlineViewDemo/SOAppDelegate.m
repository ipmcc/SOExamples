//
//  SOAppDelegate.m
//  SOOutlineViewDemo
//
//  Created by Ian McCullough on 12/28/12.
//  Copyright (c) 2012 Ian McCullough. All rights reserved.
//

#import "SOAppDelegate.h"
#import "ProjectViewController.h"

@implementation SOAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.pvc = [[[ProjectViewController alloc] initWithNibName: @"ProjectViewController" bundle: [NSBundle mainBundle]] autorelease];
    [self.window.contentView addSubview: self.pvc.view];
    self.pvc.view.frame = [(NSView*)self.window.contentView bounds];
}

@end
