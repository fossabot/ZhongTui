//
//  LoginedHeader.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/17.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "LoginedHeader.h"

@implementation LoginedHeader

+ (instancetype)headerView{
    
    LoginedHeader *headView = [[[NSBundle mainBundle] loadNibNamed:@"LoginedHeader" owner:nil options:nil] firstObject];
    
    return headView;
}

- (IBAction)iconClick:(UIButton *)sender {

    if (_changeUserInfoBlock) {
        _changeUserInfoBlock();
    }
    
}


- (void)setUser:(ZTUser *)user {
    
    
}


@end
