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
    viewLayout.moduleSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
    viewLayout.moduleInsets = UIEdgeInsetsMake(20, 20, 0, 20);
    viewLayout.moduleInteritemSpacing = 10;
    viewLayout.moduleLineSpacing = 10;
    return viewLayout;
}

@end
