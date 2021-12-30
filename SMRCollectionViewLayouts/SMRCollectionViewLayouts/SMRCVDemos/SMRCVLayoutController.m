//
//  SMRCVLayoutController.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import "SMRCVLayoutController.h"

@interface SMRCVLayoutController ()

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewLayout *viewLayout;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation SMRCVLayoutController

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
    cell.backgroundColor = [UIColor redColor];
    cell.largeContentTitle = self.dataSource[indexPath.row];
    return cell;
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
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

@end
