//
//  LeftAchievementCell.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/3.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const LeftAchievementCellId = @"LeftAchievementCell";

@interface LeftAchievementCell : UITableViewCell

@property (nonatomic, copy) NSString *finaceValue;

@property (nonatomic, copy) NSString *currentMoney;

@property (nonatomic, copy) NSString *contributionValue;


@end
