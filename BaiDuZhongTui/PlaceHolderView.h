//
//  PlaceHolderView.h
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderView : UIView








/** 单例*/
+ (instancetype)sharedPlaceHolderView;

//展示首页的赚钱遮罩提示
+ (void)show:(void(^)())completion;

//展示分享成功的遮罩提示
+ (void)showShareSucceed:(void(^)())completion;

@end
