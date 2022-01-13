//
//  UICollectionViewLayout+SMR.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/7.
//

#import "UICollectionViewLayout+SMR.h"

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
