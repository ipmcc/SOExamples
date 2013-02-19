//
//  LineItem+Additions.m
//  SOTotal
//
//  Created by Ian McCullough on 2/18/13.
//  Copyright (c) 2013 FooBar. All rights reserved.
//

#import "LineItem+Additions.h"

@implementation LineItem (Additions)

+ (NSSet*)keyPathsForValuesAffectingTotal
{
    return [NSSet setWithArray: @[ @"amount", @"price" ]];
}

- (NSNumber*)total
{
    NSNumber* amount = self.amount;
    NSNumber* price = self.price;
    double amountDbl = amount ? [amount doubleValue] : 0.0;
    double priceDbl = price ? [price doubleValue] : 0.0;
    return [NSNumber numberWithDouble: amountDbl * priceDbl];
}

@end
