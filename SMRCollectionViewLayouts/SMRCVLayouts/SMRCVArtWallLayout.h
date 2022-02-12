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

/**
 是否无限循环,默认Yes,此功能暂时不完善,目前只适配无限的
 设置为无限时,请保证数据源个数大于一次性加载的最大个数,
 且必须是原数据源个数的倍数,推荐为数据源的5-10倍
 */
@property (assign, nonatomic) BOOL infiniteLoop;
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

/** 返回一个艺术墙的随机偏移量 */
- (CGPoint)offsetWithSeedAttr:(UICollectionViewLayoutAttributes *)seedAttr;

@end

NS_ASSUME_NONNULL_END
