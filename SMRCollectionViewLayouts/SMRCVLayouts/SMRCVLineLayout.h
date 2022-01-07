//
//  SMRCVLineLayout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SMRCVLineLayout;
@protocol SMRCVLineLayoutDelegate <NSObject>

@required
/** 返回item的size */
- (CGSize)lineLayout:(SMRCVLineLayout *)layout sizeForItemAtIndex:(NSUInteger)index;

@end

@interface SMRCVLineLayout : UICollectionViewLayout

@property (weak  , nonatomic) id<SMRCVLineLayoutDelegate> delegate;

@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) CGFloat interitemSpacing;

@property (assign, nonatomic) NSInteger maxWidth;
@property (assign, nonatomic) NSInteger numberOfLines;

@end

NS_ASSUME_NONNULL_END
