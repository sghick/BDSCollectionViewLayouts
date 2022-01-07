//
//  SMRCVArtWallLayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/6.
//

#import "SMRCVArtWallLayoutController.h"
#import "SMRCVArtWallLayout.h"

@interface SMRCVArtWallLayoutController ()

@end

@implementation SMRCVArtWallLayoutController

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVArtWallLayout *layout = [[SMRCVArtWallLayout alloc] init];
    return layout;
}

@end
