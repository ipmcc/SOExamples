//
//  AppDelegate.m
//  TestSandbox
//

#import "AppDelegate.h"

@interface SOPopUpButtonCell : NSPopUpButtonCell
typedef NSTextFieldCell* (^CellFetcher)();
@property (nonatomic, copy, readwrite) CellFetcher cellFetcherBlock;
@end

@implementation AppDelegate

- (NSArray *)popUpOptions
{
    return @[
    [[[NSAttributedString alloc] initWithString: @"red" attributes: @{ NSForegroundColorAttributeName : [NSColor redColor] }] autorelease],
    [[[NSAttributedString alloc] initWithString: @"green" attributes: @{ NSForegroundColorAttributeName : [NSColor greenColor] }] autorelease],
    [[[NSAttributedString alloc] initWithString: @"blue" attributes: @{ NSForegroundColorAttributeName : [NSColor blueColor] }] autorelease]
    ];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSDictionary* line1 = [[@{ @"name" : @"Red thing", @"color" : [[[NSAttributedString alloc] initWithString: @"red" attributes: @{ NSForegroundColorAttributeName : [NSColor redColor] }] autorelease] } mutableCopy] autorelease];
    NSDictionary* line2 = [[@{ @"name" : @"Green thing", @"color" : [[[NSAttributedString alloc] initWithString: @"green" attributes: @{ NSForegroundColorAttributeName : [NSColor greenColor] }] autorelease] } mutableCopy] autorelease];
    NSDictionary* line3 = [[@{ @"name" : @"Blue thing", @"color" : [[[NSAttributedString alloc] initWithString: @"blue" attributes: @{ NSForegroundColorAttributeName : [NSColor blueColor] }] autorelease] } mutableCopy] autorelease];
    self.dataModel = @[ line1, line2, line3 ];
}

- (void)menuNeedsUpdate:(NSMenu*)menu
{
    for (NSMenuItem* item in menu.itemArray)
    {
        if ([item.representedObject isKindOfClass: [NSAttributedString class]])
        {
            item.attributedTitle = item.representedObject;
        }
    }
}

- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if (nil == tableColumn || self.popUpColumn != tableColumn)
        return nil;

    SOPopUpButtonCell* defaultCell = (SOPopUpButtonCell*)[tableColumn dataCellForRow: row];
    const NSUInteger columnIndex = [[tableView tableColumns] indexOfObject: self.surrogateColumn];
    CellFetcher f = ^{
        return (NSTextFieldCell*)[tableView preparedCellAtColumn: columnIndex row: row];
    };
    defaultCell.cellFetcherBlock = f;

    return defaultCell;
}

@end

@implementation SOPopUpButtonCell

- (void)setCellFetcherBlock:(CellFetcher)cellFetcherBlock
{
    if (_cellFetcherBlock != cellFetcherBlock)
    {
        if (_cellFetcherBlock) Block_release(_cellFetcherBlock);
        _cellFetcherBlock = cellFetcherBlock ? Block_copy(cellFetcherBlock) : nil;
    }
}

-(void)dealloc
{
    if (_cellFetcherBlock) Block_release(_cellFetcherBlock);
    [super dealloc];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    CellFetcher f = self.cellFetcherBlock;
    if (f)
    {
        self.menuItem.title = @"";
    }

    [super drawWithFrame:cellFrame inView:controlView];
    
    if (f)
    {
        NSTextFieldCell* surrogateCell = f();
        [surrogateCell drawWithFrame: cellFrame inView: controlView];
    }
}

@end