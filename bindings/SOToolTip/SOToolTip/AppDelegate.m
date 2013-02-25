//
//  AppDelegate.m
//  SOToolTip
//
//  Created by Ian McCullough on 2/25/13.
//  Copyright (c) 2013 FooBar. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate () <NSTableViewDelegate>
@end

@implementation AppDelegate

- (NSArray *)model
{
    return @[ @{ @"name" : @"foo", @"tooltip" : @"fooToolTip" },
              @{ @"name" : @"bar", @"tooltip" : @"barToolTip" },
              @{ @"name" : @"baz", @"tooltip" : @"bazToolTip" } ];
}

- (NSString *)tableView:(NSTableView *)tableView toolTipForCell:(NSCell *)cell rect:(NSRectPointer)rect tableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row mouseLocation:(NSPoint)mouseLocation;
{
    return [[self.model objectAtIndex: row] objectForKey: @"tooltip"];
}

@end
