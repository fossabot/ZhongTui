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
#import "YYNavigationViewController.h"


@interface AppDelegate ()

@property (nonatomic, strong) MMDrawerController *drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self registerUShare];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainViewController *main = [[MainViewController alloc] init];
    YYNavigationViewController *mainNav = [[YYNavigationViewController alloc] initWithRootViewController:main];
    [mainNav setRestorationIdentifier:MainViewControllerIdetifier];
    
    LeftViewController *left = [[LeftViewController alloc] init];
    
    YYNavigationViewController *leftNav = [[YYNavigationViewController alloc] initWithRootViewController:left];
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
