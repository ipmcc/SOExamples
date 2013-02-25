//
//  AppDelegate.h
//  SOToolTip
//
//  Created by Ian McCullough on 2/25/13.
//  Copyright (c) 2013 FooBar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, readonly, retain) NSArray* model;

@end
