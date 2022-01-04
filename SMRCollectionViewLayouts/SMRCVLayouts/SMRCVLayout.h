//
//  SMRCVLayout.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMRCVLayout : UICollectionViewLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)loadAttributesInSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END
