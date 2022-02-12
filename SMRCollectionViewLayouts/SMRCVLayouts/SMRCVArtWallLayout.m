//
//  SMRCVArtWallLayout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/6.
//

#import "SMRCVArtWallLayout.h"

@interface SMRCVArtWallLayout ()

@property (assign, nonatomic) CGFloat contentWidth;
@property (strong, nonatomic) NSArray *attrs;
@property (strong, nonatomic) NSMutableDictionary *cache;

@end

@implementation SMRCVArtWallLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        _infiniteLoop = YES;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    CGRect initRect = CGRectMake(0, 0,
                                 CGRectGetWidth(self.collectionView.frame),
                                 CGRectGetHeight(self.collectionView.frame));
    self.attrs = [self layoutAttributesForElementsInRect:initRect];
    self.contentWidth = 0;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(CGFLOAT_MAX, 0);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    UICollectionViewLayoutAttributes *head = self.attrs.firstObject ?: [self p_layoutZeroAttributes];
    UICollectionViewLayoutAttributes *foot = self.attrs.lastObject ?: [self p_layoutZeroAttributes];
    UICollectionViewLayoutAttributes *last =
    [self p_layoutLastAttributesForItem:head inRect:rect cache:self.cache];
    UICollectionViewLayoutAttributes *next =
    [self p_layoutNextAttributesForItem:foot inRect:rect cache:self.cache];
    NSUInteger left = last.looperIndex;
    NSUInteger right = next.looperIndex;
    NSRange range = NSMakeRange(left, right - left + 1);
    self.attrs = [self attributesInSection:0 range:range cache:self.cache];
    UICollectionViewLayoutAttributes *nlast = self.attrs.lastObject;
    self.contentWidth = MAX(CGRectGetMaxX(nlast.frame), self.contentWidth) + self.collectionViewSize.width;
    return self.attrs;
}

/** 返回第0个 */
- (UICollectionViewLayoutAttributes *)p_layoutZeroAttributes {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    UICollectionViewLayoutAttributes *item =
    [self layoutAttributesForItemAtIndexPath:indexPath cache:self.cache];
    return item;
}

/** 递归寻找当前rect中左边最适合的item,超出范围时多加载1个即可 */
- (UICollectionViewLayoutAttributes *)p_layoutLastAttributesForItem:(UICollectionViewLayoutAttributes *)item inRect:(CGRect)rect cache:(nonnull NSMutableDictionary *)cache {
    // 如果item为空,则返回第0个
    if (!item) {
        return [self p_layoutZeroAttributes];
    }
    // 如果已经是最左边一个,则直接返回自己
    if (item.looperIndex == 0) {
        return item;
    }
    // 取出左边一个
    NSIndexPath *lastIndexPath =
    [NSIndexPath indexPathForItem:item.looperIndex - 1 inSection:item.indexPath.section];
    UICollectionViewLayoutAttributes *last =
    [self layoutAttributesForItemAtIndexPath:lastIndexPath cache:cache];
    CGFloat maxX = CGRectGetMaxX(last.frame);
    // 左边一个在屏幕中显示,则再取左边一个
    if (maxX >= CGRectGetMinX(rect)) {
        return [self p_layoutLastAttributesForItem:last inRect:rect cache:cache];
    }
    return last;
}

/** 递归寻找当前rect中右边最适合的item,超出范围时多加载1个即可 */
- (UICollectionViewLayoutAttributes *)p_layoutNextAttributesForItem:(UICollectionViewLayoutAttributes *)item inRect:(CGRect)rect cache:(nonnull NSMutableDictionary *)cache {
    // 如果item为空,则返回第0个
    if (!item) {
        return [self p_layoutZeroAttributes];
    }
    // 如果已经是最右边一个,则直接返回自己
    if (!self.infiniteLoop &&
        (item.looperIndex == (self.itemsCount - 1))) {
        return item;
    }
    // 取出右边一个
    NSIndexPath *nextIndexPath =
    [NSIndexPath indexPathForItem:item.looperIndex + 1 inSection:item.indexPath.section];
    UICollectionViewLayoutAttributes *next =
    [self layoutAttributesForItemAtIndexPath:nextIndexPath cache:cache];
    CGFloat minX = CGRectGetMinX(next.frame);
    // 右边一个在屏幕中显示,则再取右边一个
    if (minX <= CGRectGetMaxX(rect)) {
        return [self p_layoutNextAttributesForItem:next inRect:rect cache:cache];
    }
    return next;
}

/** 此时的indexPath并非实际的indexPath,取cell时需要转换成实际的indexPath */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath cache:(nonnull NSMutableDictionary *)cache {
    NSInteger looperIndex = indexPath.item;
    UICollectionViewLayoutAttributes *attrs = cache[@(looperIndex)];
    if (!attrs) {
        NSLog(@"layout:%@", @(indexPath.item));
        UICollectionViewLayoutAttributes *last = cache[@(looperIndex - 1)];
        NSInteger mIndex = looperIndex%self.itemsCount;
        NSIndexPath *mIndexPath = [NSIndexPath indexPathForItem:mIndex inSection:0];
        attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:mIndexPath];
        attrs.looperIndex = looperIndex;
        CGRect frame = attrs.frame;
        CGFloat centerY = self.contentOffset.y + self.collectionViewSize.height/2;
        if ([self.delegate respondsToSelector:@selector(layout:sizeForItemAtIndex:)]) {
            frame.size = [self.delegate layout:self sizeForItemAtIndex:mIndex];
        }
        
        if (!last) {
            frame.origin.x = self.edgeInsets.left;
        } else {
            frame.origin.x = CGRectGetMaxX(last.frame);
        }
        
        CGPoint offset = CGPointZero;
        if ([self.delegate respondsToSelector:@selector(layout:offsetForItemAtIndex:)]) {
            offset = [self.delegate layout:self offsetForItemAtIndex:mIndex];
        } else {
            offset = [self offsetWithSeedAttr:last ?: attrs];
        }
        
        attrs.frame = frame;
        attrs.center = CGPointMake(attrs.center.x + offset.x, centerY + offset.y);
                
        cache[@(looperIndex)] = attrs;
    } else {
        NSLog(@"layout cache:%@", @(indexPath.item));
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

- (NSMutableDictionary *)cache {
    if (!_cache) {
        _cache = [NSMutableDictionary dictionary];
    }
    return _cache;
}

@end
