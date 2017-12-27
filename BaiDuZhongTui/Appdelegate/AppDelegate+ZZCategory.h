//
//  AppDelegate+ZZCategory.h
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/6.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "AppDelegate.h"

#import <UMSocialCore/UMSocialCore.h>
#import "UMessage.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate (ZZCategory)
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
<UNUserNotificationCenterDelegate>
#endif

/**
 *  友盟分享注册
 */
- (void)registerUShare;

/**
 *  注册友盟推送
 */
- (void)registerUPushForLaunchOption:(NSDictionary *)launchOption;

/**
 *  开启网络监控
 */
- (void)startMonitor;

/**
 *  安装回调
 */
- (void)install;



@end
