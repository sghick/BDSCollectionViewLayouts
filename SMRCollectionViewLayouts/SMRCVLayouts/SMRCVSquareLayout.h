//
//  SMRCVSquareLayout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SMRCVSquareLayout;
typedef void(^SMRCVLayoutBlock)(SMRCVSquareLayout *layout, UICollectionViewLayoutAttributes *attrs, NSIndexPath *indexPath);

@interface SMRCVSquareLayout : UICollectionViewLayout

/** layout时,改变attris属性即可进行布局 */
@property (copy  , nonatomic) SMRCVLayoutBlock layoutBlock;

@property (assign, nonatomic) UICollectionViewScrollDirection scrollDirection;

@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@property (assign, nonatomic) CGFloat spacing;
@property (assign, nonatomic) CGSize moduleSize;
@property (assign, nonatomic) CGFloat moduleLineSpacing;
@property (assign, nonatomic) CGFloat moduleInteritemSpacing;

+ (SMRCVLayoutBlock)defaultSquareLayoutBlock;

@end

NS_ASSUME_NONNULL_END
