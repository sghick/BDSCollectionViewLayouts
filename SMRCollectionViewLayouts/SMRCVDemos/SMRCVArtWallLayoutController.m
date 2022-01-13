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
@property (strong, nonatomic) NSArray<NSValue *> *offsets;

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
//        @(CGSizeMake(110, 60)),
//        @(CGSizeMake(30, 30)),
//        @(CGSizeMake(70, 70)),
//        @(CGSizeMake(170, 170)),
//        @(CGSizeMake(130, 120)),
//        @(CGSizeMake(160, 100)),
//        @(CGSizeMake(45, 65)),
    ];
    self.offsets = @[
        @(CGPointMake(0, -50)),
        @(CGPointMake(-80, 40)),
        @(CGPointMake(10, -30)),
        @(CGPointMake(-30, 70)),
    ];
}

#pragma mark - SMRCVArtWallLayoutDelegate

- (CGSize)layout:(SMRCVArtWallLayout *)layout sizeForItemAtIndex:(NSUInteger)index {
    NSInteger idx = index%self.sizes.count;
    return self.sizes[idx].CGSizeValue;
}

- (CGPoint)layout:(SMRCVArtWallLayout *)layout offsetForItemAtIndex:(NSUInteger)index {
    NSInteger idx = index%self.offsets.count;
    return self.offsets[idx].CGPointValue;
}

#pragma mark - Getters

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVArtWallLayout *layout = [[SMRCVArtWallLayout alloc] init];
    layout.edgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.visibleItemsCount = 5;
    layout.minScale = 0.5;
    layout.delegate = self;
    return layout;
}

@end
