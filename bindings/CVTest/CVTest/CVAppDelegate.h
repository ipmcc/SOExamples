//
//  CVAppDelegate.h
//  CVTest
//
//  Created by Ian McCullough on 1/23/12.
//

#import <Cocoa/Cocoa.h>

@class CVModel;

@interface CVAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (nonatomic, readonly, retain) CVModel* model;

- (IBAction)dumpModelToConsole:(id)sender;

@end
