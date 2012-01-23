//
//  CVModel.h
//  CVTest
//
//  Created by Ian McCullough on 1/23/12.
//

@class CVGeometry;

@interface CVModel : NSObject
{
    NSString* mName;
    CVGeometry* mGeometry;
    NSSize mAltSize;
}

@property (nonatomic, readwrite, copy) NSString* name;
@property (nonatomic, readwrite, retain) CVGeometry* geometry;
@property (nonatomic, readwrite, assign) NSSize altSize;

@end

@interface CVGeometry : NSObject
{
    NSPoint mPosition;
    NSSize mSize;
    CGFloat mAngle;
}

@property (nonatomic, readwrite, assign) NSPoint position;
@property (nonatomic, readwrite, assign) NSSize size;
@property (nonatomic, readwrite, assign) CGFloat angle;

- (id)initWithPosition: (NSPoint)position size: (NSSize)size angle: (CGFloat)angle;

@end
