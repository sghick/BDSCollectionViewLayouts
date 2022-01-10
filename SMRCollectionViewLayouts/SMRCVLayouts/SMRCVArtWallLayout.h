//
//  SMRCVArtWallLayout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SMRCVArtWallLayout;
@protocol SMRCVArtWallLayoutDelegate <NSObject>

@required
/** 返回item的size */
- (CGSize)artWallLayout:(SMRCVArtWallLayout *)layout sizeForItemAtIndex:(NSUInteger)index;

@optional
/** 返回item上下左右偏移量 */
- (CGPoint)artWallLayout:(SMRCVArtWallLayout *)layout offsetForItemAtIndex:(NSUInteger)index;

@end

@interface SMRCVArtWallLayout : UICollectionViewLayout

@property (weak  , nonatomic) id<SMRCVArtWallLayoutDelegate> delegate;

@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@property (assign, nonatomic) NSInteger visibleItemsCount;
@property (assign, nonatomic) CGFloat minScale;

/** 仅当加载过才会返回对应实例 */
- (nullable UICollectionViewLayoutAttributes *)attributeAtIndex:(NSInteger)index;
/** 返回一个艺术墙的随机偏移量 */
- (CGPoint)offsetWithSeedAttr:(UICollectionViewLayoutAttributes *)seedAttr;

@end

NS_ASSUME_NONNULL_END
