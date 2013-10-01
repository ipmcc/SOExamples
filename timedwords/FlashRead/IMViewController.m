//
//  IMViewController.m
//  FlashRead
//
//  Created by Ian McCullough on 10/1/13.
//  Copyright (c) 2013 Ian McCullough. All rights reserved.
//

#import "IMViewController.h"

// A utility function to push things over to the main thread if necessary
static void dispatch_sync_main_thread(dispatch_block_t block);

@interface IMViewController ()
@end

@implementation IMViewController
{
    dispatch_queue_t mQueue;
    NSUInteger mWordCount;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wordLabel.text = nil;
}

// Calculate the duration for which a given word should be shown.
- (NSTimeInterval)delayForWord: (NSString*)word
{
    return 0.05 * word.length;
}

- (void)p_ensureQueue
{
    dispatch_sync_main_thread(^{
        if (!mQueue)
        {
            dispatch_queue_t queue = dispatch_queue_create("wordQueue", DISPATCH_QUEUE_SERIAL);
            // Target the main queue
            dispatch_set_target_queue(queue, dispatch_get_main_queue());
            // If we create the queue, suspend it we can queue up words without starting
            dispatch_suspend(queue);

            mQueue = queue;
        }
    });
}

- (IBAction)toggleRunning: (id)sender
{
    if (!self.running)
    {
        // This is just some throwaway code to get some words in.
        NSArray* sampleWords = [@"The quick brown fox jumped over the lazy dog." componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [sampleWords enumerateObjectsUsingBlock:^(NSString* word, NSUInteger idx, BOOL *stop) {
            [self addWord: word];
        }];
    }
    
    self.running = !self.running;
    
    if (self.running)
    {
        // Set button to stop
        [self.startStop setTitle:@"Stop" forState:UIControlStateNormal];
        
        // Ensure the queue exists
        [self p_ensureQueue];
        
        // resume the queue
        dispatch_resume(mQueue);
    }
    else
    {
        // Get rid of the queue
        mQueue = nil;
        
        // Clear any visible word
        [self p_presentWord: nil];
        
        // Change the button text
        [self.startStop setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (void)p_presentWord: (NSString*)word
{
    dispatch_sync_main_thread(^{
        // Update contents of UILabel
        self.wordLabel.text = word;
        
        // This is time sensitive, don't defer...
        [self.wordLabel.layer displayIfNeeded];
    });
}

- (void)addWord: (NSString*)word
{
    dispatch_sync_main_thread(^{
        // Ensure the queue
        [self p_ensureQueue];

        // Capture the queue separately from self->mQueue so we can detect if it's changed as a cancellation condition
        dispatch_queue_t wordEnqueuedTo = mQueue;
        // Capture the current word count, so we can know if we've displayed the last enqueued word
        NSUInteger wordCount = ++mWordCount;
        
        dispatch_async(wordEnqueuedTo, ^{
            // Check our cancel condition
            if (self->mQueue != wordEnqueuedTo)
            {
                //NSLog(@"Clearing word for cancellation");
                [self p_presentWord: nil];
                return;
            }

            // Suspend the queue
            dispatch_suspend(wordEnqueuedTo);
            
            // Show the word...
            //NSLog([NSString stringWithFormat: @"Showing word: %@", word]);
            [self p_presentWord: word];
            
            // Calculate the delay until the next word should be shown...
            const NSTimeInterval timeToShow = [self delayForWord: word];
            
            // Have dispatch_after call us after that amount of time to resume the wordQueue.
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeToShow * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // Remove the current word
                if (wordCount == mWordCount && self.running)
                {
                    //NSLog(@"Clearing word for timeout; no new words to display");
                    [self toggleRunning: self];
                }
                // Resume the queue to present the next word
                dispatch_resume(wordEnqueuedTo);
            });
        });
    });
}


@end

static void dispatch_sync_main_thread(dispatch_block_t block)
{
    if ([NSThread isMainThread])
        block();
    else
        dispatch_sync(dispatch_get_main_queue(), block);
}


