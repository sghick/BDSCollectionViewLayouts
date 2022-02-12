//
//  UICollectionViewLayout+SMR.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewLayout (SMR)

@property (assign, nonatomic, readonly) NSInteger itemsCount; ///< 获取section:0时的itemCount
@property (assign, nonatomic, readonly) CGSize collectionViewSize;
@property (assign, nonatomic, readonly) CGPoint contentOffset;
@property (assign, nonatomic, readonly) NSInteger currentPage;

- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section;
- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section range:(NSRange)range;

- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section cache:(nullable NSMutableDictionary *)cache;
- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section range:(NSRange)range cache:(nullable NSMutableDictionary *)cache;

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath cache:(nonnull NSMutableDictionary *)cache;

@end

@interface UICollectionViewLayout (SMRLoopable)

/**
 返回itemsCount的n倍,在下面方法中调用
 - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
 */
- (NSInteger)itemsCountForLoopable:(NSInteger)itemsCount;

/**
 如果在reload之后需要调用时, 请在主线程中异步执行此方法,
 如:
 dispatch_async(dispatch_get_main_queue(), ^{
     [self.layout initPageIndexForLoopable];
 });
 */
- (void)resetPageIndexForLoopable:(NSInteger)itemsCount;
- (void)resetPageIndexForLoopable:(NSInteger)itemsCount pageIndex:(NSInteger)pageIndex;

/**
 判断是否需要reset,推荐在下面方法中调用,
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
     [self.layout resetPageIndexForLoopableIfNeeded:self.items.count];
 }
 */
- (void)resetPageIndexForLoopableIfNeeded:(NSInteger)itemsCount;
- (void)resetPageIndexForLoopableIfNeeded:(NSInteger)itemsCount pageIndex:(NSInteger)pageIndex;

/**
 滑动到指定页
 */
- (void)scrollToLastIndexWithAnimated:(BOOL)animated itemsCount:(NSInteger)itemsCount;
- (void)scrollToNextIndexWithAnimated:(BOOL)animated itemsCount:(NSInteger)itemsCount;
- (void)scrollToIndex:(NSInteger)toIndex animated:(BOOL)animated itemsCount:(NSInteger)itemsCount;

@end

@interface UICollectionViewLayoutAttributes (SMRLoopable)

@property (assign, nonatomic) NSInteger looperIndex;

@end

NS_ASSUME_NONNULL_END
