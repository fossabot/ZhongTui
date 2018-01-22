//
//  ZTWithdrawMoneyCell.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/17.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const ZTWithdrawMoneyCellId = @"ZTWithdrawMoneyCell";

@interface ZTWithdrawMoneyCell : UITableViewCell

@property (nonatomic, strong) UIImageView *walletImage;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subTitle;

@end
