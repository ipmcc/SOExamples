//
//  AppDelegate.h
//  TestSandbox
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate, NSTableViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTableColumn *popUpColumn;
@property (assign) IBOutlet NSTableColumn *surrogateColumn;

@property (retain) id dataModel;
@property (readonly, retain) NSArray* popUpOptions;

@end
