//
//  SMRCVAverageLayout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/10.
//

#import "SMRCVAverageLayout.h"
#import "UICollectionViewLayout+SMR.h"

@interface SMRCVAverageLayout ()

@property (assign, nonatomic) CGFloat contentWidth;
@property (assign, nonatomic) CGFloat contentHeight;
@property (strong, nonatomic) NSMutableDictionary<NSNumber *, UICollectionViewLayoutAttributes *> *cache;
@property (strong, nonatomic) NSMutableIndexSet *cachedIndexset;
@property (strong, nonatomic) NSArray<UICollectionViewLayoutAttributes *> *attrs;

@property (assign, nonatomic) CGFloat p_maxWidth;       // 最大宽,临时变量
@property (assign, nonatomic) CGFloat p_lineMaxHeight;  // 当前行最大高,临时变量

@end

@implementation SMRCVAverageLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.attrs = [self attributesInSection:0];
    UICollectionViewLayoutAttributes *last = self.attrs.lastObject;
    self.contentWidth = self.p_maxWidth + self.edgeInsets.right;
    self.contentHeight = CGRectGetMaxY(last.frame) + self.edgeInsets.bottom;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.contentWidth, self.contentHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section {
    NSArray<UICollectionViewLayoutAttributes *> *attris = [super attributesInSection:section];
    CGFloat maxWidth = (CGRectGetMaxX(attris.lastObject.frame) + self.edgeInsets.right);
    NSInteger lineMaxCount = self.lineMaxCount;
    if (self.numberOfLines > 0) {
        maxWidth /= self.numberOfLines;
    }
    NSInteger itemsCount = self.itemsCount;
    for (int i = 0; i < itemsCount; i++) {
        [self p_layoutAverageAttributesForItemAtIndex:i maxWidth:maxWidth lineMaxCount:lineMaxCount];
    }
    return attris;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attris = self.cache[@(indexPath.item)];
    if (!attris) {
        UICollectionViewLayoutAttributes *last = self.cache[@(indexPath.item - 1)];
        attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGRect frame = attris.frame;
        if ([self.delegate respondsToSelector:@selector(averageLayout:sizeForItemAtIndex:)]) {
            frame.size = [self.delegate averageLayout:self sizeForItemAtIndex:indexPath.item];
            frame.origin.x = CGRectGetMaxX(last.frame);
        }
        
        // 第一个
        if (!last) {
            frame.origin.y = self.edgeInsets.top;
            frame.origin.x = self.edgeInsets.left;
        } else {
            frame.origin.x = CGRectGetMaxX(last.frame) + self.lineSpacing;
            frame.origin.y = last.frame.origin.y;
        }
        
        attris.frame = frame;
        self.cache[@(indexPath.item)] = attris;
    }
    return attris;
}

#pragma mark - Privates

- (void)p_layoutAverageAttributesForItemAtIndex:(NSInteger)index maxWidth:(CGFloat)maxWidth lineMaxCount:(NSInteger)lineMaxCount {
    UICollectionViewLayoutAttributes *attris = self.cache[@(index)];
    if (attris && ![self.cachedIndexset containsIndex:index]) {
        UICollectionViewLayoutAttributes *last = self.cache[@(index - 1)];
        
        CGRect frame = attris.frame;
        
        // 第一个
        if (!last) {
            frame.origin.y = self.edgeInsets.top;
            frame.origin.x = self.edgeInsets.left;
            self.p_lineMaxHeight = 0;
        } else {
            frame.origin.x = CGRectGetMaxX(last.frame) + self.lineSpacing;
            frame.origin.y = last.frame.origin.y;
            self.p_lineMaxHeight = MAX(self.p_lineMaxHeight, frame.size.height);
        }
        
        // 判断是否需要折行(延迟折行)
        CGFloat preMaxX = CGRectGetMaxX(last.frame) + self.edgeInsets.right;
        if (((maxWidth > 0) && (preMaxX > maxWidth)) ||
            ((lineMaxCount > 0) && (index%lineMaxCount == 0))) {
            frame.origin.x = self.edgeInsets.left;
            frame.origin.y += self.p_lineMaxHeight + self.interitemSpacing;
            self.p_lineMaxHeight = frame.size.height;
        }
        
        self.p_maxWidth = MAX(self.p_maxWidth, CGRectGetMaxX(frame));
        attris.frame = frame;
        
        [self.cachedIndexset addIndex:index];
    }
}

#pragma mark - Getters

- (NSMutableDictionary<NSNumber *,UICollectionViewLayoutAttributes *> *)cache {
    if (!_cache) {
        _cache = [NSMutableDictionary dictionary];
    }
    return _cache;
}

- (NSMutableIndexSet *)cachedIndexset {
    if (!_cachedIndexset) {
        _cachedIndexset = [NSMutableIndexSet indexSet];
    }
    return _cachedIndexset;
}

@end
