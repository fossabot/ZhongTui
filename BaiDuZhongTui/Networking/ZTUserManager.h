//
//  ZTUserManager.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/14.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZTUserManager : NSObject

//根据userid获取个人信息
+ (void)getUserInfo;

/** 更新个人信息*/
+ (void)updateUserInfo:(NSDictionary *)userPara;

/** 检查设备是否在其他设备登录，如果是真 则退出账号，直接清除本地账号不需要跟后台交互*/
+ (void)checkLogInOtherDevice;

/** 退出登录*/
+ (void)logOutAccount:(NSString *)mobile success:(void(^)(BOOL success))success;

/**
 APP安装的回调
 */
+ (void)installFeedback;

/**
 登录时 验证账号密码
 
 @param account 账号
 @param password 密码
 @param success 返回BOOL值 成功或者失败
 */
+ (void)loginSucceedWithAccount:(NSString *)account password:(NSString *)password responseMsg:(void (^)(BOOL success))success;


/**
 *  检查手机号是否注册了
 */
+ (void)checkMobileIsExist:(NSString *)mobile completion:(void(^)(BOOL exist))completion;


/**
 注册验证账号密码验证码
 
 @param account 账号
 @param verification 验证码
 @param password 密码
 @param success 成功回调
 */

+ (void)registeAccount:(NSString *)account verification:(NSString *)verification password:(NSString *)password response:(void (^)(BOOL success))success;


/**
 重置密码
 
 @param account 手机号
 @param password 新密码
 @param verification 验证码
 @param success 成功回调
 */

+ (void)resetPasswordWithAccount:(NSString *)account password:(NSString *)password verification:(NSString *)verification response:(void (^)(BOOL success))success;


/**
 重设手机号，更换后则用新手机号登陆
 
 @param telephoneNum 新手机号
 @param verification 验证码
 */
+ (void)resetTelephoneNumber:(NSString *)telephoneNum  verification:(NSString *)verification completion:(void(^)(BOOL success))completion;



/**
 获取验证码
 
 @param mobile 手机号
 */
+ (void)getVerificationByMobile:(NSString *)mobile;


/**
 忘记密码时获取验证码的方法
 
 @param mobile 手机号
 */
+ (void)getResetPasswordVerificationByMobile:(NSString *)mobile;




@end
