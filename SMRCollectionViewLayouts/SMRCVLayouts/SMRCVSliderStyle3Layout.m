//
//  SMRCVSliderStyle3Layout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderStyle3Layout.h"

@interface SMRCVSliderStyle3Layout ()

@property (assign, nonatomic) NSInteger half;

@end

@implementation SMRCVSliderStyle3Layout

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
    
    NSRange range = NSMakeRange(currentPage, MIN(visibleItemsCount, itemsCount));
    NSArray *arr = [self attributesInSection:0 range:range];
    return arr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger currentPage = self.currentPage;
    CGPoint contentOffset = self.contentOffset;
    CGFloat offset = (int)(contentOffset.x)%(int)(self.collectionViewSize.width);
    CGFloat offsetProgress = offset/self.collectionViewSize.width*1.0f;
    CGFloat spacing = self.spacing;
    CGSize collectionViewSize = self.collectionViewSize;
    CGSize itemSize = self.itemSize;
    NSInteger half = self.half;
    
    UICollectionViewLayoutAttributes *attributes =
    [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    
    // -2,-1,0,1,2
    NSInteger visibleIndex = indexPath.item - currentPage - half;
    attributes.size = itemSize;
    CGFloat topCardMidX = contentOffset.x + collectionViewSize.width/2;
    attributes.center = CGPointMake(topCardMidX + spacing*visibleIndex, collectionViewSize.height/2);
    CGFloat scale = [self p_scaleForVisibleIndex:visibleIndex offsetProgress:offsetProgress];
    CGFloat step = [self p_stepForVisibleIndex:visibleIndex offsetProgress:offsetProgress];
    NSInteger level = ceil(scale*100);
    attributes.zIndex = 1000 + level;
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    attributes.center = CGPointMake(attributes.center.x + attributes.size.width*(1 - step)/2 - spacing*offsetProgress, attributes.center.y);
    return attributes;
}

#pragma mark - Privates

- (CGFloat)p_scaleForVisibleIndex:(NSInteger)visibleIndex
                   offsetProgress:(CGFloat)offsetProgress {
    CGFloat step = (1.0 - self.minScale)/self.half*1.0;
    if (visibleIndex > 0) {
        CGFloat scale = (1.0 - visibleIndex*step + step*offsetProgress);
        return scale;
    } else if (visibleIndex < 0) {
        offsetProgress = 1 - offsetProgress;
        CGFloat scale = (1.0 + (visibleIndex - 1)*step + step*offsetProgress);
        return scale;
    } else {
        return 1 - step*offsetProgress;
    }
}

- (CGFloat)p_stepForVisibleIndex:(NSInteger)visibleIndex
                  offsetProgress:(CGFloat)offsetProgress {
    CGFloat step = (1.0 - self.minScale)/self.half*1.0;
    CGFloat scale = (1.0 - visibleIndex*step + step*offsetProgress);
    return scale;
}

/** @override */
- (void)resetPageIndexForLoopable:(NSInteger)itemsCount pageIndex:(NSInteger)pageIndex {
    NSInteger revisedPageIndex = [self revisedPageIndex:pageIndex itemsCount:itemsCount];
    [super resetPageIndexForLoopable:itemsCount pageIndex:revisedPageIndex];
}

#pragma mark - Getters

- (NSInteger)half {
    return floor(self.visibleItemsCount/2.0);
}

- (NSInteger)revisedPageIndex:(NSInteger)pageIndex itemsCount:(NSInteger)itemsCount {
    return (itemsCount + pageIndex - self.half)%itemsCount;
}

//- (NSInteger)currentPage {
//    if (self.collectionViewSize.width == 0 || self.collectionViewSize.height == 0) {
//        return 0;
//    }
//
//    int index = 0;
//    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
//        index = (self.contentOffset.x + self.itemSize.width * 0.5) / self.itemSize.width;
//    } else {
//        index = (self.contentOffset.y + self.itemSize.height * 0.5) / self.itemSize.height;
//    }
//    return MAX(0, index);
//}

@end
