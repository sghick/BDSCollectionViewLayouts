//
//  SMRCVLineLayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/7.
//

#import "SMRCVLineLayoutController.h"
#import "SMRCVLineLayout.h"

@interface SMRCVLineLayoutController ()<
SMRCVLineLayoutDelegate>

@end

@implementation SMRCVLineLayoutController

#pragma mark - SMRCVLineLayoutDelegate

- (CGSize)lineLayout:(SMRCVLineLayout *)layout sizeForItemAtIndex:(NSUInteger)index {
    return CGSizeMake(arc4random()%150 + 30, 50);
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVLineLayout *layout = [[SMRCVLineLayout alloc] init];
    layout.delegate = self;
    layout.edgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.lineSpacing = 10;
    layout.interitemSpacing = 20;
    layout.maxWidth = [UIScreen mainScreen].bounds.size.width;
    layout.numberOfLines = 8;
    return layout;
}

@end
