//
//  SMRCVArtWallLayout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/6.
//

#import <UIKit/UIKit.h>
#import "UICollectionViewLayout+SMR.h"

NS_ASSUME_NONNULL_BEGIN

@class SMRCVArtWallLayout;
@protocol SMRCVArtWallLayoutDelegate <NSObject>

@required
/** 返回item的size */
- (CGSize)layout:(SMRCVArtWallLayout *)layout sizeForItemAtIndex:(NSUInteger)index;

@optional
/** 返回item上下左右偏移量 */
- (CGPoint)layout:(SMRCVArtWallLayout *)layout offsetForItemAtIndex:(NSUInteger)index;

@end

@interface SMRCVArtWallLayout : UICollectionViewLayout

@property (weak  , nonatomic) id<SMRCVArtWallLayoutDelegate> delegate;

@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@property (assign, nonatomic) NSInteger visibleItemsCount;
@property (assign, nonatomic) CGFloat minScale;

/** 返回一个艺术墙的随机偏移量 */
- (CGPoint)offsetWithSeedAttr:(UICollectionViewLayoutAttributes *)seedAttr;

@end

NS_ASSUME_NONNULL_END
