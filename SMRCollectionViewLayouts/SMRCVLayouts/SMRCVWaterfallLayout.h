//
//  SMRCVWaterfallLayout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SMRCVWaterfallLayout;
@protocol SMRCVWaterfallLayoutDelegate <NSObject>

- (CGFloat)waterfallLayout:(SMRCVWaterfallLayout *)waterfallLayout
      heightForItemAtIndex:(NSUInteger)index
                 itemWidth:(CGFloat)itemWidth;

@end

@interface SMRCVWaterfallLayout : UICollectionViewLayout

@property (weak  , nonatomic) id<SMRCVWaterfallLayoutDelegate> delegate;

@property (assign, nonatomic) NSInteger columnCount;
@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) CGFloat interitemSpacing;
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

@end

NS_ASSUME_NONNULL_END
