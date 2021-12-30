//
//  SMRCVLineLayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import "SMRCVLineLayoutController.h"
#import "SMRCVLineLayout.h"

@interface SMRCVLineLayoutController ()

@end

@implementation SMRCVLineLayoutController

#pragma mark - SMRCVLayoutProtocol

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVLineLayout *viewLayout = [[SMRCVLineLayout alloc] init];
    viewLayout.itemSize = CGSizeMake(150, 150);
    viewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGFloat insert =
    ([UIScreen mainScreen].bounds.size.width - viewLayout.itemSize.width)/2;
    viewLayout.sectionInset = UIEdgeInsetsMake(0, insert, 0, insert);
    viewLayout.minimumLineSpacing = 50.0;
    return viewLayout;
}

@end
