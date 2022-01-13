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
/** 整块size,可包含任意个小的模块 */
@property (assign, nonatomic) CGSize moduleSize;
@property (assign, nonatomic) CGFloat moduleLineSpacing;
@property (assign, nonatomic) CGFloat moduleInteritemSpacing;
@property (assign, nonatomic) UIEdgeInsets moduleInsets;

@end

NS_ASSUME_NONNULL_END
