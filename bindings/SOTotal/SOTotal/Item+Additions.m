//
//  Item+Additions.m
//  SOTotal
//
//  Created by Ian McCullough on 2/18/13.
//  Copyright (c) 2013 FooBar. All rights reserved.
//

#import "Item+Additions.h"

@implementation Item (Additions)

// This doesn't work because it seems that the core data sets don't support collection operators.
//
// I get this error:
//  [<_NSFaultingMutableSet 0x101922270> addObserver:forKeyPath:options:context:] is not supported. Key path: @sum.total

//+ (NSSet *)keyPathsForValuesAffectingLineItemTotal
//{
//    return [NSSet setWithObject: @"items.@sum.total"];
//}
//
//- (NSNumber*)lineItemTotal
//{
//    return [self valueForKeyPath: @"items.@sum.total"];
//}

@end
