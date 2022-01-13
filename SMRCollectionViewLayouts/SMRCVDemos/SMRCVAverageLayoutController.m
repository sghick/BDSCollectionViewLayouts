//
//  SMRCVAverageLayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/10.
//

#import "SMRCVAverageLayoutController.h"
#import "SMRCVAverageLayout.h"

@interface SMRCVAverageLayoutController ()<
SMRCVAverageLayoutDelegate>

@end

@implementation SMRCVAverageLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionViewHeight = 200;
}

#pragma mark - SMRCVLineLayoutDelegate

- (CGSize)layout:(SMRCVAverageLayout *)layout sizeForItemAtIndex:(NSUInteger)index {
    return CGSizeMake(arc4random()%150 + 30, 50);
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVAverageLayout *layout = [[SMRCVAverageLayout alloc] init];
    layout.delegate = self;
    layout.edgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.lineSpacing = 10;
    layout.interitemSpacing = 20;
    layout.numberOfLines = 2;
//    layout.lineMaxCount = 13;
    return layout;
}

@end
