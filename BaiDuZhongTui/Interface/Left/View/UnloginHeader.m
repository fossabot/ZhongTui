//
//  UnloginHeader.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/17.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "UnloginHeader.h"

@implementation UnloginHeader


+ (instancetype)headerView{
    
    UnloginHeader *headView = [[[NSBundle mainBundle] loadNibNamed:@"UnloginHeader" owner:nil options:nil] firstObject];
    
    return headView;
}


- (IBAction)loginMethod:(id)sender {

    assert(@"登录操作");
    if (_loginBlock) {
        _loginBlock();
    }
    
}

@end
