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

@property (assign, nonatomic) CGFloat p_maxWidth;       // 最大宽,临时变量
@property (assign, nonatomic) CGFloat p_maxHeight;      // 当前行最大高,临时变量

@end

@implementation SMRCVSquareLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.attrs = [self attributesInSection:0];
    self.contentWidth = self.p_maxWidth + self.moduleInsets.right;
    self.contentHeight = self.p_maxHeight + self.moduleInsets.bottom;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrs;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.contentWidth, self.contentHeight);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attrs =
    [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGSize moduleSize = self.moduleSize;
    CGFloat moduleLineSpacing = self.moduleLineSpacing;
    CGFloat moduleInteritemSpacing = self.moduleInteritemSpacing;
    UIEdgeInsets moduleInsets = self.moduleInsets;
    CGFloat width = moduleSize.width - moduleInsets.left - moduleInsets.right;
    CGFloat height = moduleSize.height - moduleInsets.top - moduleInsets.bottom;
    CGFloat width_2 = (width - moduleInteritemSpacing)/2;
    CGFloat height_2 = (height - moduleLineSpacing)/2;
    NSInteger i = indexPath.item%6;
    NSInteger rows = indexPath.item/3;
    CGFloat y = rows*moduleSize.height;
    CGFloat left1 = moduleInsets.left;
    CGFloat left2 = left1 + width_2 + moduleInteritemSpacing;
    CGFloat top1 = y + moduleInsets.top;
    CGFloat top2 = top1 + height_2 + moduleLineSpacing;
    if (i==0) {
        attrs.frame = CGRectMake(left1, top1, width_2, height);
    } else if (i==1) {
        attrs.frame = CGRectMake(left2, top1, width_2, height_2);
    } else if (i==2) {
        attrs.frame = CGRectMake(left2, top2, width_2, height_2);
    } else if (i==3) {
        attrs.frame = CGRectMake(left1, top1, width_2, height_2);
    } else if (i==4) {
        attrs.frame = CGRectMake(left1, top2, width_2, height_2);
    } else if (i==5) {
        attrs.frame = CGRectMake(left2, top1, width_2, height);
    }
    self.p_maxWidth = MAX(self.p_maxWidth, CGRectGetMaxX(attrs.frame));
    self.p_maxHeight = MAX(self.p_maxHeight, CGRectGetMaxY(attrs.frame));
    return attrs;
}

@end
