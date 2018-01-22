//
//  MainAdCell.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTEdgeLabel.h"
#define adCellId @"adCell"

@interface MainAdCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *adImage;
@property (weak, nonatomic) IBOutlet ZTEdgeLabel *adTag;
@property (weak, nonatomic) IBOutlet UILabel *clickMoney;
@property (weak, nonatomic) IBOutlet UILabel *shareMoney;

@end
