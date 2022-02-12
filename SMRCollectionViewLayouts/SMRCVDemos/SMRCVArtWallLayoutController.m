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

@property (strong, nonatomic) UITextField *sizeTextField;
@property (strong, nonatomic) UITextField *offsetTextField;

@end

@implementation SMRCVArtWallLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sizes = @[
        @(CGSizeMake(100, 50)),
        @(CGSizeMake(200, 150)),
        @(CGSizeMake(80, 90)),
        @(CGSizeMake(120, 80)),
        @(CGSizeMake(140, 150)),
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
        @(CGPointMake(-0, 0)),
    ];
    [self.view addSubview:self.sizeTextField];
    [self.view addSubview:self.offsetTextField];
    
    self.sizeTextField.frame = CGRectMake(0, 100, self.view.bounds.size.width, 50);
    self.offsetTextField.frame = CGRectMake(0, 150, self.view.bounds.size.width, 50);
}

#pragma mark - Privates

- (CGSize)p_size {
    CGPoint point = [self p_randomPointInText:self.sizeTextField.text];
    return CGSizeMake(point.x, point.y);
}

- (CGPoint)p_point {
    return [self p_randomPointInText:self.offsetTextField.text];
}

- (CGPoint)p_randomPointInText:(NSString *)text {
    NSArray<NSString *> *sep = [text componentsSeparatedByString:@";"];
    if (sep.count < 2) {
        return CGPointZero;
    }
    NSArray<NSString *> *arr1 = [sep[0] componentsSeparatedByString:@","];
    NSArray<NSString *> *arr2 = [sep[1] componentsSeparatedByString:@","];
    if ((arr1.count < 3) || (arr2.count < 3)) {
        return CGPointZero;
    }
    NSInteger x = [self p_random:arr1[0].integerValue
                             max:arr1[1].integerValue
                            base:arr1[2].integerValue];
    NSInteger y = [self p_random:arr2[0].integerValue
                             max:arr2[1].integerValue
                            base:arr2[2].integerValue];
    return CGPointMake(x, y);
}

- (NSInteger)p_random:(NSInteger)min max:(NSInteger)max base:(NSInteger)base {
    NSInteger c = ABS(max - min)/2;
    return arc4random()%(2*c) - c + base;
}

#pragma mark - SMRCVArtWallLayoutDelegate

- (CGSize)layout:(SMRCVArtWallLayout *)layout sizeForItemAtIndex:(NSUInteger)index {
//    NSInteger idx = index%self.sizes.count;
//    return self.sizes[idx].CGSizeValue;
    return self.p_size;
}

- (CGPoint)layout:(SMRCVArtWallLayout *)layout offsetForItemAtIndex:(NSUInteger)index {
    NSInteger idx = index%self.offsets.count;
//    return self.offsets[idx].CGPointValue;
//    return self.p_point;
    CGPoint point = self.offsets[idx].CGPointValue;
    CGPoint rdPoint = self.p_point;
    return CGPointMake(point.x + rdPoint.x, point.y + rdPoint.y);
}

#pragma mark - Getters

- (UITextField *)sizeTextField {
    if (!_sizeTextField) {
        _sizeTextField = [[UITextField alloc] init];
        _sizeTextField.text = @"-0,50,100;-0,50,100";
    }
    return _sizeTextField;
}

- (UITextField *)offsetTextField {
    if (!_offsetTextField) {
        _offsetTextField = [[UITextField alloc] init];
        _offsetTextField.text = @"-50,10,0;-20,10,0";
    }
    return _offsetTextField;
}

- (UICollectionViewLayout *)collectionViewLayout {
    SMRCVArtWallLayout *layout = [[SMRCVArtWallLayout alloc] init];
    layout.edgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.visibleItemsCount = 5;
    layout.minScale = 0.5;
    layout.delegate = self;
    return layout;
}

@end
