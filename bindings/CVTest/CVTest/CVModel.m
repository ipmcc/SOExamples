//
//  CVModel.m
//  CVTest
//
//  Created by Ian McCullough on 1/23/12.
//

#import "CVModel.h"

@implementation CVGeometry

//@property (nonatomic, readwrite, assign) NSPoint poisition;
@synthesize position = mPosition;
//@property (nonatomic, readwrite, assign) NSSize size;
@synthesize size = mSize;
//@property (nonatomic, readwrite, assign) CGFloat angle;
@synthesize angle = mAngle;

- (id)initWithPosition: (NSPoint)position size: (NSSize)size angle: (CGFloat)angle
{
    if (self = [super init])
    {
        mPosition = position;
        mSize = size;
        mAngle = angle; 
    }
    return self;
}

@end

@implementation CVModel

//@property (nonatomic, readwrite, copy) NSString* name;
@synthesize name = mName;
//@property (nonatomic, readwrite, retain) CVGeometry* geometry;
@synthesize geometry = mGeometry;
//@property (nonatomic, readwrite, assign) NSSize altSize;
@synthesize altSize = mAltSize;

- (void)dealloc
{
    [mName release];
    [mGeometry release];
    [super dealloc];
}

@end
