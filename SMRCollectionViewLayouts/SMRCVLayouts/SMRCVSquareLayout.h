//
//  SMRCVSquareLayout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMRCVSquareLayout : UICollectionViewLayout

@property (assign, nonatomic) UICollectionViewScrollDirection scrollDirection;

@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) CGFloat interitemSpacing;

@end

NS_ASSUME_NONNULL_END
