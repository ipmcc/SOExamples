//
//  ProjectViewController.m
//  SOOutlineViewDemo
//
//  Created by Ian McCullough on 12/28/12.
//  Copyright (c) 2012 Ian McCullough. All rights reserved.
//

#import "ProjectViewController.h"

@interface ProjectViewController () {
    NSMutableArray* _objects;
}
@property (nonatomic, retain, readwrite) NSMutableArray* objects;
@end

@implementation ProjectViewController

@synthesize objects = _objects;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Initialization code here.
        // Setting default path to the local file or directory
        NSString *home = NSHomeDirectory();
        content = [[NSURL alloc] initFileURLWithPath:home];
        
        [self defineContentNSOutlineView];
        NSLog(@"Array: %@",_objects);
        
        // Basic сonfiguration an instance NSOutlineView
        [self configurationNSOutlineView];
    }
    return self;
}

// nodes have 3 keys: title, url, icon
- (NSArray*)p_childrenForNode: (NSMutableDictionary*)node {
    if (nil == node)
        return self.objects;
    
    NSArray* retVal = nil;
    if (nil == (retVal = [node valueForKey: @"children"]))
    {
        NSMutableArray* children = [NSMutableArray array];
        for (NSURL* urlInDir in [[NSFileManager defaultManager] contentsOfDirectoryAtURL: [node objectForKey: @"url"]
                                                           includingPropertiesForKeys: [NSArray arrayWithObjects: NSURLNameKey, NSURLEffectiveIconKey, nil]
                                                                              options: 0
                                                                                error: NULL])
        {
            id name = [urlInDir getResourceValue: &name forKey: NSURLNameKey error: NULL] ? name : @"<Couldn't get name>";
            id icon = [urlInDir getResourceValue: &icon forKey: NSURLEffectiveIconKey error: NULL] ? icon : nil;

            NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithObjectsAndKeys: urlInDir, @"url", name, @"title", nil];
            
            if (icon)
                [dict setObject: icon forKey: @"icon"];
            
            [children addObject: dict];
        }
        
        retVal = children;
        
        if (children)
            [node setValue: children forKey: @"children"];
    }
    return retVal;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    NSMutableDictionary* itemDict = (NSMutableDictionary*)item;
    NSArray* children = [self p_childrenForNode: itemDict];
    return children.count > index ? [[[children objectAtIndex: index] retain] autorelease] : nil;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    NSMutableDictionary* itemDict = (NSMutableDictionary*)item;
    NSArray* children = [self p_childrenForNode: itemDict];
    return children.count > 0;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    NSMutableDictionary* itemDict = (NSMutableDictionary*)item;
    NSArray* children = [self p_childrenForNode: itemDict];
    NSInteger retVal = children.count;
    return retVal;
}

- (id)outlineView:(NSOutlineView *)pOutlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {

    NSImage* icon = [item objectForKey: @"icon"];
    NSString* title = [item objectForKey: @"title"];
    id value = nil;
    
    if (icon) {
        [icon setSize: NSMakeSize(pOutlineView.rowHeight - 2, pOutlineView.rowHeight - 2)];
        NSTextAttachment* attachment = [[[NSTextAttachment alloc] init] autorelease];
        [(NSCell *)[attachment attachmentCell] setImage: icon];
        NSMutableAttributedString *aString = [[[NSAttributedString attributedStringWithAttachment:attachment] mutableCopy] autorelease];
        [[aString mutableString] appendFormat: @" %@", title];
        value = aString;
    } else {
        value = title;
    }
    
    return value;
}

- (void)defineContentNSOutlineView {
    // Make root object
    NSMutableDictionary* rootObj = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"FINDER", @"title",
                                    content, @"url",
                                    nil];
    
    id icon = [content getResourceValue: &icon forKey: NSURLEffectiveIconKey error: NULL] ? icon : nil;
    if (icon)
        [rootObj setObject: icon forKey: @"icon"];
    
    // Set it
    self.objects = [NSMutableArray arrayWithObject: rootObj];
}

- (void)configurationNSOutlineView {
    [outlineView sizeLastColumnToFit];
    [outlineView setFloatsGroupRows:NO];
    [outlineView reloadData];
    [outlineView expandItem:nil expandChildren:YES];
}

@end
