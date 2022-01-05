//
//  SMRCVSliderLayout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/31.
//

#import "SMRCVSliderLayout.h"

@interface SMRCVSliderLayout ()

@end

@implementation SMRCVSliderLayout

- (void)prepareLayout {
    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionViewSize.width * self.itemsCount,
                      self.collectionViewSize.height);
}

#pragma mark - Getters

- (NSInteger)itemsCount {
    return [self.collectionView numberOfItemsInSection:0];
}

- (CGSize)collectionViewSize {
    return self.collectionView.bounds.size;
}

- (CGPoint)contentOffset {
    return self.collectionView.contentOffset;
}

- (NSInteger)currentPage {
    return MAX(floor(self.contentOffset.x / self.collectionViewSize.width), 0);
}

@end
