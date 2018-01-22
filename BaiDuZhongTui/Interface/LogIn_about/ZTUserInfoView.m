//
//  ZTUserInfoView.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2018/1/2.
//  Copyright © 2018年 YiWangTech. All rights reserved.
//

#import "ZTUserInfoView.h"

@interface ZTUserInfoView ()<UITextFieldDelegate>

@end


@implementation ZTUserInfoView

+ (instancetype)userinfoView {
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    ZTLogFunc
    if (_nameViewBlock) {
        _nameViewBlock(textField.text);
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    ZTLogFunc
    if (_nameViewBlock) {
        _nameViewBlock(textField.text);
    }
}


@end
