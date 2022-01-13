//
//  SMRCVSquareLayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import "SMRCVSquareLayoutController.h"
#import "SMRCVSquareLayout.h"

@interface SMRCVSquareLayoutController ()

@end

@implementation SMRCVSquareLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVSquareLayout *viewLayout = [[SMRCVSquareLayout alloc] init];
    viewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    viewLayout.moduleSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
    viewLayout.edgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    viewLayout.interitemSpacing = 10;
    viewLayout.lineSpacing = 10;
    return viewLayout;
}

@end
