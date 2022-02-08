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
@property (strong, nonatomic) NSArray *attrs;

@property (strong, nonatomic) NSMutableArray *queue;

@end

@implementation SMRCVArtWallLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.attrs = [self attributesInSection:0];
    UICollectionViewLayoutAttributes *last = self.attrs.lastObject;
    self.contentWidth = CGRectGetMaxX(last.frame) + self.edgeInsets.right;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.contentWidth, 0);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath cache:(nonnull NSMutableDictionary *)cache {
    UICollectionViewLayoutAttributes *attrs = cache[@(indexPath.item)];
    if (!attrs) {
        UICollectionViewLayoutAttributes *last = cache[@(indexPath.item - 1)];
        attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGRect frame = attrs.frame;
        CGFloat centerY = self.contentOffset.y + self.collectionViewSize.height/2;
        if ([self.delegate respondsToSelector:@selector(layout:sizeForItemAtIndex:)]) {
            frame.size = [self.delegate layout:self sizeForItemAtIndex:indexPath.item];
        }
        
        if (!last) {
            frame.origin.x = self.edgeInsets.left;
        } else {
            frame.origin.x = CGRectGetMaxX(last.frame);
        }
        
        CGPoint offset = CGPointZero;
        if ([self.delegate respondsToSelector:@selector(layout:offsetForItemAtIndex:)]) {
            offset = [self.delegate layout:self offsetForItemAtIndex:indexPath.item];
        } else {
            offset = [self offsetWithSeedAttr:last ?: attrs];
        }
        
        attrs.frame = frame;
        attrs.center = CGPointMake(attrs.center.x + offset.x, centerY + offset.y);
                
        cache[@(indexPath.item)] = attrs;
    }
    return attrs;
}

#pragma mark - Utils

- (CGPoint)offsetWithSeedAttr:(UICollectionViewLayoutAttributes *)seedAttr {
    if (!seedAttr) return CGPointZero;
    CGFloat width = CGRectGetWidth(seedAttr.frame) ?: self.collectionViewSize.height/2;
    CGFloat height = CGRectGetHeight(seedAttr.frame);
    CGFloat x = [self p_offsetWithin:height/3 seed:arc4random()];
    CGFloat y = [self p_offsetWithin:width/3 seed:arc4random()];
    return CGPointMake(x, y);
}

#pragma mark - Privates

- (NSInteger)p_offsetWithin:(NSInteger)within seed:(NSInteger)seed {
    if (within <= 0) {
        return 0;
    }
    return seed%(2*within) - within;
}

#pragma mark - Getters

- (NSMutableArray *)cache {
    if (!_queue) {
        _queue = [NSMutableArray array];
    }
    return _queue;
}

@end
