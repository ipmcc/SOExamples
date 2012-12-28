//
//  ProjectViewController.h
//  SOOutlineViewDemo
//
//  Created by Ian McCullough on 12/28/12.
//  Copyright (c) 2012 Ian McCullough. All rights reserved.
//

@interface ProjectViewController : NSViewController <NSOutlineViewDataSource, NSObject>
{
    IBOutlet NSOutlineView          *outlineView;
    NSURL                           *content;
}

@end
