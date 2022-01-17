//
//  SMRCVSliderStyle3Layout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import <UIKit/UIKit.h>
#import "UICollectionViewLayout+SMR.h"

NS_ASSUME_NONNULL_BEGIN

/**
 请设置itemSize,且collectionView的高不能超过itemSize.height的2倍
 */
@interface SMRCVSliderStyle3Layout : UICollectionViewFlowLayout

@property (assign, nonatomic) NSInteger visibleItemsCount;
@property (assign, nonatomic) CGFloat minScale;
@property (assign, nonatomic) CGFloat spacing;

/** 矫正后的页面索引--当前正中间的item的索引 */
- (NSInteger)revisedPageIndex:(NSInteger)pageIndex itemsCount:(NSInteger)itemsCount;

@end

NS_ASSUME_NONNULL_END
