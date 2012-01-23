//
//  CVAppDelegate.m
//  CVTest
//
//  Created by Ian McCullough on 1/23/12.
//

#import "CVAppDelegate.h"
#import "CVModel.h"

@interface CVAppDelegate ()

@property (nonatomic, readwrite, retain) CVModel* model;


@end
@implementation CVAppDelegate

@synthesize window = _window;
@synthesize model = mModel;

- (void)dealloc
{
    [mModel release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    CVModel* model = [[[CVModel alloc] init] autorelease];

    model.altSize = NSMakeSize(50, 50);
    model.geometry = [[[CVGeometry alloc] initWithPosition: NSMakePoint(25,25) size: NSMakeSize(100,100) angle: 90] autorelease];
    model.name = @"My Model Name";
    self.model = model;
    
}

- (IBAction)dumpModelToConsole:(id)sender
{
    CVModel* model = self.model;
    
    if (nil == model)
    {
        NSLog(@"Model: %@", nil);
        return;
    }
    
    CVGeometry* geometry = model.geometry;
    NSLog(@"Model: %@\n\tName: %@\n\tGeometry: %@\n\t\tposition: %@\n\t\tsize: %@\n\t\tangle: %g\n\taltSize: %@",
          model,
          model.name,
          geometry,
          geometry ? NSStringFromPoint(geometry.position) : @"<Geometry null>",
          geometry ? NSStringFromSize(geometry.size) : @"<Geometry null>",
          geometry ? geometry.angle : 0.0,
          NSStringFromSize(model.altSize));
}

@end
