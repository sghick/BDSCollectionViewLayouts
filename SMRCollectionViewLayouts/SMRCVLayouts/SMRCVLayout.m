//
//  SMRCVLayout.m
//  SMRCollectionViewLayouts
//
//  Created by Tinswin on 2022/1/4.
//

#import "SMRCVLayout.h"

@implementation SMRCVLayout

- (NSArray<UICollectionViewLayoutAttributes *> *)loadAttributesInSection:(NSInteger)section {
    NSMutableArray *arr = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:section];
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        UICollectionViewLayoutAttributes *attrs =
        [self layoutAttributesForItemAtIndexPath:indexPath];
        if (attrs) {
            [arr addObject:attrs];
        }
    }
    return arr;
}
@end
