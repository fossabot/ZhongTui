//
//  ZTUser.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/15.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTUser.h"

@implementation ZTUser

ZTSingletonM(User)

#pragma mark method

/**
 填充个人信息
 */
+ (void)configUserInfoWithDic:(NSDictionary *)infoDic {
 
    for (NSString *property in [infoDic allKeys]) {
        NSString *zt_property = [NSString stringWithFormat:@"zt_%@",property];
        if (![infoDic[property] isKindOfClass:[NSNull class]]) {
            //            NSString *str = (NSString *)infoDic[property];
            [kUserDefaults setObject:infoDic[property] forKey:zt_property];
        }else{
            [kUserDefaults setObject:@"" forKey:zt_property];
        }
    }
    [kUserDefaults setBool:YES forKey:LOGINSTATUS];
    [kUserDefaults synchronize];
}

+ (BOOL)checkUserInfoChanged:(NSArray<NSString *> *)userProperties rawUserProperty:(NSArray<NSString *> *)rawUserProperties {
    
    BOOL _isChanged = NO;
    
    for (int i=0; i<userProperties.count; i++) {
        if (![userProperties[i] isEqualToString:rawUserProperties[i]]) {
            return YES;
        }
    }
    return _isChanged;
}


/**
 用户登出，删除所有用户信息
 */
+ (void)logOut {
    
//    ZTUser *user = [self shareUser];
//    [[SDImageCache sharedImageCache] removeImageForKey:user.avatar withCompletion:^{
//        
//    }];
    
    //将user的各属性置为nil
    
    ZTWeakSelf
    [[kUserDefaults dictionaryRepresentation] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
     {
         if([key hasPrefix:@"zt_"])
         {
             [kUserDefaults removeObjectForKey:key];
         }
         [kUserDefaults setBool:NO forKey:LOGINSTATUS];
         [kUserDefaults synchronize];
         [weakSelf alertNotification];
     }];
    
}


/** 提醒代理 该干活了*/
+ (void)alertNotification {
    
    [kNotificationCenter postNotificationName:ZTUserInfoDidChangedNotification object:nil userInfo:@{LASTLOGINSTATUS:@YES}];
}


#pragma mark setter

- (void)setUserid:(NSString *)userid {
    [kUserDefaults setValue:userid forKey:@"zt_userid"];
    [kUserDefaults synchronize];
}

- (NSString *)userid {
    return [kUserDefaults valueForKey:@"zt_userid"];
}

- (void)setUser_name:(NSString *)user_name {
    [kUserDefaults setValue:user_name forKey:@"zt_user_name"];
    [kUserDefaults synchronize];
}

- (NSString *)user_name {
    return [kUserDefaults valueForKey:@"zt_user_name"];
}

- (void)setAvatar:(NSString *)avatar {
    [kUserDefaults setValue:avatar forKey:@"zt_avatar"];
    [kUserDefaults synchronize];
}

- (NSString *)avatar {
    return [kUserDefaults valueForKey:@"zt_avatar"];
}

- (void)setAddress:(NSString *)address {
    [kUserDefaults setValue:address forKey:@"zt_address"];
    [kUserDefaults synchronize];
}

- (NSString *)address {
    return [kUserDefaults valueForKey:@"zt_address"];
}

- (void)setGender:(NSString *)gender {
    [kUserDefaults setValue:gender forKey:@"zt_gender"];
    [kUserDefaults synchronize];
}

- (NSString *)gender {
    return [kUserDefaults valueForKey:@"zt_gender"];
}

- (void)setAge:(NSString *)age {
    [kUserDefaults setValue:age forKey:@"zt_age"];
    [kUserDefaults synchronize];
}

- (NSString *)age {
    return [kUserDefaults valueForKey:@"zt_age"];
}

-(void)setVocation:(NSString *)vocation {
    [kUserDefaults setValue:vocation forKey:@"zt_vocation"];
    [kUserDefaults synchronize];
}

- (NSString *)vocation {
    return [kUserDefaults valueForKey:@"zt_vocation"];
}

-(void)setMobile:(NSString *)mobile {
    [kUserDefaults setValue:mobile forKey:@"zt_mobile"];
    [kUserDefaults synchronize];
}

- (NSString *)mobile {
    return [kUserDefaults valueForKey:@"zt_mobile"];
}

- (void)setPassword:(NSString *)password {
    [kUserDefaults setValue:password forKey:@"zt_password"];
    [kUserDefaults synchronize];
}

- (NSString *)password {
    return [kUserDefaults valueForKey:@"zt_password"];
}

- (void)setExperience:(NSString *)experience {
    [kUserDefaults setValue:experience forKey:@"zt_experience"];
    [kUserDefaults synchronize];
}

- (NSString *)experience {
    return [kUserDefaults valueForKey:@"zt_experience"];
}

- (void)setHis_revenue:(NSString *)his_revenue {
    [kUserDefaults setValue:his_revenue forKey:@"zt_his_revenue"];
    [kUserDefaults synchronize];
}

- (NSString *)his_revenue {
    return [kUserDefaults valueForKey:@"zt_his_revenue"];
}

- (void)setRest_revenue:(NSString *)rest_revenue {
    [kUserDefaults setValue:rest_revenue forKey:@"zt_rest_revenue"];
    [kUserDefaults synchronize];
}

- (NSString *)rest_revenue {
    return [kUserDefaults valueForKey:@"zt_rest_revenue"];
}

- (void)setUser_team:(NSString *)user_team {
    [kUserDefaults setValue:user_team forKey:@"zt_user_team"];
    [kUserDefaults synchronize];
}

- (NSString *)user_team {
    return [kUserDefaults valueForKey:@"zt_user_team"];
}

- (void)setInstall_time:(NSString *)install_time {
    [kUserDefaults setValue:install_time forKey:@"zt_install_time"];
    [kUserDefaults synchronize];
}

- (NSString *)install_time {
    return [kUserDefaults valueForKey:@"zt_install_time"];
}

- (void)setRegister_time:(NSString *)register_time {
    [kUserDefaults setValue:register_time forKey:@"zt_register_time"];
    [kUserDefaults synchronize];
}

- (NSString *)register_time {
    return [kUserDefaults valueForKey:@"zt_register_time"];
}

- (void)setSpeed_card_state:(NSString *)speed_card_state {
    [kUserDefaults setValue:speed_card_state forKey:@"zt_speed_card_state"];
    [kUserDefaults synchronize];
}

- (NSString *)speed_card_state {
    return [kUserDefaults valueForKey:@"zt_speed_card_state"];
}

- (void)setSpeed_card:(NSString *)speed_card {
    [kUserDefaults setValue:speed_card forKey:@"zt_speed_card"];
    [kUserDefaults synchronize];
}

- (NSString *)speed_card {
    return [kUserDefaults valueForKey:@"zt_speed_card"];
}

- (void)setMobile_type:(NSString *)mobile_type {
    [kUserDefaults setValue:mobile_type forKey:@"zt_mobile_type"];
    [kUserDefaults synchronize];
}

- (NSString *)mobile_type {
    return [kUserDefaults valueForKey:@"zt_mobile_type"];
}

- (void)setLogin_state:(NSString *)login_state {
    [kUserDefaults setValue:login_state forKey:@"zt_login_state"];
    [kUserDefaults synchronize];
}

- (NSString *)login_state {
    return [kUserDefaults valueForKey:@"zt_login_state"];
}

- (void)setDevicetoken:(NSString *)devicetoken {
    [kUserDefaults setValue:devicetoken forKey:@"zt_devicetoken"];
    [kUserDefaults synchronize];
}

- (NSString *)devicetoken {
    return [kUserDefaults valueForKey:@"zt_devicetoken"];
}

- (void)setToken:(NSString *)token {
    [kUserDefaults setValue:token forKey:@"zt_token"];
    [kUserDefaults synchronize];
}

- (NSString *)token {
    return [kUserDefaults valueForKey:@"zt_token"];
}

#pragma mark  -----------  本地的个人信息数据  -------------

- (void)setIsLogin:(BOOL)isLogin {
    [kUserDefaults setBool:isLogin forKey:LOGINSTATUS];
    [kUserDefaults synchronize];
}

- (BOOL)isLogin {
    return [kUserDefaults boolForKey:LOGINSTATUS];
}



@end
