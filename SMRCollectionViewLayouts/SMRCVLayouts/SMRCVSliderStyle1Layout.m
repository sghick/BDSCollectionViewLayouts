//
//  SMRCVSliderStyle1Layout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderStyle1Layout.h"
#import "UICollectionViewLayout+SMR.h"

@implementation SMRCVSliderStyle1Layout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionViewSize.width * self.itemsCount,
                      self.collectionViewSize.height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger itemsCount = self.itemsCount;
    NSInteger currentPage = self.currentPage;
    NSInteger visibleItemsCount = self.visibleItemsCount;
    if (itemsCount <= 0) {
        return nil;
    }
    
    NSRange range = NSMakeRange(currentPage, MIN(visibleItemsCount, itemsCount - currentPage));
    NSArray *arr = [self attributesInSection:0 range:range];
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
    CGPoint itemOffset = self.itemOffset;
    
    UICollectionViewLayoutAttributes *attributes =
    [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    
    NSInteger visibleIndex = MAX(indexPath.item - currentPage, 0);
    attributes.size = itemSize;
    CGFloat topCardMidX = contentOffset.x + collectionViewSize.width/2;
    attributes.center = CGPointMake(topCardMidX + spacing*visibleIndex + itemOffset.x, collectionViewSize.height/2 + itemOffset.y);
    attributes.zIndex = 1000 - visibleIndex;
    CGFloat scale =
    [self p_scaleForVisibleIndex:visibleIndex
                  offsetProgress:offsetProgress
                        minScale:minScale];
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    if (visibleIndex == 0) {
        attributes.center = CGPointMake(attributes.center.x - offset, attributes.center.y);
    } else {
        attributes.center = CGPointMake(attributes.center.x + attributes.size.width * (1 - scale)/2 - spacing * offsetProgress, attributes.center.y);
    }
    return attributes;
}

#pragma mark - Privates

- (CGFloat)p_scaleForVisibleIndex:(NSInteger)visibleIndex
                   offsetProgress:(CGFloat)offsetProgress
                         minScale:(CGFloat)minScale {
    CGFloat step = (1.0 - minScale)/(self.visibleItemsCount - 1)*1.0;
    return (1.0 - visibleIndex*step + step*offsetProgress);
}

@end
