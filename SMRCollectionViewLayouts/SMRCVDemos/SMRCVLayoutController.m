//
//  SMRCVLayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import "SMRCVLayoutController.h"
#import <Masonry/Masonry.h>

@interface SMRCVLayoutController ()

@property (strong, nonatomic) UICollectionViewLayout *viewLayout;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation SMRCVLayoutController

@synthesize collectionView = _collectionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.dataSource = [@"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z" componentsSeparatedByString:@" "];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = self.class.randomColor;
    UILabel *label = [cell.contentView viewWithTag:100];
    if (!label) {
        label = [[UILabel alloc] init];
        label.tag = 100;
        label.textColor = self.class.randomColor;
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    label.text = self.dataSource[indexPath.row];
    return cell;
}

+ (UIColor *)randomColor {
    CGFloat red = (arc4random()%255)/255.0;
    CGFloat green = (arc4random()%255)/255.0;
    CGFloat blue = (arc4random()%255)/255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    return color;
}

#pragma mark - SMRCVLayoutProtocol

- (UICollectionViewLayout *)collectionViewLayout {
    UICollectionViewLayout *viewLayout = [[UICollectionViewFlowLayout alloc] init];
    return viewLayout;
}

#pragma mark - Getters

- (UICollectionViewLayout *)viewLayout {
    if (!_viewLayout) {
        _viewLayout = [self collectionViewLayout];
    }
    return _viewLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView =
        [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.viewLayout];
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

@end
