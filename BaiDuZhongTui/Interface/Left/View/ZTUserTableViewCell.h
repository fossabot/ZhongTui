//
//  ZTUserTableViewCell.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/17.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const ZTUserTableViewCellId = @"ZTUserTableViewCell";

@interface ZTUserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
