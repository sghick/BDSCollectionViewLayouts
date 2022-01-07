//
//  SMRCVArtWallLayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/6.
//

#import "SMRCVArtWallLayoutController.h"
#import "SMRCVArtWallLayout.h"

@interface SMRCVArtWallLayoutController ()<
SMRCVArtWallLayoutDelegate>

@property (strong, nonatomic) NSArray<NSValue *> *sizes;

@end

@implementation SMRCVArtWallLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sizes = @[
        @(CGSizeMake(100, 50)),
        @(CGSizeMake(200, 150)),
        @(CGSizeMake(80, 90)),
        @(CGSizeMake(120, 80)),
        @(CGSizeMake(40, 50)),
        @(CGSizeMake(70, 80)),
        @(CGSizeMake(180, 150)),
        @(CGSizeMake(100, 90)),
        @(CGSizeMake(110, 60)),
        @(CGSizeMake(30, 30)),
        @(CGSizeMake(70, 70)),
        @(CGSizeMake(170, 170)),
        @(CGSizeMake(130, 120)),
        @(CGSizeMake(160, 100)),
        @(CGSizeMake(45, 65)),
    ];
}

#pragma mark - SMRCVArtWallLayoutDelegate

- (CGSize)artWallLayout:(SMRCVArtWallLayout *)waterfallLayout sizeForItemAtIndex:(NSUInteger)index {
    NSInteger idx = index%self.sizes.count;
    return self.sizes[idx].CGSizeValue;
}

#pragma mark - Getters

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVArtWallLayout *layout = [[SMRCVArtWallLayout alloc] init];
    layout.visibleItemsCount = 5;
    layout.minScale = 0.5;
    layout.delegate = self;
    return layout;
}

@end
