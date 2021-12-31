//
//  SMRCVWaterfallLayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import "SMRCVWaterfallLayoutController.h"
#import "SMRCVWaterfallLayout.h"

@interface SMRCVWaterfallLayoutController ()<
SMRCVWaterfallLayoutDelegate>

@end

@implementation SMRCVWaterfallLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (CGFloat)waterfallLayout:(SMRCVWaterfallLayout *)waterfallLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    CGFloat height = arc4random()%200 + 80;
    return height;
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVWaterfallLayout *viewLayout = [[SMRCVWaterfallLayout alloc] init];
    viewLayout.delegate = self;
    viewLayout.columnCount = 3;
    viewLayout.lineSpacing = 10;
    viewLayout.interitemSpacing = 20;
    viewLayout.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    return viewLayout;
}

@end
