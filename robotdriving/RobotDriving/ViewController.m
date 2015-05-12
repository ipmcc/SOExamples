//
//  ViewController.m
//  RobotDriving
//
//

#import "ViewController.h"

typedef NS_ENUM(NSUInteger, DRCommandType) {
    DRCommandUnknown = 0,
    DRCommandTypeForward = 1,
    DRCommandTypeBackward = 2,
};

@interface DRCommand : NSObject
@property DRCommandType type;
@property NSTimeInterval duration;
@end

@implementation DRCommand
@end

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *commandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsRemainingLabel;

@property (strong, atomic) DRCommand* currentlyExecutingCommand;
@property (copy, atomic) NSNumber* currentCommandStarted;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do an initial UI update
    [self updateUI];
}

- (IBAction)loadCommands:(id)sender
{
    DRCommand *C1 = [[DRCommand alloc] init];
    C1.duration = 3.0;
    C1.type = DRCommandTypeForward;

    DRCommand *C2 = [[DRCommand alloc] init];
    C2.duration = 3.0;
    C2.type = DRCommandTypeBackward;
    
    [self handleCommands: @[ C1, C2 ]];
}

- (void)handleCommands: (NSArray*)commands
{
    // For safety... it could be a mutable array that the caller could continue to mutate
    commands = [commands copy];
    
    // This queue will do all our actual work
    dispatch_queue_t execQueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    // We'll target the main queue because it simplifies the updating of the UI
    dispatch_set_target_queue(execQueue, dispatch_get_main_queue());

    // We'll use this queue to serve commands one at a time...
    dispatch_queue_t latchQueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    // Have it target the execQueue; Not strictly necessary but codifies the relationship
    dispatch_set_target_queue(latchQueue, execQueue);
    
    // This timer will update our UI at 60FPS give or take, on the main thread.
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, (1.0/60.0) * NSEC_PER_SEC, (1.0/30.0) * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{ [self updateUI]; });
    
    // Suspend the latch queue until we're ready to go
    dispatch_suspend(latchQueue);
    
    // The first thing to do for this command stream is to start UI updates
    dispatch_async(latchQueue, ^{ dispatch_resume(timer); });

    // Next enqueue each command in the array
    for (DRCommand* cmd in commands)
    {
        dispatch_async(latchQueue, ^{
            // Stop the queue from processing other commands.
            dispatch_suspend(latchQueue);

            // Update the "machine state"
            self.currentlyExecutingCommand = cmd;
            self.currentCommandStarted = @([NSDate timeIntervalSinceReferenceDate]);
            
            // Set up the event that'll mark the end of the command.
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(cmd.duration * NSEC_PER_SEC)), execQueue, ^{
                // Clear out the machine state for the next command
                self.currentlyExecutingCommand = nil;
                self.currentCommandStarted = nil;
                
                // Resume the latch queue so that the next command starts
                dispatch_resume(latchQueue);
            });
        });
    }

    // After all the commands have finished, add a cleanup block to stop the timer, and
    // make sure the UI doesn't have stale text in it.
    dispatch_async(latchQueue, ^{
        dispatch_source_cancel(timer);
        [self updateUI];
    });
    
    // Everything is queued up, so start the command queue
    dispatch_resume(latchQueue);
}

- (void)updateUI
{
    // Make sure we only ever update the UI on the main thread.
    if (![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^{ [self updateUI]; });
        return;
    }
    
    DRCommand* currentCmd = self.currentlyExecutingCommand;
    switch (currentCmd.type)
    {
        case DRCommandUnknown:
            self.commandNameLabel.text = @"None";
            break;
        case DRCommandTypeForward:
            self.commandNameLabel.text = @"Forward";
            break;
        case DRCommandTypeBackward:
            self.commandNameLabel.text = @"Backward";
            break;
    }
    
    NSNumber* startTime = self.currentCommandStarted;
    if (!startTime || !currentCmd)
    {
        self.secondsRemainingLabel.text = @"";
    }
    else
    {
        const NSTimeInterval startTimeDbl = startTime.doubleValue;
        const NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
        const NSTimeInterval duration = currentCmd.duration;
        const NSTimeInterval remaining = MAX(0, startTimeDbl + duration - currentTime);
        self.secondsRemainingLabel.text = [NSString stringWithFormat: @"%1.3g", remaining];
    }
}

@end
