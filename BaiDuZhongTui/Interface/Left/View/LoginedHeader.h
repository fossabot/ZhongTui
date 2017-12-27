//
//  LoginedHeader.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/17.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTUser.h"

typedef void(^ChangeUserInfoBlock)();

@interface LoginedHeader : UIView
@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *rate;

@property (nonatomic, strong) ZTUser *user;

/** cahngeUserInfoBlock*/
@property (nonatomic, copy) ChangeUserInfoBlock changeUserInfoBlock;


+ (instancetype)headerView;


@end
