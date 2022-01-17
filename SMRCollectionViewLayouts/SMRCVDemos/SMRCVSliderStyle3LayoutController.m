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
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView.collectionViewLayout resetPageIndexForLoopable:self.dataSource.count];
    });
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [collectionView.collectionViewLayout itemsCountForLoopable:self.dataSource.count];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.collectionView.collectionViewLayout resetPageIndexForLoopableIfNeeded:self.dataSource.count];
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
