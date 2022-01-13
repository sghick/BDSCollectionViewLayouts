//
//  SMRCVSliderArcLayout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/10.
//

#import "SMRCVSliderArcLayout.h"
#import "UICollectionViewLayout+SMR.h"

@interface SMRCVSliderArcLayout ()

@property (assign, nonatomic) CGFloat contentWidth;
@property (strong, nonatomic) NSArray<UICollectionViewLayoutAttributes *> *attrs;

@end

@implementation SMRCVSliderArcLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.attrs = [self attributesInSection:0];
    self.contentWidth = self.itemsCount*self.itemSize.width;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.contentWidth, 0);
}

- (NSInteger)currentPage {
    return MAX(floor(self.contentOffset.x / self.itemSize.width), 0);
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath cache:(nonnull NSMutableDictionary *)cache {
    UICollectionViewLayoutAttributes *attris = cache[@(indexPath.item)];
    if (!attris) {
        UICollectionViewLayoutAttributes *last = cache[@(indexPath.item - 1)];
        attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGRect frame = attris.frame;
        CGFloat centerY = self.contentOffset.y + self.collectionViewSize.height/2;
        
        frame.size = self.itemSize;
        
        if (last) {
            frame.origin.x = CGRectGetMaxX(last.frame);
        }
        
        attris.frame = frame;
        attris.center = CGPointMake(attris.center.x, centerY);
        cache[@(indexPath.item)] = attris;
    }
    return attris;
}

@end
