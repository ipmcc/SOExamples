//
//  SOAppDelegate.h
//  AnimTextField
//
//  Created by Ian McCullough on 1/6/13.
//  Copyright (c) 2013 Foobar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SOAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField* textField;
- (IBAction)doStuff:(id)sender;

@end
