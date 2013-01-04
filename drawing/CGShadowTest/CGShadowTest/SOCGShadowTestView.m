//
//  SOCGShadowTestView.m
//  CGShadowTest
//
//  Created by Ian McCullough on 1/4/13.
//  Copyright (c) 2013 Ian McCullough. All rights reserved.
//

#import "SOCGShadowTestView.h"

@implementation SOCGShadowTestView

- (void)drawRect:(CGRect)rect
{
    const NSUInteger numCells = 5;
    const CGFloat fillAlpha = 0.5;
    const CGFloat drawingAreaDimension = MIN(self.bounds.size.height / numCells, MIN(self.bounds.size.width, self.bounds.size.height));
    const CGFloat hOffset = MAX(0, (self.bounds.size.width - drawingAreaDimension) / 2.);
    const CGFloat vOffset = MAX(0, ((self.bounds.size.height / numCells) - drawingAreaDimension) / 2.);
    
    NSUInteger cellIndex = 0;
    
    CGContextRef c = UIGraphicsGetCurrentContext();

    // Draw just the stroke with a shadow
    CGContextSaveGState(c);
    {
        // Get into the right place
        CGContextTranslateCTM(c, hOffset, cellIndex++ * (self.bounds.size.height / numCells) + vOffset);
        CGContextScaleCTM(c, drawingAreaDimension / 110. , drawingAreaDimension / 110.);
        
        CGContextSetLineWidth(c, 2);
        CGContextSetStrokeColorWithColor(c, [[UIColor whiteColor] CGColor]);
        CGContextSetShadowWithColor(c, CGSizeMake(0, 5), 5.0, [[UIColor blackColor]CGColor]);
        CGContextSetFillColorWithColor(c, [[UIColor colorWithWhite:1.0 alpha: fillAlpha] CGColor]);
        
        // Sample Path
        CGContextMoveToPoint(c, 20.0, 10.0);
        CGContextAddLineToPoint(c, 100.0, 40.0);
        CGContextAddLineToPoint(c, 40.0, 70.0);
        CGContextClosePath(c);
        
        CGContextDrawPath(c, kCGPathStroke);
    }
    CGContextRestoreGState(c);

    // Draw the original way
    CGContextSaveGState(c);
    {
        // Get into the right place
        CGContextTranslateCTM(c, hOffset, cellIndex++ * (self.bounds.size.height / numCells) + vOffset);
        CGContextScaleCTM(c, drawingAreaDimension / 110. , drawingAreaDimension / 110.);
        
        CGContextSetLineWidth(c, 2);
        CGContextSetStrokeColorWithColor(c, [[UIColor whiteColor] CGColor]);
        CGContextSetShadowWithColor(c, CGSizeMake(0, 5), 5.0, [[UIColor blackColor]CGColor]);
        CGContextSetFillColorWithColor(c, [[UIColor colorWithWhite:1.0 alpha: fillAlpha] CGColor]);
        
        // Sample Path
        CGContextMoveToPoint(c, 20.0, 10.0);
        CGContextAddLineToPoint(c, 100.0, 40.0);
        CGContextAddLineToPoint(c, 40.0, 70.0);
        CGContextClosePath(c);
        
        CGContextDrawPath(c, kCGPathFillStroke);
    }
    CGContextRestoreGState(c);

    // Draw with no shadow
    CGContextSaveGState(c);
    {
        // Get into the right place
        CGContextTranslateCTM(c, hOffset, cellIndex++ * (self.bounds.size.height / numCells) + vOffset);
        CGContextScaleCTM(c, drawingAreaDimension / 110. , drawingAreaDimension / 110.);
        
        CGContextSetLineWidth(c, 2);
        CGContextSetStrokeColorWithColor(c, [[UIColor whiteColor] CGColor]);
        CGContextSetFillColorWithColor(c, [[UIColor colorWithWhite:1.0 alpha: fillAlpha] CGColor]);
        
        // Sample Path
        CGContextMoveToPoint(c, 20.0, 10.0);
        CGContextAddLineToPoint(c, 100.0, 40.0);
        CGContextAddLineToPoint(c, 40.0, 70.0);
        CGContextClosePath(c);
        
        CGContextDrawPath(c, kCGPathFillStroke);
    }
    CGContextRestoreGState(c);

    // Draw just the shadow
    CGContextSaveGState(c);
    {
        // Get into the right place
        CGContextTranslateCTM(c, hOffset, cellIndex++ * (self.bounds.size.height / numCells) + vOffset);
        CGContextScaleCTM(c, drawingAreaDimension / 110. , drawingAreaDimension / 110.);
        
        CGSize deviceOffset = CGContextConvertSizeToDeviceSpace(c, CGSizeMake(drawingAreaDimension*2., 0));
        CGContextTranslateCTM(c, -drawingAreaDimension*2., 0);
        
        CGContextSetLineWidth(c, 2);
        CGContextSetStrokeColorWithColor(c, [[UIColor whiteColor] CGColor]);
        CGContextSetShadowWithColor(c, CGSizeMake(deviceOffset.width, 5), 5.0, [[UIColor blackColor]CGColor]);
        CGContextSetFillColorWithColor(c, [[UIColor colorWithWhite:1.0 alpha: fillAlpha] CGColor]);
        
        // Sample Path
        CGContextMoveToPoint(c, 20.0, 10.0);
        CGContextAddLineToPoint(c, 100.0, 40.0);
        CGContextAddLineToPoint(c, 40.0, 70.0);
        CGContextClosePath(c);
        
        CGContextDrawPath(c, kCGPathFillStroke);
    }
    CGContextRestoreGState(c);

    // Draw David's way
    CGContextSaveGState(c);
    {
        // Get into the right place
        CGContextTranslateCTM(c, hOffset, cellIndex++ * (self.bounds.size.height / numCells) + vOffset);
        CGContextScaleCTM(c, drawingAreaDimension / 110. , drawingAreaDimension / 110.);

        CGContextSetLineWidth(c, 2);
        CGContextSetStrokeColorWithColor(c, [[UIColor whiteColor] CGColor]);
        CGContextSetFillColorWithColor(c, [[UIColor colorWithWhite:1.0 alpha:fillAlpha] CGColor]);
        
        // Sample Path
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 20.0, 10.0);
        CGPathAddLineToPoint(path, NULL, 40.0, 70.0);
        CGPathAddLineToPoint(path, NULL, 100.0, 40.0);
        CGPathCloseSubpath(path);
        
        // Save the state so we can undo the shadow and clipping later
        CGContextSaveGState(c);
        { // Only for readability (so we know what are inside the save/restore scope
            CGContextSetShadowWithColor(c, CGSizeMake(0, 5), 5.0, [[UIColor blackColor]CGColor]);
            CGFloat width = CGRectGetWidth(self.frame);
            CGFloat height = CGRectGetHeight(self.frame);
            
            // Create a mask that covers the entire frame
            CGContextMoveToPoint(c, 0, 0);
            CGContextAddLineToPoint(c, width, 0);
            CGContextAddLineToPoint(c, width, height);
            CGContextAddLineToPoint(c, 0, height);
            CGContextClosePath(c);
            
            // Add the path (which by even-odd rule will remove it)
            CGContextAddPath(c, path);
            
            // Clip to that path (drawing will only happen outside our path)
            CGContextClip(c);
            
            // Now draw the path in the clipped context
            CGContextAddPath(c, path);
            CGContextDrawPath(c, kCGPathFillStroke);
        }
        CGContextRestoreGState(c); // Go back to before the clipping and before the shadow
        
        // Draw the path without the shadow to get the transparent fill
        CGContextAddPath(c, path);
        CGContextDrawPath(c, kCGPathFillStroke);
        CGPathRelease(path);
        
    }
    CGContextRestoreGState(c);
    
}

@end
