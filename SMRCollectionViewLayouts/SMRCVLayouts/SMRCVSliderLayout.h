//
//  SMRCVSliderLayout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMRCVSliderLayout : UICollectionViewFlowLayout

@property (assign, nonatomic, readonly) NSInteger itemsCount;
@property (assign, nonatomic, readonly) CGSize collectionViewSize;
@property (assign, nonatomic, readonly) CGPoint contentOffset;
@property (assign, nonatomic, readonly) NSInteger currentPage;

@end

NS_ASSUME_NONNULL_END
