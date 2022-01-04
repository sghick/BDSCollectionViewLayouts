//
//  SMRCVSliderStyle2LayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderStyle2LayoutController.h"
#import "SMRCVSliderStyle2Layout.h"

@interface SMRCVSliderStyle2LayoutController ()

@end

@implementation SMRCVSliderStyle2LayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVSliderStyle2Layout *layout = [[SMRCVSliderStyle2Layout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(300, 200);
    return layout;
}

@end
