//
//  SMRCVSliderLayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/31.
//

#import "SMRCVSliderLayoutController.h"
#import "SMRCVSliderLayout.h"

@interface SMRCVSliderLayoutController ()

@end

@implementation SMRCVSliderLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVSliderLayout *viewLayout = [[SMRCVSliderLayout alloc] init];
    viewLayout.itemSize = CGSizeMake(300, 200);
    viewLayout.visibleItemsCount = 4;
    viewLayout.spacing = 11;
    viewLayout.minScale = 0.8;
    return viewLayout;
}

@end
