//
//  UnloginHeader.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/17.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginBlock)();

@interface UnloginHeader : UIView

/** loginBlock*/
@property (nonatomic, copy) LoginBlock loginBlock;

+ (instancetype)headerView;

@end
