//
//  SMRCVLayoutController.h
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SMRCVLayoutProtocol <NSObject>

- (UICollectionViewLayout *)collectionViewLayout;

@end

@interface SMRCVLayoutController : UIViewController<
SMRCVLayoutProtocol,
UICollectionViewDataSource,
UICollectionViewDelegate
>

@end

NS_ASSUME_NONNULL_END
