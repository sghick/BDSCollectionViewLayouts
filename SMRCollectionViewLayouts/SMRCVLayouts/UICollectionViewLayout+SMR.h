//
//  UICollectionViewLayout+SMR.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewLayout (SMR)

@property (assign, nonatomic, readonly) NSInteger itemsCount; ///< 获取section:0时的itemCount
@property (assign, nonatomic, readonly) CGSize collectionViewSize;
@property (assign, nonatomic, readonly) CGPoint contentOffset;
@property (assign, nonatomic, readonly) NSInteger currentPage;

- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section;
- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section range:(NSRange)range;

- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section cache:(nullable NSMutableDictionary *)cache;
- (NSArray<UICollectionViewLayoutAttributes *> *)attributesInSection:(NSInteger)section range:(NSRange)range cache:(nullable NSMutableDictionary *)cache;

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath cache:(nonnull NSMutableDictionary *)cache;

@end

NS_ASSUME_NONNULL_END
