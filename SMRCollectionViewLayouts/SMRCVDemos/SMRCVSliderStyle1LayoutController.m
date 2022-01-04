//
//  SMRCVSliderStyle1LayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderStyle1LayoutController.h"
#import "SMRCVSliderStyle1Layout.h"

@interface SMRCVSliderStyle1LayoutController ()

@end

@implementation SMRCVSliderStyle1LayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.pagingEnabled = YES;
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVSliderStyle1Layout *layout = [[SMRCVSliderStyle1Layout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(300, 200);
    layout.visibleItemsCount = 4;
    layout.spacing = 10;
    layout.minScale = 0.8;
    return layout;
}

@end
