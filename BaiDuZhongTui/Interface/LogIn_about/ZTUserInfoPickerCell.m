//
//  ZTUserInfoPickerCell.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2018/1/2.
//  Copyright © 2018年 YiWangTech. All rights reserved.
//

#import "ZTUserInfoPickerCell.h"

@interface ZTUserInfoPickerCell ()

@end

@implementation ZTUserInfoPickerCell

+ (instancetype)userinfoView {
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (IBAction)editUserInfo:(UIButton *)sender {
    
    if (_buttonTouchedBlock) {
        _buttonTouchedBlock();
    }
}


- (void)selecTitle:(NSString *)title {
    
    [self.userinfoPickerBtn setTitle:title forState:UIControlStateNormal];
}


@end
