//
//  PlaceHolderView.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceHolderView : UIView


@property (strong, nonatomic) UIImageView *imageView;

@property (nonatomic, strong) UILabel *tip;



/** 单例*/
+ (instancetype)sharedPlaceHolderView;

+ (void)showInView:(UIView *)view imageName:(NSString *)imageNmae tip:(NSString *)tip completion:(void(^)())completion;

//展示首页的赚钱遮罩提示
+ (void)show:(void(^)())completion;

//展示分享成功的遮罩提示
+ (void)showShareSucceed:(void(^)())completion;

@end
