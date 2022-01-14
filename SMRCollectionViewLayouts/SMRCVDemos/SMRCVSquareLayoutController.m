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
    viewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    viewLayout.edgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    viewLayout.spacing = 10;
    viewLayout.moduleSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, 300);
    viewLayout.moduleInteritemSpacing = 10;
    viewLayout.moduleLineSpacing = 10;
    return viewLayout;
}

@end
