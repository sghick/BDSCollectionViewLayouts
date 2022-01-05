//
//  SMRCVSliderStyle1Layout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderLayout.h"

NS_ASSUME_NONNULL_BEGIN

/**
 请设置itemSize,且collectionView的高不能超过itemSize.height的2倍
 */
@interface SMRCVSliderStyle1Layout : SMRCVSliderLayout

@property (assign, nonatomic) NSInteger visibleItemsCount;
@property (assign, nonatomic) CGFloat minScale;
@property (assign, nonatomic) CGFloat spacing;

@end

NS_ASSUME_NONNULL_END
