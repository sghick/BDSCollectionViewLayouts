//
//  SMRCVSliderStyle2Layout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVSliderStyle2Layout.h"

@implementation SMRCVSliderStyle2Layout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.itemsCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs =
        [self layoutAttributesForItemAtIndexPath:indexPath];
        if (attrs) {
            [arr addObject:attrs];
        }
    }
    return [arr copy];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 计算collectionView最中心点的x值
    CGFloat centerX = self.contentOffset.x + self.collectionViewSize.width*0.5;
    CGFloat centerY = self.collectionViewSize.height*0.5;
    // 在原有布局属性的基础上，进行微调
    UICollectionViewLayoutAttributes *attrs =
    [super layoutAttributesForItemAtIndexPath:indexPath];
    // cell的中心点x 和 collectionView最中心点的x值 的间距
    CGFloat delta = fabs(attrs.center.x - centerX);
    // 根据间距值 计算 cell的缩放比例
    CGFloat scale = delta / self.collectionView.frame.size.width * 1.4;
    //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
    scale = fabs(cos(scale * M_PI/4));
    // 设置缩放比例
    attrs.transform = CGAffineTransformMakeScale(1, scale);
    // 设置中心位置
    attrs.center = CGPointMake(attrs.center.x, centerY);
    return attrs;
}

- (CGSize)collectionViewContentSize {
    CGSize size = [super collectionViewContentSize];
    CGFloat width = self.itemSize.width*self.itemsCount + self.minimumInteritemSpacing*(self.itemsCount - 1);
    return CGSizeMake(width, size.height);
}

@end
