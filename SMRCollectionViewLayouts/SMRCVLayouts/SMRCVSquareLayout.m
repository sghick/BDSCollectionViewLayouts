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
    self.contentWidth = self.p_maxWidth + self.edgeInsets.right;
    self.contentHeight = self.p_maxHeight + self.edgeInsets.bottom;
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
    if (self.layoutBlock) {
        self.layoutBlock(self, attrs, indexPath);
    } else {
        SMRCVSquareLayout.defaultSquareLayoutBlock(self, attrs, indexPath);
    }
    self.p_maxWidth = MAX(self.p_maxWidth, CGRectGetMaxX(attrs.frame));
    self.p_maxHeight = MAX(self.p_maxHeight, CGRectGetMaxY(attrs.frame));
    return attrs;
}

+ (SMRCVLayoutBlock)defaultSquareLayoutBlock {
  return ^(SMRCVSquareLayout *layout, UICollectionViewLayoutAttributes *attrs, NSIndexPath *indexPath){
        UIEdgeInsets edgeInsets = layout.edgeInsets;
        CGFloat spacing = layout.spacing;
        CGSize moduleSize = layout.moduleSize;
        CGFloat moduleLineSpacing = layout.moduleLineSpacing;
        CGFloat moduleInteritemSpacing = layout.moduleInteritemSpacing;
        CGFloat width = moduleSize.width;
        CGFloat height = moduleSize.height;
        CGFloat width_2 = (width - moduleInteritemSpacing)/2;
        CGFloat height_2 = (height - moduleLineSpacing)/2;
      
        NSInteger i = indexPath.item%6;
        NSInteger rows = indexPath.item/3;
        CGFloat y = edgeInsets.top;
        CGFloat x = edgeInsets.left;
        if (layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
            y += rows*moduleSize.height + rows*spacing;
        } else {
            x += rows*moduleSize.width + rows*spacing;
        }
        CGFloat x2 = x + width_2 + moduleInteritemSpacing;
        CGFloat y2 = y + height_2 + moduleLineSpacing;
        
        if (i==0) {
            attrs.frame = CGRectMake(x, y, width_2, height);
        } else if (i==1) {
            attrs.frame = CGRectMake(x2, y, width_2, height_2);
        } else if (i==2) {
            attrs.frame = CGRectMake(x2, y2, width_2, height_2);
        } else if (i==3) {
            attrs.frame = CGRectMake(x, y, width_2, height_2);
        } else if (i==4) {
            attrs.frame = CGRectMake(x, y2, width_2, height_2);
        } else if (i==5) {
            attrs.frame = CGRectMake(x2, y, width_2, height);
        }
    };
}

@end
