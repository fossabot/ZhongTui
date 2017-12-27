//
//  ZTNavView.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/12.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//
/**
 
 一个有标题、有背景颜色、有左耳目、右耳目、及左右耳目的点击事件
 自适应屏幕的导航栏和状态栏的高度（可以外界调节高度，最低不能低于状态栏的高度），宽度等于屏幕宽度
 
 */

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat leftMargin;
UIKIT_EXTERN CGFloat navigationBarH;

@protocol NavViewDelegate <NSObject>

- (void)navView:(UIView *)navView didSelectedLeftItem:(UIButton *)leftItem;

@end

@interface ZTNavView : UIView

#pragma mark initial method
/**
 初始化并赋值导航栏的高度

 @return 返回一个导航栏
 */
- (instancetype)initWithNavHeight:(CGFloat)height;


#pragma mark properties

@property (nonatomic, assign) CGFloat navHeight; //navHeight 导航的高度（当然也包括状态栏）
@property (nonatomic, strong) UIColor *navBackgroundColor;  //导航的背景颜色

@property (nonatomic, copy) NSString *title;  // 导航的标题
@property (nonatomic, assign) CGFloat titleFontValue; //导航标题的字号
@property (nonatomic, strong) UIColor *titleColor; //导航标题文字的颜色

@property (nonatomic, copy) NSString *leftTitle; //左侧按钮的标题文字
@property (nonatomic, assign) CGFloat leftTitleFontValue;
@property (nonatomic, copy) NSString *leftImageName;//左侧按钮图片的名字

@property (nonatomic, weak) id<NavViewDelegate> delegate;

@end
