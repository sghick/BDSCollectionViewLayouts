//
//  SMRCVSliderStyle3LayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderStyle3LayoutController.h"
#import "SMRCVSliderStyle3Layout.h"

@interface SMRCVSliderStyle3LayoutController ()

@end

@implementation SMRCVSliderStyle3LayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionViewHeight = 250;
    self.collectionView.pagingEnabled = YES;
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVSliderStyle3Layout *layout = [[SMRCVSliderStyle3Layout alloc] init];
    layout.itemSize = CGSizeMake(240, 240);
    layout.visibleItemsCount = 5;
    layout.spacing = 20;
    layout.minScale = 0.7;
    return layout;
}

@end
