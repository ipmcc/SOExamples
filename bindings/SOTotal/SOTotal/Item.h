//
//  Item.h
//  SOTotal
//
//  Created by Ian McCullough on 2/18/13.
//  Copyright (c) 2013 FooBar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LineItem;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *items;
@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addItemsObject:(LineItem *)value;
- (void)removeItemsObject:(LineItem *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
