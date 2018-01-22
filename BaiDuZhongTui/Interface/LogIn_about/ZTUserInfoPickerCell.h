//
//  ZTUserInfoPickerCell.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2018/1/2.
//  Copyright © 2018年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonTouchedBlock)();

@interface ZTUserInfoPickerCell : UIView

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIButton *userinfoPickerBtn;

+ (instancetype)userinfoView;

/** button点击的回调*/
@property (nonatomic, copy) ButtonTouchedBlock buttonTouchedBlock;

- (void)selecTitle:(NSString *)title;

@end

