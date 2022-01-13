//
//  SMRCVSquareLayout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SMRCVSquareLayout;
@protocol SMRCVSquareLayoutDelegate <NSObject>

- (void)layout:(SMRCVSquareLayout *)layout ;

@end

@interface SMRCVSquareLayout : UICollectionViewLayout

@property (weak  , nonatomic) id<SMRCVSquareLayoutDelegate> delegate;

@property (assign, nonatomic) UICollectionViewScrollDirection scrollDirection;
/** 整块size,可包含任意个小的模块 */
@property (assign, nonatomic) CGSize moduleSize;
@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) CGFloat interitemSpacing;

@end

NS_ASSUME_NONNULL_END
