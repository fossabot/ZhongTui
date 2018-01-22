//
//  MBProgressHUD+THHUD.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/18.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#define LoadingMsg  @"加载中....."

#import "MBProgressHUD+THHUD.h"

@implementation MBProgressHUD (THHUD)

+ (void)initialize {
    
//        [MBProgressHUD appearance].contentColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
}

+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow
{
    UIView  *view = isWindow? (UIView*)[UIApplication sharedApplication].delegate.window:[self getCurrentUIVC].view;
    MBProgressHUD *preHud = [MBProgressHUD HUDForView:view];
    [preHud hideAnimated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message?message:LoadingMsg;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//    hud.dimBackground = NO;
//    [UIColor colorWithWhite:0.f alpha:0.1f];
    return hud;
}

+ (void)showIndicatorConstantInWindow {
    
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:LoadingMsg isWindiw:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud showAnimated:YES];
}

+ (void)showIndicatorConstantInView {
    
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:LoadingMsg isWindiw:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud showAnimated:YES];
}

#pragma mark-------------------- show Tip----------------------------

+ (void)showTipMessageInWindow:(NSString*)message
{
    [self showTipMessage:message isWindow:true timer:1 dimBack:NO];
}

+ (void)showTipMessageInWindow:(NSString *)message dimBack:(BOOL)dim {
    [self showTipMessage:message isWindow:YES timer:1 dimBack:dim];
}

+ (void)showTipMessageInView:(NSString*)message
{
    [self showTipMessage:message isWindow:false timer:1 dimBack:NO];
}

+ (void)showTipMessageInView:(NSString*)message dimBack:(BOOL)dim
{
    [self showTipMessage:message isWindow:false timer:1 dimBack:dim];
}

+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:true timer:aTimer dimBack:NO];
}

+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer dimBack:(BOOL)dim
{
    [self showTipMessage:message isWindow:true timer:aTimer dimBack:dim];
}

+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:false timer:aTimer dimBack:NO];
}

+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer dimBack:(BOOL)dim
{
    [self showTipMessage:message isWindow:false timer:aTimer dimBack:dim];
}

+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer dimBack:(BOOL)dim {
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.mode = MBProgressHUDModeText;
    [self hudView:hud chooseDimBack:dim];
    [hud  hideAnimated:YES afterDelay:1];
}


#pragma mark-------------------- show Activity----------------------------

+ (void)showActivityMessageInWindow:(NSString*)message
{
    [self showActivityMessage:message isWindow:true timer:0];
}
+ (void)showActivityMessageInWindow:(NSString *)message dimBack:(BOOL)dim {
    MBProgressHUD *hud = [self showActivityMessage:message isWindow:true timer:0];
    [self hudView:hud chooseDimBack:dim];
}

+ (void)showActivityMessageInView:(NSString*)message
{
    [self showActivityMessage:message isWindow:false timer:0];
}
+ (void)showActivityMessageInView:(NSString *)message dimBack:(BOOL)dim {
    MBProgressHUD *hud = [self showActivityMessage:message isWindow:false timer:0];
    [self hudView:hud chooseDimBack:dim];
}

+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:true timer:aTimer];
}
+ (void)showActivityMessageInWindow:(NSString *)message timer:(int)aTimer dimBack:(BOOL)dim {
    MBProgressHUD *hud = [self showActivityMessage:message isWindow:true timer:aTimer];
    [self hudView:hud chooseDimBack:dim];
}

+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:false timer:aTimer];
}
+ (void)showActivityMessageInView:(NSString *)message timer:(int)aTimer dimBack:(BOOL)dim {
    MBProgressHUD *hud = [self showActivityMessage:message isWindow:false timer:aTimer];
    [self hudView:hud chooseDimBack:dim];
}

+ (MBProgressHUD *)showActivityMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.mode = MBProgressHUDModeIndeterminate;
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
    return hud;
}
#pragma mark-------------------- show Image----------------------------

+ (void)showSuccessMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+THHUD.bundle/MBProgressHUD/MBHUD_Success";
    [self showCustomIconInWindow:name message:Message];
}

+ (void)showErrorMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+THHUD.bundle/MBProgressHUD/MBHUD_Error";
    [self showCustomIconInWindow:name message:Message];
}

+ (void)showInfoMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+THHUD.bundle/MBProgressHUD/MBHUD_Info";
    [self showCustomIconInWindow:name message:Message];
}

+ (void)showWarnMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+THHUD.bundle/MBProgressHUD/MBHUD_Warn";
    [self showCustomIconInWindow:name message:Message];
}

+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:true];
    
}

+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:false];
}

+ (void)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    hud.mode = MBProgressHUDModeCustomView;
    
    [hud hideAnimated:YES afterDelay:1];
    
}

+ (void)hideHUD
{
    UIView  *winView = (UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:winView animated:YES];
    [self hideHUDForView:[self getCurrentUIVC].view animated:YES];
//    [self hideAllHUDsForView:winView animated:YES];
//    [self hideAllHUDsForView:[self getCurrentUIVC].view animated:YES];

}


+ (void)hudView:(MBProgressHUD *)hud chooseDimBack:(BOOL)dim {
    
    if (dim) {
        
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1f];
    }
}

//获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentWindowVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else
    {
        result = window.rootViewController;
    }
    return  result;
}

+(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [[self class]  getCurrentWindowVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}


@end
