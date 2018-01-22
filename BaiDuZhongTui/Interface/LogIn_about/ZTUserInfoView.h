//
//  ZTUserInfoView.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2018/1/2.
//  Copyright © 2018年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NameViewBlock)(NSString *name);

@interface ZTUserInfoView : UIView

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameText;

/** name*/
@property (nonatomic, copy) NameViewBlock nameViewBlock;

+ (instancetype)userinfoView;

@end
