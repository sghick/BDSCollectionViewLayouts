//
//  SMRCVSquareLayout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import "SMRCVSquareLayout.h"
#import "UICollectionViewLayout+SMR.h"

@interface SMRCVSquareLayout ()

@property (strong, nonatomic) NSArray *attrs;

@end

@implementation SMRCVSquareLayout

- (void)prepareLayout {
    [super prepareLayout];
    _attrs = [self attributesInSection:0];
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrs;
}

- (CGSize)collectionViewContentSize {
    int count = (int)[self.collectionView numberOfItemsInSection:0];
    int rows = (count + 3 - 1)/3;
    CGFloat rowH1 = self.collectionView.frame.size.width/2;
    CGFloat rowH2 = rowH1/2;
    NSInteger lineType = (count - 1)%6;
    if (lineType == 3) {
        return CGSizeMake(0, rows*rowH1 - rowH2);
    }
    return CGSizeMake(0, rows*rowH1);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.collectionView.frame.size.width*0.5;
    UICollectionViewLayoutAttributes *attrs =
    [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat height = width;
    NSInteger i = indexPath.item%6;
    NSInteger rows = indexPath.item/3;
    CGFloat y = rows*height;
    if (i==0) {
        attrs.frame = CGRectMake(0, y, width, height);
    } else if (i==1) {
        attrs.frame = CGRectMake(width, y, width, height/2);
    } else if (i==2) {
        attrs.frame = CGRectMake(width, y + height/2, width, height/2);
    } else if (i==3) {
        attrs.frame = CGRectMake(0, y, width, height/2);
    } else if (i==4) {
        attrs.frame = CGRectMake(0, y + height/2, width, height/2);
    } else if (i==5) {
        attrs.frame = CGRectMake(width, y, width, height);
    }
    return attrs;
}

@end
