//
//  SMRCVSliderArcLayout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMRCVSliderArcLayout : UICollectionViewFlowLayout

@property (assign, nonatomic) NSInteger visibleItemsCount;
@property (assign, nonatomic) CGFloat minScale;
@property (assign, nonatomic) CGFloat spacing;

@end

NS_ASSUME_NONNULL_END
