//
//  SMRCVSliderStyle1Layout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderStyle1Layout.h"

@implementation SMRCVSliderStyle1Layout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    if (itemsCount <= 0) {
        return nil;
    }

    NSInteger minVisibleIndex = MAX(self.currentPage, 0);
    NSInteger contentOffset = (int)self.contentOffset.x;
    NSInteger collectionBounds = (int)self.collectionViewSize.width;
    CGFloat offset = contentOffset%collectionBounds;
    CGFloat offsetProgress = offset/self.collectionViewSize.width*1.0f;
    NSInteger maxVisibleIndex =
    MAX(MIN(itemsCount - 1, self.currentPage + self.visibleItemsCount), minVisibleIndex);

    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    for (NSInteger i = minVisibleIndex; i<= maxVisibleIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
         UICollectionViewLayoutAttributes *attributes =
        [self layoutAttributesForIndexPath:indexPath currentPage:self.currentPage offset:offset offsetProgress:offsetProgress];
        [mArr addObject:attributes];
    }
    return mArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForIndexPath:(NSIndexPath *)indexPath
                                                       currentPage:(NSInteger)currentPage
                                                            offset:(CGFloat)offset
                                                    offsetProgress:(CGFloat)offsetProgress {
    UICollectionViewLayoutAttributes *attributes =
    [[self layoutAttributesForItemAtIndexPath:indexPath] copy];
    CGFloat spacing = self.spacing;
    CGPoint contentOffset = self.contentOffset;
    CGFloat minScale = self.minScale;
    CGSize collectionViewSize = self.collectionViewSize;
    NSInteger visibleItemsCount = self.visibleItemsCount;
    CGSize itemSize = self.itemSize;
    
    NSInteger visibleIndex = MAX(indexPath.item - currentPage + 1, 0);
    attributes.size = itemSize;
    CGFloat topCardMidX = contentOffset.x + collectionViewSize.width/2;
    attributes.center = CGPointMake(topCardMidX + spacing*(visibleIndex - 1), collectionViewSize.height/2);
    attributes.zIndex = 1000 - visibleIndex;
    CGFloat scale =
    [self parallaxProgressForVisibleIndex:visibleIndex
                           offsetProgress:offsetProgress
                                 minScale:minScale];
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    if (visibleIndex == 1) {
        if (contentOffset.x >= 0) {
            attributes.center = CGPointMake(attributes.center.x - offset, attributes.center.y);
        } else {
            attributes.center = CGPointMake(attributes.center.x + attributes.size.width * (1 - scale)/2 - spacing * offsetProgress, attributes.center.y);
        }
    } else if (visibleIndex == visibleItemsCount + 1) {
        attributes.center = CGPointMake(attributes.center.x + attributes.size.width * (1 - scale)/2 - spacing, attributes.center.y);
    } else {
        attributes.center = CGPointMake(attributes.center.x + attributes.size.width * (1 - scale)/2 - spacing * offsetProgress, attributes.center.y);
    }
    return attributes;
}

#pragma mark - Utils

- (CGFloat)parallaxProgressForVisibleIndex:(NSInteger)visibleIndex
                            offsetProgress:(CGFloat)offsetProgress
                                  minScale:(CGFloat)minScale {
    CGFloat step = (1.0 - minScale)/(self.visibleItemsCount - 1)*1.0;
    return (1.0 - (visibleIndex - 1) * step + step * offsetProgress);
}

@end
