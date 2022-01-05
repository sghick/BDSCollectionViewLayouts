//
//  SMRCVSliderStyle1Layout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderStyle1Layout.h"

@implementation SMRCVSliderStyle1Layout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger itemsCount = self.itemsCount;
    NSInteger currentPage = self.currentPage;
    NSInteger visibleItemsCount = self.visibleItemsCount;
    if (itemsCount <= 0) {
        return nil;
    }
    
    NSRange range = NSMakeRange(currentPage, MIN(visibleItemsCount, itemsCount - currentPage));
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
    NSMutableArray *arr = [NSMutableArray array];
    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger realIndex = idx%itemsCount;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:realIndex inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [arr addObject:attr];
    }];
    return arr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger currentPage = self.currentPage;
    CGPoint contentOffset = self.contentOffset;
    CGFloat offset = (int)(contentOffset.x)%(int)(self.collectionViewSize.width);
    CGFloat offsetProgress = offset/self.collectionViewSize.width*1.0f;
    CGFloat spacing = self.spacing;
    CGFloat minScale = self.minScale;
    CGSize collectionViewSize = self.collectionViewSize;
    CGSize itemSize = self.itemSize;
    
    UICollectionViewLayoutAttributes *attributes =
    [super layoutAttributesForItemAtIndexPath:indexPath];
    
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
        attributes.center = CGPointMake(attributes.center.x - offset, attributes.center.y);
    } else {
        attributes.center = CGPointMake(attributes.center.x + attributes.size.width * (1 - scale)/2 - spacing * offsetProgress, attributes.center.y);
    }
    return attributes;
}

- (CGFloat)parallaxProgressForVisibleIndex:(NSInteger)visibleIndex
                            offsetProgress:(CGFloat)offsetProgress
                                  minScale:(CGFloat)minScale {
    CGFloat step = (1.0 - minScale)/(self.visibleItemsCount - 1)*1.0;
    return (1.0 - (visibleIndex - 1) * step + step * offsetProgress);
}

@end
