//
//  AppDelegate+ZZCategory.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/6.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "AppDelegate+ZZCategory.h"
#import "AFNetworkReachabilityManager.h"
#import "ZTNetworkingParam.h"
#import "ZTUserManager.h"

@implementation AppDelegate (ZZCategory)

/**
 *  友盟分享注册
 */
- (void)registerUShare {
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:NO];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_APPKEY];
    
    //关闭强制https，可以分享http的图片
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WECHAT_APPID appSecret:WECHAT_APPSECRET redirectURL:nil];
    
    /* 移除相应平台的分享，如微信收藏 */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQ_APPID  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SINA_APPKEY  appSecret:SINA_APPSECRET redirectURL:@"https://api.weibo.com/oauth2/default.html"];
    
    
}

/**
 *  注册友盟推送
 */
- (void)registerUPushForLaunchOption:(NSDictionary *)launchOption {
    
//    [UMessage startWithAppkey:UPUSH_APPKEY launchOptions:launchOption];
    [UMessage registerForRemoteNotifications];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
#endif
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
    
}


- (void)startMonitor {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NetworkNotReachable object:nil];
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWWAN)
        {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NetworkWWAN object:nil];
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
        
            [[NSNotificationCenter defaultCenter] postNotificationName:NetworkWIFI object:nil];
        }
        
    }];
}


/**
 *  安装回调
 */
- (void)install {
    
    NSString *oldDeviceToken = [kUserDefaults valueForKey:OLDDEVICETOKEN];
    NSString *newDeviceToken = [kUserDefaults valueForKey:NEWDEVICETOKEN];
    if (![oldDeviceToken isEqualToString:newDeviceToken]) {
        
        [ZTUserManager installFeedback];
    }
}


@end
