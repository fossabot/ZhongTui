//
//  MainAdCell.h
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYEdgeLabel.h"
#define adCellId @"adCell"

@interface MainAdCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *adImage;
@property (weak, nonatomic) IBOutlet YYEdgeLabel *adTag;
@property (weak, nonatomic) IBOutlet UILabel *clickMoney;
@property (weak, nonatomic) IBOutlet UILabel *shareMoney;

@end
