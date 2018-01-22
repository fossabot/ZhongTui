//
//  LoginHeader.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/27.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "LoginHeader.h"
#import "UIView+ZTCategory.h"

@implementation LoginHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.icon cutRoundView];
}

+ (instancetype)headerView{
    
    LoginHeader *headView = [[[NSBundle mainBundle] loadNibNamed:@"LoginHeader" owner:self options:nil] firstObject];
    
    return headView;
}

- (IBAction)iconClick:(UIButton *)sender {
    
    if (_changeUserInfoBlock) {
        _changeUserInfoBlock();
    }
    
}


- (void)setUser:(ZTUser *)user {
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:user.avatar] forState:UIControlStateNormal placeholderImage:imageNamed(placeHolderAvatar)];
    _nickname.text = user.user_name;
    _level.text = @"lose";
    _rate.text = user.speed_card_state;
    
}

@end
