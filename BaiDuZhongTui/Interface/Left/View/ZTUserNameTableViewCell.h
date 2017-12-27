//
//  ZTUserNameTableViewCell.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/17.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const ZTUserNameTableViewCellId = @"ZTUserNameTableViewCell";

@interface ZTUserNameTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end
