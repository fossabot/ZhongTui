//
//  MBProgressHUD+THHUD.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/18.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (THHUD)

/** 显示菊花*/
+ (void)showIndicatorConstantInWindow;
+ (void)showIndicatorConstantInView;

+ (void)showTipMessageInWindow:(NSString*)message;
+ (void)showTipMessageInWindow:(NSString*)message dimBack:(BOOL)dim;
+ (void)showTipMessageInView:(NSString*)message;
+ (void)showTipMessageInView:(NSString*)message dimBack:(BOOL)dim;
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer dimBack:(BOOL)dim;
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer;
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer dimBack:(BOOL)dim;


+ (void)showActivityMessageInWindow:(NSString*)message;
+ (void)showActivityMessageInWindow:(NSString*)message dimBack:(BOOL)dim;

+ (void)showActivityMessageInView:(NSString*)message;
+ (void)showActivityMessageInView:(NSString*)message dimBack:(BOOL)dim;

+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer dimBack:(BOOL)dim;

+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer;
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer dimBack:(BOOL)dim;


+ (void)showSuccessMessage:(NSString *)Message;
+ (void)showErrorMessage:(NSString *)Message;
+ (void)showInfoMessage:(NSString *)Message;
+ (void)showWarnMessage:(NSString *)Message;


+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message;


+ (void)hideHUD;

@end
