//
//  ArticleCell.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/3.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEEStarRating.h"
#import "ZTEdgeLabel.h"

static NSString * const ArticleCellId = @"ArticleCell";

@interface ArticleCell : UITableViewCell


@property (nonatomic, strong) LEEStarRating *ratingView;

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) ZTEdgeLabel *tagLabel;

@property (nonatomic, strong) UILabel *usedTimes;


@end
