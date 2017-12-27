//
//  MainScrollCollectionCell.h
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTEdgeLabel.h"

@interface MainScrollCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *scrollImageView;
@property (strong, nonatomic) UILabel *scrollTitle;
@property (strong, nonatomic) ZTEdgeLabel *scrollTag;
@property (strong, nonatomic) ZTEdgeLabel *scrollTag1;
@property (strong, nonatomic) ZTEdgeLabel *scrollTag2;
@end
