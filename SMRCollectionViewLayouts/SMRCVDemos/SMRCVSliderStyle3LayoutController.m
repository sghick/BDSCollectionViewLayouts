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
    CGRect frame = self.collectionView.frame;
    frame = CGRectMake(0, 0, frame.size.width, 250);
    self.collectionView.frame = frame;
    self.collectionView.center = self.view.center;
    self.collectionView.pagingEnabled = YES;
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVSliderStyle3Layout *layout = [[SMRCVSliderStyle3Layout alloc] init];
    layout.itemSize = CGSizeMake(220, 220);
    layout.visibleItemsCount = 5;
    layout.spacing = 20;
    layout.minScale = 0.9;
    return layout;
}

@end