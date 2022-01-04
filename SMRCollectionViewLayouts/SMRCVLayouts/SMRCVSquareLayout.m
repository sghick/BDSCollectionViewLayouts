//
//  SMRCVSquareLayout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2021/12/30.
//

#import "SMRCVSquareLayout.h"

@interface SMRCVSquareLayout ()

@end

@implementation SMRCVSquareLayout

#pragma mark -

- (CGSize)collectionViewContentSize {
    int count = (int)[self.collectionView numberOfItemsInSection:0];
    int rows = (count +3 -1)/3;
    CGFloat rowH = self.collectionView.frame.size.width/2;
    if(((count)%6==2) || ((count)%6==4)) {
        return CGSizeMake(0, rows*rowH - rowH/2);
    } else {
        return CGSizeMake(0, rows*rowH);
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.collectionView.frame.size.width*0.5;
    UICollectionViewLayoutAttributes *attrs =
    [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat height = width;
    NSInteger i = indexPath.item;
    if(i==0) {
        attrs.frame = CGRectMake(0, 0, width, height);
    } else if(i==1) {
        attrs.frame = CGRectMake(width, 0, width, height/2);
    } else if(i==2) {
        attrs.frame = CGRectMake(width, height/2, width, height/2);
    } else if(i==3) {
        attrs.frame = CGRectMake(0, height, width, height/2);
    } else if(i==4) {
        attrs.frame = CGRectMake(0, height+height/2, width, height/2);
    } else if(i==5) {
        attrs.frame = CGRectMake(width, height, width, height);
    } else {
       UICollectionViewLayoutAttributes *lastAttrs = self.attrs[i-6];
        CGRect frame = lastAttrs.frame;
        frame.origin.y += 2*height;
        attrs.frame = frame;
    }
   return attrs;
}

@end
