//
//  SMRCVCircleLayout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import "SMRCVCircleLayout.h"

@interface SMRCVCircleLayout ()

@property (strong, nonatomic) NSArray *attrs;

@end

@implementation SMRCVCircleLayout

- (void)prepareLayout {
    [super prepareLayout];
    _attrs = [self loadAttributesInSection:0];
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrs;
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
    attrs.center = CGPointMake(Ox+radius*sin(angle), Oy+radius*cos(angle));
    if (count == 1) {
        attrs.size = CGSizeMake(200, 200);
    } else {
        attrs.size = CGSizeMake(50, 50);
    }
    return attrs;
}

@end
