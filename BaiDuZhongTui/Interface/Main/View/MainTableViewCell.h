//
//  MainTableViewCell.h
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>

#define adCellId @"adCell"
#define searchCellId @"searchCell"
#define scrollCellId @"scrollCell"


@interface MainTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *scrollImageView;
@property (weak, nonatomic) IBOutlet UILabel *scrollTitle;
@property (weak, nonatomic) IBOutlet UILabel *scrollTag;


@property (weak, nonatomic) IBOutlet UIImageView *adImageView;

@property (weak, nonatomic) IBOutlet UILabel *adTag;

@property (weak, nonatomic) IBOutlet UILabel *clickMoney;

@property (weak, nonatomic) IBOutlet UILabel *showMoney;

/** 类方法快速返回搜索cell */
+ (UINib *)replySearchCell;


/** 类方法快速返回轮播cell */
+ (UINib *)replyScrollCell;


/** 类方法快速返回广告cell */
+ (UINib *)replyADCell;

@end
