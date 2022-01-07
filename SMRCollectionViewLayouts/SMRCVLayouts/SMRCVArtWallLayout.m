//
//  SMRCVArtWallLayout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/6.
//

#import "SMRCVArtWallLayout.h"
#import "UICollectionViewLayout+SMR.h"

@interface SMRCVArtWallLayout ()

@property (assign, nonatomic) CGFloat contentWidth;
@property (strong, nonatomic) NSMutableDictionary<NSNumber *, UICollectionViewLayoutAttributes *> *cache;
@property (strong, nonatomic) NSArray<UICollectionViewLayoutAttributes *> *attrs;

@end

@implementation SMRCVArtWallLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.attrs = [self attributesInSection:0];
    UICollectionViewLayoutAttributes *last = self.attrs.lastObject;
    self.contentWidth = MAX(self.collectionViewSize.width, CGRectGetMaxX(last.frame));
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.contentWidth, 0);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs = self.cache[@(indexPath.item)];
    if (!attrs) {
        UICollectionViewLayoutAttributes *last = self.cache[@(indexPath.item - 1)];
        attrs = [super layoutAttributesForItemAtIndexPath:indexPath];
        
        CGRect frame = attrs.frame;
        CGFloat centerY = self.contentOffset.y + self.collectionViewSize.height/2;
        if ([self.delegate respondsToSelector:@selector(artWallLayout:sizeForItemAtIndex:)]) {
            frame.size = [self.delegate artWallLayout:self sizeForItemAtIndex:indexPath.item];
            frame.origin.x = CGRectGetMaxX(last.frame);
        }
        
        CGPoint offset = CGPointZero;
        if ([self.delegate respondsToSelector:@selector(artWallLayout:offsetForItemAtIndex:)]) {
            offset = [self.delegate artWallLayout:self offsetForItemAtIndex:indexPath.item];
        } else {
            offset = [self offsetWithSeedAttr:last ?: attrs];
        }
        
        attrs.frame = frame;
        attrs.center = CGPointMake(attrs.center.x + offset.x, centerY + offset.y);
        self.cache[@(indexPath.item)] = attrs;
    }
    return attrs;
}

#pragma mark - Utils

- (UICollectionViewLayoutAttributes *)attributeAtIndex:(NSInteger)index {
    return self.cache[@(index)];
}

- (CGPoint)offsetWithSeedAttr:(UICollectionViewLayoutAttributes *)seedAttr {
    if (!seedAttr) return CGPointZero;
    CGFloat width = CGRectGetWidth(seedAttr.frame);
    CGFloat height = CGRectGetHeight(seedAttr.frame);
    CGFloat x = [self p_offsetWithin:height/3 seed:arc4random()];
    CGFloat y = [self p_offsetWithin:width/3 seed:arc4random()];
    return CGPointMake(x, y);
}

#pragma mark - Privates

- (NSInteger)p_offsetWithin:(NSInteger)within seed:(NSInteger)seed {
    return seed%(2*within) - within;
}

#pragma mark - Getters

- (NSMutableDictionary<NSNumber *,UICollectionViewLayoutAttributes *> *)cache {
    if (!_cache) {
        _cache = [NSMutableDictionary dictionary];
    }
    return _cache;
}

@end
