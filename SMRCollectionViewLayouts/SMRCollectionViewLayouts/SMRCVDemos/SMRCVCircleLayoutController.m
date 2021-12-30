//
//  SMRCVCircleLayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import "SMRCVCircleLayoutController.h"
#import "SMRCVCircleLayout.h"

@interface SMRCVCircleLayoutController ()

@end

@implementation SMRCVCircleLayoutController

#pragma mark - SMRCVLayoutProtocol

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVCircleLayout *viewLayout = [[SMRCVCircleLayout alloc] init];
    return viewLayout;
}

@end
