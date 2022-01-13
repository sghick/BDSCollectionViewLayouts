//
//  SMRCVSliderArcLayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/10.
//

#import "SMRCVSliderArcLayoutController.h"
#import "SMRCVSliderArcLayout.h"

@interface SMRCVSliderArcLayoutController ()

@end

@implementation SMRCVSliderArcLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionViewHeight = 240;
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVSliderArcLayout *layout = [[SMRCVSliderArcLayout alloc] init];
    layout.itemSize = CGSizeMake(240, 240);
    layout.visibleItemsCount = 5;
    layout.spacing = 20;
    layout.minScale = 0.7;
    return layout;
}

@end
