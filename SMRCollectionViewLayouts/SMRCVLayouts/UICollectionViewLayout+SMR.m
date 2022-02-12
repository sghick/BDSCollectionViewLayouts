//
//  UICollectionViewLayout+SMR.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/7.
//

#import "UICollectionViewLayout+SMR.h"
#import <objc/runtime.h>

@implementation UICollectionViewLayout (SMR)

#pragma mark - Utils

- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section {
    return [self attributesInSection:section cache:nil];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section
                                                               range:(NSRange)range {
    return [self attributesInSection:section range:range cache:nil];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section cache:(NSMutableDictionary *)cache {
    return [self attributesInSection:section range:NSMakeRange(0, self.itemsCount) cache:cache];
}
- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section range:(NSRange)range cache:(NSMutableDictionary *)cache {
    if (!cache) {
        cache = [NSMutableDictionary dictionary];
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = range.location; i < (range.location + range.length); i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        UICollectionViewLayoutAttributes *attr =
        [self layoutAttributesForItemAtIndexPath:indexPath cache:cache];
        attr ? [arr addObject:attr] : NULL;
    }
    return [arr copy];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath cache:(NSMutableDictionary *)cache {
    return [self layoutAttributesForItemAtIndexPath:indexPath];
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

/** 循环实现时,数据源的倍数 */
static NSInteger _multiple = 500;
static NSInteger _less_multiple = 299;
static NSInteger _center_multiple = 300;
static NSInteger _more_multiple = 301;

@implementation UICollectionViewLayout (SMRLoopable)

- (NSInteger)itemsCountForLoopable:(NSInteger)itemsCount {
    return itemsCount*_multiple;
}

- (void)resetPageIndexForLoopable:(NSInteger)itemsCount {
    [self resetPageIndexForLoopable:itemsCount pageIndex:self.currentPage];
}
- (void)resetPageIndexForLoopable:(NSInteger)itemsCount pageIndex:(NSInteger)pageIndex {
    [self p_setPageToIndex:pageIndex itemsCount:itemsCount];
}

- (void)resetPageIndexForLoopableIfNeeded:(NSInteger)itemsCount {
    [self resetPageIndexForLoopableIfNeeded:itemsCount pageIndex:self.currentPage];
}
- (void)resetPageIndexForLoopableIfNeeded:(NSInteger)itemsCount pageIndex:(NSInteger)pageIndex {
    if (self.currentPage <= itemsCount*_less_multiple ||
        self.currentPage >= itemsCount*_more_multiple) {
        [self p_setPageToIndex:pageIndex itemsCount:itemsCount];
    }
}
- (void)p_setPageToIndex:(NSInteger)toIndex itemsCount:(NSInteger)itemsCount {
    NSInteger index = toIndex%itemsCount + itemsCount*_center_multiple;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    CGPoint contentOffset = CGPointMake(self.collectionViewSize.width*index, 0);
    [self.collectionView setContentOffset:contentOffset animated:NO];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}

- (void)scrollToLastIndexWithAnimated:(BOOL)animated itemsCount:(NSInteger)itemsCount {
    [self scrollToIndex:(self.currentPage - 1) animated:animated itemsCount:itemsCount];
}
- (void)scrollToNextIndexWithAnimated:(BOOL)animated itemsCount:(NSInteger)itemsCount {
    [self scrollToIndex:(self.currentPage + 1) animated:animated itemsCount:itemsCount];
}
- (void)scrollToIndex:(NSInteger)toIndex animated:(BOOL)animated itemsCount:(NSInteger)itemsCount {
    NSInteger allCount = [self itemsCountForLoopable:itemsCount];
    if ((toIndex <= itemsCount*_less_multiple) ||
        (toIndex >= itemsCount*_more_multiple)) {
        toIndex = allCount*0.5;
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:toIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath
                                    atScrollPosition:UICollectionViewScrollPositionNone
                                            animated:NO];
        return;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:toIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath
                                atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:animated];
}

@end

@implementation UICollectionViewLayoutAttributes (SMRLoopable)

// looperIndex
static const char SMRLooperIndexKey = '\0';
- (void)setLooperIndex:(NSInteger)looperIndex {
    if (looperIndex != self.looperIndex) {
        objc_setAssociatedObject(self, &SMRLooperIndexKey, @(looperIndex), OBJC_ASSOCIATION_RETAIN);
    }
}

- (NSInteger)looperIndex {
    NSNumber *number = objc_getAssociatedObject(self, &SMRLooperIndexKey);
    if (!number) {
        return self.indexPath.item;
    }
    return number.doubleValue;
}

@end
