//
//  ZTUserManager.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/14.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTUserManager.h"
#import "NSString+Predicate.h"
#import "NSString+ZTSecretaryPassword.h"
#import "ZTUser.h"


@implementation ZTUserManager

#pragma mark -------  外部调用接口  ------------------------------------------

//根据userid获取个人信息
+ (void)getUserInfo {
    
    ZTUser *user = [ZTUser shareUser];
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"userInfo",PARAC,@"getUserInfo",PARAM,user.userid,USERID,user.token,TOKEN, nil];
    [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
       
        [ZTUser configUserInfoWithDic:responseObject[USERINFO]];
    } failure:^(NSError *error) {
        ZTLog(@"网络状态不好，获取个人信息失败");
        [MBProgressHUD showErrorMessage:@"网络状态不好"];
    }];
}


/** 更新个人信息*/
+ (void)updateUserInfo:(NSDictionary *)userPara {
    
//    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"userInfo",C,@"updateUserInfo",M, nil];
    [PPNetworkHelper POST:BaseUrl parameters:userPara success:^(id responseObject) {
        
        [MBProgressHUD showSuccessMessage:@"修改成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"网络状态不好"];
    }];
}

/**
 APP安装的回调
 */
+ (void)installFeedback {
    
    ZTUser *user = [ZTUser shareUser];
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"userState",PARAC,@"install",PARAM,user.devicetoken,DEVICETOKEN,@"1",MOBILETYPE, nil];
    [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
       
        if ([responseObject[STATE] isEqualToString:@"0"]) {
//            [MBProgressHUD showInfoMessage:responseObject[MSG]];
            [kUserDefaults setValue:user.devicetoken forKey:OLDDEVICETOKEN];
            ZTLog(@"%@",responseObject[MSG]);
        }else {
            ZTLog(@"安装回调失败");
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"网络状态不好"];
    }];
}

/** 退出登录*/
+ (void)logOutAccount:(NSString *)mobile success:(void (^)(BOOL))success {
    
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"userState",PARAC,@"signOut",PARAM,mobile,MOBILE, nil];
    [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
        if (responseObject && [responseObject[STATE] isEqualToString:@"0"]) {
            [MBProgressHUD showSuccessMessage:@"退出成功"];
        }else {
            [MBProgressHUD showErrorMessage:@"网络繁忙"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"网络状态不好"];
    }];
}



/** 登录时 验证账号密码*/
+ (void)loginSucceedWithAccount:(NSString *)account password:(NSString *)password responseMsg:(void (^)(BOOL success))success{
    
    BOOL validToLogin = [self validAccount:account password:password verification:nil];
    
    if (!validToLogin) {//格式不正确，不能登录
        return;
    }
    
    [MBProgressHUD showIndicatorConstantInWindow];
    ZTUser *user = [ZTUser shareUser];
//    NSString *secretPwd = [password translateIntoSecretaryPassword];
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"userState",PARAC,@"signOn",PARAM,account,MOBILE,password,PWD,user.devicetoken,DEVICETOKEN, nil];
    [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
       
        if (responseObject && [responseObject[STATE] isEqualToString:@"0"]) {
            [MBProgressHUD showSuccessMessage:@"登录成功"];
            success(YES);
        }else if([responseObject[STATE] isEqualToString:@"1"]){
            [MBProgressHUD showErrorMessage:@"用户名不存在"];
            success(NO);
        }else if ([responseObject[STATE] isEqualToString:@"2"]) {
            [MBProgressHUD showErrorMessage:@"密码错误"];
            success(NO);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"网络状态不好"];
        success(NO);
    }];
}


/** 验证验证码的正确性（注册获取验证码之后和修改密码获取验证码之后都要进行这一步验证）*/
+ (void)validateVerification:(NSString *)ververification mobile:(NSString *)mobile completion:(void(^)(BOOL success))completion{
    
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"verCode",PARAC,@"checkCode",PARAM,mobile,MOBILE,ververification,VERCODE, nil];
    [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
        
        if (completion && [responseObject[STATE] isEqualToString:@"0"]) {
            completion(YES);
            ZTLog(@"%@--",ververification);
            [MBProgressHUD showTipMessageInWindow:responseObject[MSG]];
        }else {
            completion(NO);
            [MBProgressHUD showErrorMessage:@"网络状态不好"];
        }
    } failure:^(NSError *error) {
        if (completion) {
            completion(NO);
            [MBProgressHUD showErrorMessage:@"网络状态不好"];
        }
    }];

}

/**
 *  检查手机号是否注册了
 */
+ (void)checkMobileIsExist:(NSString *)mobile completion:(void (^)(BOOL exist))completion {
    
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"userState",PARAC,@"checkMobile",PARAM,mobile,MOBILE, nil];
    [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
       
        if (responseObject && [responseObject[STATE] isEqualToString:@"1"]) {
            [MBProgressHUD showTipMessageInWindow:@"手机号已注册"];
            if (completion) {
                completion(YES);
            }
        }else {
            completion(NO);
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"网络状态不好"];
        completion(NO);
    }];
}

/**  注册验证账号密码验证码*/
+ (void)registeAccount:(NSString *)account verification:(NSString *)verification password:(NSString *)password response:(void (^)(BOOL success))success {
    
    BOOL validToLogin = [self validAccount:account password:password verification:verification];
    if (!validToLogin) {//格式不正确，不能登录
        return;
    }
    
    [self validateVerification:verification mobile:account completion:^(BOOL completion) {
       
        if (completion) {
            
            ZTUser *user = [ZTUser shareUser];
            NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"userState",PARAC,@"regist",PARAM,account,MOBILE,password,PWD,user.devicetoken,DEVICETOKEN,@"1",MOBILETYPE, nil];
            [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
                
                if ([responseObject[STATE] isEqualToString:@"0"]) {
                    [MBProgressHUD showSuccessMessage:@"注册成功"];
                    success(YES);
                }else {
                    [MBProgressHUD showErrorMessage:@"服务器忙！！！"];
                    success(NO);
                }
            } failure:^(NSError *error) {
                [MBProgressHUD showErrorMessage:@"服务器忙！！！"];
                success(NO);
            }];
        }
    }];
    
}



/** 重置密码*/
+ (void)resetPasswordWithAccount:(NSString *)account password:(NSString *)password verification:(NSString *)verification response:(void (^)(BOOL success))success {
    BOOL validToLogin = [self validAccount:account password:password verification:verification];
    if (!validToLogin) {//格式不正确，不能登录
        return;
    }
    
    //用afnetworking进行网络请求，responseMsg返回登录账号密码验证结果
    
    
    
}

/** 重置手机号*/
+ (void)resetTelephoneNumber:(NSString *)telephoneNum verification:(NSString *)verification completion:(void(^)(BOOL success))completion{
    
    BOOL validate = [self validAccount:telephoneNum password:nil verification:verification];
    if (validate) {
        
    }
}


#pragma mark -- inner Methods 自定义方法  -------------------------------

/**
 获取验证码
 
 @param mobile 手机号
 */
+ (void)getVerificationByMobile:(NSString *)mobile {
    
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"verCode",PARAC,@"sendMsg2User",PARAM,mobile,MOBILE, nil];
    
    /** 成功 {"state":"0","msg":"OK"}
     入库失败 {"state":"1","msg":"入库失败"}
     发送失败 {"state":"1","msg":"触发分钟级流控Permits:1"} msg 阿里返回错误信息*/
    [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
        
        if ([responseObject[STATE] isEqualToString:@"0"]) {
            [MBProgressHUD showSuccessMessage:@"验证码已发送至手机"];
        }else {
            [MBProgressHUD showErrorMessage:@"服务器忙！！！"];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorMessage:@"网络状态不好"];
    }];
    
}


/** 本地初步验证账号密码验证码的格式正确性*/
+ (BOOL)validAccount:(NSString *)account password:(NSString *)password verification:(NSString *)verification {
    
    if (account && ![NSString isValidMobileNumber:account] ) {
        //提醒手机格式不对
        [MBProgressHUD showTipMessageInView:@"手机号格式不正确"];
        return  NO;
    }
    if (password && password.length < 6) {
        [MBProgressHUD showTipMessageInView:@"密码长度应大于6位"];
        return NO;
    }
    if (verification && verification.length < 6) {
        [MBProgressHUD showTipMessageInView:@"验证码格式不正确"];
        return NO;
    }
    
    return YES;
}


@end
