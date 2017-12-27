//
//  AppDelegate.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+ZZCategory.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import <MMDrawerController.h>
#import "MMExampleDrawerVisualStateManager.h"
#import <MMDrawerVisualState.h>
#import "ZTNavigationViewController.h"

#import "ZTUser.h"

@interface AppDelegate ()

@property (nonatomic, strong) MMDrawerController *drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self registerUShare];
    [self registerUPushForLaunchOption:launchOptions];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainViewController *main = [[MainViewController alloc] init];
    ZTNavigationViewController *mainNav = [[ZTNavigationViewController alloc] initWithRootViewController:main];
    [mainNav setRestorationIdentifier:MainViewControllerIdetifier];
    
    LeftViewController *left = [[LeftViewController alloc] init];
    
    ZTNavigationViewController *leftNav = [[ZTNavigationViewController alloc] initWithRootViewController:left];
    [leftNav setRestorationIdentifier:LeftViewControllerIdetifier];
    left.jz_wantsNavigationBarVisible = NO;
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:mainNav
                             leftDrawerViewController:leftNav];
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setRestorationIdentifier:MMDrawerControllerIdetifier];
    [self.drawerController setMaximumLeftDrawerWidth:280.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeParallax];

    //http://www.jianshu.com/users/24da48b2ddb3/latest_articles
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         
         UIViewController * sideDrawerViewController;
         if(drawerSide == MMDrawerSideLeft){
             sideDrawerViewController = drawerController.leftDrawerViewController;
         }
         [sideDrawerViewController.view setAlpha:percentVisible];
         
     }];
    
    UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                          green:173.0/255.0
                                           blue:234.0/255.0
                                          alpha:1.0];
    
    [self.window setTintColor:tintColor];
    self.window.backgroundColor = WhiteColor;
    [self.window setRootViewController:self.drawerController];
    
    [self.window makeKeyAndVisible];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    return YES;
}


// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *deviceTokenStr = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    ZTUser *user = [ZTUser shareUser];
    user.devicetoken = deviceTokenStr;
    [kUserDefaults setValue:deviceTokenStr forKey:NEWDEVICETOKEN];
    [kUserDefaults synchronize];
    [self install];
    ZTLog(@"DEVIVETOKEN-------%@",deviceTokenStr);
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
