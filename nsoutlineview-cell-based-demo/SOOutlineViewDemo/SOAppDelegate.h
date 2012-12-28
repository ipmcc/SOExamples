//
//  SOAppDelegate.h
//  SOOutlineViewDemo
//
//  Created by Ian McCullough on 12/28/12.
//  Copyright (c) 2012 Ian McCullough. All rights reserved.
//

@class ProjectViewController;

@interface SOAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (retain) ProjectViewController* pvc;

@end
