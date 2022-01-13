//
//  SMRCVSquareLayout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import "SMRCVSquareLayout.h"
#import "UICollectionViewLayout+SMR.h"

@interface SMRCVSquareLayout ()

@property (assign, nonatomic) CGFloat contentWidth;
@property (assign, nonatomic) CGFloat contentHeight;
@property (strong, nonatomic) NSArray *attrs;

@end

@implementation SMRCVSquareLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.attrs = [self attributesInSection:0];
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrs;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.contentWidth, self.contentHeight);
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
