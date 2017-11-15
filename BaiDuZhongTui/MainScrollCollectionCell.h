//
//  MainScrollCollectionCell.h
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEdgeLabel.h"

@interface MainScrollCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *scrollImageView;
@property (strong, nonatomic) UILabel *scrollTitle;
@property (strong, nonatomic) YYEdgeLabel *scrollTag;
@property (strong, nonatomic) YYEdgeLabel *scrollTag1;
@property (strong, nonatomic) YYEdgeLabel *scrollTag2;
@end
