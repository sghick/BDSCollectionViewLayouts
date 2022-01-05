//
//  SMRCVSliderStyle2Layout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderLayout.h"

NS_ASSUME_NONNULL_BEGIN

/**
 请设置itemSize,且collectionView的高不能超过itemSize.height的2倍
 */
@interface SMRCVSliderStyle2Layout : SMRCVSliderLayout

@property (assign, nonatomic) CGFloat scaleRate; ///< 默认1.4, (0, n),值越大,变化幅度越大

@end

NS_ASSUME_NONNULL_END
