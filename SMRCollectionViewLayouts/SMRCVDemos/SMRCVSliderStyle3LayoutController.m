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
    frame = CGRectMake(0, 0, frame.size.width, 200);
    self.collectionView.frame = frame;
    self.collectionView.center = self.view.center;
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVSliderStyle3Layout *layout = [[SMRCVSliderStyle3Layout alloc] init];
    layout.itemSize = CGSizeMake(300, 200);
    layout.visibleItemsCount = 3;
    return layout;
}

@end
