//
//  SMRCVAverageLayout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SMRCVAverageLayout;
@protocol SMRCVAverageLayoutDelegate <NSObject>

@required
/** 返回item的size */
- (CGSize)layout:(SMRCVAverageLayout *)layout sizeForItemAtIndex:(NSUInteger)index;

@end

@interface SMRCVAverageLayout : UICollectionViewLayout

@property (weak  , nonatomic) id<SMRCVAverageLayoutDelegate> delegate;

@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) CGFloat interitemSpacing;

/** 默认0,不限制,按行个数进行换行 */
@property (assign, nonatomic) NSInteger lineMaxCount;
/** 默认0,不限制,平均为n行 */
@property (assign, nonatomic) NSInteger numberOfLines;

@end

NS_ASSUME_NONNULL_END
