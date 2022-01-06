//
//  SMRCVSliderStyle3Layout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderStyle3Layout.h"

@interface SMRCVSliderStyle3Layout ()

@property (assign, nonatomic) CGFloat half;

@end

@implementation SMRCVSliderStyle3Layout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger itemsCount = self.itemsCount;
    NSInteger currentPage = self.currentPage;
    NSInteger visibleItemsCount = self.visibleItemsCount;
    if (itemsCount <= 0) {
        return nil;
    }
    
    NSRange range = NSMakeRange(currentPage, MIN(visibleItemsCount, itemsCount));
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
    NSMutableArray *arr = [NSMutableArray array];
    NSLog(@"page:%@", @(currentPage));
    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger realIndex = idx%itemsCount;
        NSLog(@"layout page:%@_%@", @(idx), @(realIndex));
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:realIndex inSection:0];
        UICollectionViewLayoutAttributes *attr =
        [self layoutAttributesForItemAtIndexPath:indexPath];
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
    NSInteger half = self.half;
    NSInteger itemsCount = self.itemsCount;
    
    UICollectionViewLayoutAttributes *attributes =
    [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    
    // -2,-1,0,1,2
    NSInteger visibleIndex = indexPath.item - currentPage - half;
    NSLog(@"vis:%@", @(visibleIndex));
    attributes.size = itemSize;
    CGFloat topCardMidX = contentOffset.x + collectionViewSize.width/2;
    attributes.center = CGPointMake(topCardMidX + spacing*visibleIndex, collectionViewSize.height/2);
    attributes.zIndex = 1000 - ABS(visibleIndex);
    CGFloat scale =
    [self parallaxProgressForVisibleIndex:visibleIndex
                           offsetProgress:offsetProgress
                                 minScale:minScale];
    attributes.transform = CGAffineTransformMakeScale(scale, scale);
    if (visibleIndex > 0) {
        attributes.center = CGPointMake(attributes.center.x + attributes.size.width*(1 - scale)/2 - spacing*offsetProgress, attributes.center.y);
    } else {
        attributes.center = CGPointMake(attributes.center.x + attributes.size.width*(scale - 1)/2 - spacing*offsetProgress, attributes.center.y);
    }
    return attributes;
}

- (CGFloat)parallaxProgressForVisibleIndex:(NSInteger)visibleIndex
                            offsetProgress:(CGFloat)offsetProgress
                                  minScale:(CGFloat)minScale {
    CGFloat step = (1.0 - minScale)/(self.visibleItemsCount - 1)*1.0;
    return (1.0 - ABS(visibleIndex)*step + step*offsetProgress);
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

- (CGFloat)half {
    return floor(self.visibleItemsCount/2.0);
}

@end
