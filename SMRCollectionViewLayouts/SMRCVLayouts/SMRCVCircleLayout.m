//
//  SMRCVCircleLayout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import "SMRCVCircleLayout.h"

@interface SMRCVCircleLayout ()

@property(strong, nonatomic) NSMutableArray *attrsArr;

@end

@implementation SMRCVCircleLayout

- (void)prepareLayout {
    [super prepareLayout];
    [self.attrsArr removeAllObjects];
    [self creatAttrs];
}

- (void)creatAttrs {
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs =
        [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:attrs];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSLog(@"%@", NSStringFromCGRect(rect));
    return self.attrsArr;
}

#pragma mark -

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat angle = 2*M_PI/count*indexPath.item;
    CGFloat radius = 180;
    CGFloat Ox = self.collectionView.frame.size.width/2;
    CGFloat Oy = self.collectionView.frame.size.height/2;
    UICollectionViewLayoutAttributes *attrs =
    [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.center =  CGPointMake(Ox+radius*sin(angle), Oy+radius*cos(angle));
    if (count == 1) {
        attrs.size = CGSizeMake(200, 200);
    }else{
        attrs.size = CGSizeMake(50, 50);
    }
    return attrs;
}

#pragma mark - Getters

- (NSMutableArray *)attrsArr {
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}

@end
