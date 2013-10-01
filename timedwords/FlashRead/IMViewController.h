//
//  IMViewController.h
//  FlashRead
//
//  Created by Ian McCullough on 10/1/13.
//  Copyright (c) 2013 Ian McCullough. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMViewController : UIViewController

@property (nonatomic,readwrite,assign) IBOutlet UILabel* wordLabel;
@property (nonatomic,readwrite,assign) IBOutlet UIButton* startStop;

@property (nonatomic, readwrite, assign) BOOL running;

- (IBAction)toggleRunning: (id)sender;

- (void)addWord: (NSString*)word;

@end
