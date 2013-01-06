//
//  SOAppDelegate.m
//  AnimTextField
//
//  Created by Ian McCullough on 1/6/13.
//  Copyright (c) 2013 Foobar. All rights reserved.
//

#import "SOAppDelegate.h"

@interface NSTextField (AnimatedSetString)

- (void) setAnimatedStringValue:(NSString *)aString;

@end

@implementation NSTextField (AnimatedSetString)

- (void) setAnimatedStringValue:(NSString *)aString
{
    if ([[self stringValue] isEqual: aString])
    {
        return;
    }
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        [context setDuration: 1.0];
        [self.animator setAlphaValue: 0.0];
    }
                        completionHandler:^{
                            [self setStringValue: [self.stringValue isEqual: @"bar"] ? @"foo" : @"bar"];
                            [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
                                [context setDuration: 1.0];
                                [self.animator setAlphaValue: 1.0];
                            } completionHandler: ^{}];
                        }];
}

@end

@implementation SOAppDelegate

- (IBAction)doStuff:(id)sender
{
    [self.textField setAnimatedStringValue: [self.textField.stringValue isEqual: @"bar"] ? @"foo" : @"bar"];
}


@end
