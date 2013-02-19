//
//  SOAppDelegate.h
//  SOTotal
//
//  Created by Ian McCullough on 2/18/13.
//  Copyright (c) 2013 FooBar. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SOAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSArrayController *itemsArrayController;
@property (assign) IBOutlet NSArrayController *lineItemsArrayController;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
