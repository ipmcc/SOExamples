//
//  CVValueTransformers.m
//  CVTest
//
//  Created by Ian McCullough on 1/23/12.
//

#import "CVValueTransformers.h"

@implementation CVPointTransformer 

+ (Class)transformedValueClass // class of the "output" objects, as returned by transformedValue:
{
    return [NSMutableDictionary class];
}

+ (BOOL)allowsReverseTransformation    // flag indicating whether transformation is read-only or not
{
    return YES;
}

- (id)transformedValue:(id)value           // by default returns value
{
    NSPoint point = [(NSValue*)value pointValue];
    
    id retVal = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithDouble: point.x], @"x", [NSNumber numberWithDouble: point.y], @"y", nil];
    
    return retVal;
}

- (id)reverseTransformedValue:(id)value    // by default raises an exception if +allowsReverseTransformation returns NO and otherwise invokes transformedValue:
{
    NSDictionary* dict = (NSDictionary*)value;
    NSPoint ptVal = NSZeroPoint;
    ptVal.x = [[dict objectForKey: @"x"] doubleValue];
    ptVal.y = [[dict objectForKey: @"y"] doubleValue];
    
    NSValue* retVal = [NSValue valueWithPoint: ptVal];
    return retVal;
}

@end

@implementation CVSizeTransformer

+ (Class)transformedValueClass // class of the "output" objects, as returned by transformedValue:
{
    return [NSMutableDictionary class];
}

+ (BOOL)allowsReverseTransformation    // flag indicating whether transformation is read-only or not
{
    return YES;
}

- (id)transformedValue:(id)value           // by default returns value
{
    NSSize size = [(NSValue*)value sizeValue];
    
    id retVal = [NSMutableDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithDouble: size.width], @"width", [NSNumber numberWithDouble: size.height], @"height", nil];
    
    return retVal;
}

- (id)reverseTransformedValue:(id)value    // by default raises an exception if +allowsReverseTransformation returns NO and otherwise invokes transformedValue:
{
    NSDictionary* dict = (NSDictionary*)value;
    NSSize szVal = NSZeroSize;
    szVal.width = [[dict objectForKey: @"width"] doubleValue];
    szVal.height = [[dict objectForKey: @"height"] doubleValue];
    
    NSValue* retVal = [NSValue valueWithSize: szVal];
    return retVal;
}

@end
