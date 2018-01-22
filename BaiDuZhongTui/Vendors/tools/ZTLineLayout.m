//
//  ZTLineLayout.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/28.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTLineLayout.h"

@implementation ZTLineLayout


- (void)prepareLayout {
    
    [super prepareLayout];
    
    //解决item不是默认居中显示的问题，默认是靠边的，所以要设置一定的内边距
    CGFloat inset = self.collectionView.frame.size.width*0.5 - self.itemSize.width*0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
}

/** 子类重写这个方法 返回布局属性的数组，调用super的这个放法得到collectionView的item的所有布局属性，然后For循环修改，再返回给collectionView*/
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *attributies = [super layoutAttributesForElementsInRect:rect];
    
    //计算collectionview中心点(collectionView的中心点是以contentsize的原点为原点的，所以需加上contentoffset.x)
    CGFloat centerX = self.collectionView.frame.size.width*0.5 + self.collectionView.contentOffset.x;
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    CGFloat leftDelta = self.collectionView.contentOffset.x + collectionViewWidth*0.5 - self.itemSize.width*0.5;
    CGFloat rightDelta = self.collectionView.contentSize.width - self.collectionView.contentOffset.x - collectionViewWidth*0.5 - self.itemSize.width*0.5;
    
    CGFloat maxDelta = MAX(leftDelta, rightDelta);
    
    NSMutableArray * arr = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attr in attributies) {
        
        //计算得每个item的中心点到collectionView的中心点的距离，以使其局中心点的近距离越远，缩放倍率越大(delta取值范围应该是collectionView中心点到两边的最远的那个contentsize的边的距离减去item的宽度的一半)
        CGFloat delta = ABS(attr.center.x - centerX);
        
        CGFloat ratio = 1 - delta/maxDelta;
        
        attr.transform = CGAffineTransformMakeScale(ratio, ratio);
        
        [arr addObject:attr];
        
    }
    
    return arr;
    
}

/** 在滑动collectionView的时候，会一直刷新UI然后计算cell的尺寸显示出来，默认是NO*/
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

/** 这个方法是在滑动collectionView之后,collectionView会惯性向前滑动一段距离，然后最终停下来的偏移量
 * proposedContentOffset 可能的偏移量，系统计算得出的，我们可以自己设定
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.bounds.size;
    
    //求出当前collectionView的可视区域内的attribute集合，即那些在可视范围内item
    NSArray *attributies = [super layoutAttributesForElementsInRect:rect];
    
    //然后将各个item的中心点的x值对比 得到离collectionView中心点最近的item，使其居中
    
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attr in attributies) {
        
        if (minDelta > ABS(attr.center.x - (proposedContentOffset.x+self.collectionView.frame.size.width*0.5)) ) {
            
            minDelta = ABS(attr.center.x - (proposedContentOffset.x+self.collectionView.frame.size.width*0.5));
        }
    }
    
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}

@end
