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

@interface SOTextFieldAnimationDelegate : NSObject <NSAnimationDelegate>

- (id)initForSettingString: (NSString*)newString onTextField: (NSTextField*)tf;

@end

@implementation NSTextField (AnimatedSetString)

- (void) setAnimatedStringValue:(NSString *)aString
{
    
    if ([[self stringValue] isEqual: aString])
    {
        return;
    }
    
    [[[SOTextFieldAnimationDelegate alloc] initForSettingString: aString onTextField: self] autorelease];
}

@end


@implementation SOTextFieldAnimationDelegate
{
    NSString* _newString;
    NSAnimation* _fadeIn;
    NSAnimation* _fadeOut;
    NSTextField* _tf;
}

- (id)initForSettingString: (NSString*)newString onTextField: (NSTextField*)tf
{
    if (self = [super init])
    {
        _newString = [newString copy];
        _tf = [tf retain];

        [self retain]; // we'll autorelease ourselves when the animations are done.

        _fadeOut = [[NSViewAnimation alloc] initWithViewAnimations: @[ (@{
                                                                        NSViewAnimationTargetKey : tf ,
                                                                        NSViewAnimationEffectKey : NSViewAnimationFadeOutEffect})] ];
        [_fadeOut setDuration:2];
        [_fadeOut setAnimationCurve: NSAnimationEaseIn];
        [_fadeOut setAnimationBlockingMode:NSAnimationNonblocking];
        _fadeOut.delegate = self;

        _fadeIn = [[NSViewAnimation alloc] initWithViewAnimations: @[ (@{
                                                                        NSViewAnimationTargetKey : tf ,
                                                                        NSViewAnimationEffectKey : NSViewAnimationFadeInEffect})] ];
        [_fadeIn setDuration:3];
        [_fadeIn setAnimationCurve:NSAnimationEaseIn];
        [_fadeIn setAnimationBlockingMode:NSAnimationNonblocking];
        
        [_fadeOut startAnimation];
    }
    return self;
}

- (void)dealloc
{
    [_newString release];
    [_tf release];
    [_fadeOut release];
    [_fadeIn release];
    [super dealloc];
}

- (void)animationDidEnd:(NSAnimation*)animation
{
    if (_fadeOut == animation)
    {
        _fadeOut.delegate = nil;
        [_fadeOut release];
        _fadeOut = nil;
    
        _tf.hidden = YES;
        [_tf setStringValue: _newString];
        
        _fadeIn.delegate = self;
        [_fadeIn startAnimation];
    }
    else
    {
        _fadeIn.delegate = nil;
        [_fadeIn release];
        _fadeIn = nil;
        
        [self autorelease];
    }
}

@end


@implementation SOAppDelegate

- (IBAction)doStuff:(id)sender
{
    [self.textField setAnimatedStringValue: [self.textField.stringValue isEqual: @"bar"] ? @"foo" : @"bar"];
}


@end
