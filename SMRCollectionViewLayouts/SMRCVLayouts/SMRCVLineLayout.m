//
//  SMRCVLineLayout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/7.
//

#import "SMRCVLineLayout.h"
#import "UICollectionViewLayout+SMR.h"

@interface SMRCVLineLayout ()

@property (assign, nonatomic) CGFloat contentWidth;
@property (assign, nonatomic) CGFloat contentHeight;
@property (strong, nonatomic) NSMutableDictionary<NSNumber *, UICollectionViewLayoutAttributes *> *cache;
@property (strong, nonatomic) NSArray<UICollectionViewLayoutAttributes *> *attrs;

@property (assign, nonatomic) CGFloat p_numberOfLine;   // 当前最大行数,临时变量
@property (assign, nonatomic) CGFloat p_lineMaxHeight;  // 当前行最大高,临时变量

@end

@implementation SMRCVLineLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.p_numberOfLine = 0;
    self.p_lineMaxHeight = 0;
    self.cache = nil;
    self.attrs = [self attributesInSection:0];
    UICollectionViewLayoutAttributes *last = self.attrs.lastObject;
    self.contentWidth = CGRectGetMaxX(last.frame) + self.edgeInsets.right;
    self.contentHeight = CGRectGetMaxY(last.frame) + self.edgeInsets.bottom;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.contentWidth, self.contentHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attris = self.cache[@(indexPath.item)];
    if (!attris) {
        UICollectionViewLayoutAttributes *last = self.cache[@(indexPath.item - 1)];
        attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGRect frame = attris.frame;
        if ([self.delegate respondsToSelector:@selector(lineLayout:sizeForItemAtIndex:)]) {
            frame.size = [self.delegate lineLayout:self sizeForItemAtIndex:indexPath.item];
            frame.origin.x = CGRectGetMaxX(last.frame);
        }
        
        // 第一个
        if (!last) {
            frame.origin.y = self.edgeInsets.top;
            frame.origin.x = self.edgeInsets.left;
            self.p_lineMaxHeight = 0;
            self.p_numberOfLine = 0;
        } else {
            frame.origin.x = CGRectGetMaxX(last.frame) + self.lineSpacing;
            frame.origin.y = last.frame.origin.y;
            self.p_lineMaxHeight = MAX(self.p_lineMaxHeight, frame.size.height);
        }
        
        // 判断是否需要折行
        CGFloat preMaxX = CGRectGetMaxX(frame) + self.edgeInsets.right;
        if ((self.maxWidth > 0) && (preMaxX > self.maxWidth)) {
            frame.origin.x = self.edgeInsets.left;
            frame.origin.y += self.p_lineMaxHeight + self.interitemSpacing;
            self.p_lineMaxHeight = frame.size.height;
            self.p_numberOfLine++;
        }
        
        attris.frame = frame;
        self.cache[@(indexPath.item)] = attris;
    }
    
    // 判断是否超出行限制
    if ((self.numberOfLines > 0) && (self.numberOfLines <= self.p_numberOfLine)) {
        return nil;
    }
    return attris;
}

#pragma mark - Getters

- (NSMutableDictionary<NSNumber *,UICollectionViewLayoutAttributes *> *)cache {
    if (!_cache) {
        _cache = [NSMutableDictionary dictionary];
    }
    return _cache;
}

@end
