//
//  LineItem.h
//  SOTotal
//
//  Created by Ian McCullough on 2/18/13.
//  Copyright (c) 2013 FooBar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface LineItem : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) Item *item;

@end
