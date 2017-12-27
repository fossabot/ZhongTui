//
//  Marco.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/11.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#ifndef Marco_h
#define Marco_h



//---------------------------------  常用的一些单例宏  -----------------------------------------------
///通知中心
#define kNotificationCenter [NSNotificationCenter defaultCenter]
///application单例
#define kApplication        [UIApplication sharedApplication]
///keywindow单例
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
///主屏幕单例
#define kMainScreen         [UIScreen mainScreen]
///APPdelegate
#define kAppDelegate        [UIApplication sharedApplication].delegate
///Userdefaults
#define kUserDefaults      [NSUserDefaults standardUserDefaults]

///APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
///系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]


//屏幕高
#define kSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
//屏幕宽
#define kSCREENWIDTH [UIScreen mainScreen].bounds.size.width

/** 状态栏高度*/
#define ZTStatusBarH [[UIApplication sharedApplication] statusBarFrame].size.height

/** 导航栏高度*/
#define ZTNavgationBarH 44

/** 顶部导航栏和状态栏的高度和*/
#define ZTTopNaviHeight (ZTStatusBarH + ZTNavgationBarH)

#define ZTTabBarH (ZTStatusBarH > 20 ? 83:49)

//带有导航栏的屏幕尺寸
#define kViewRectWithNav CGRectMake(0, ZTTopNaviHeight, kSCREENWIDTH, kSCREENHEIGHT-ZTTopNaviHeight)



//自定义视图的圆角（视图，半径）
#define ZTViewBorderRadiusSimple(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];

//自定义视图的圆角（视图，半径，边框宽度，边框颜色）
#define ZTViewBorderRadiusComplex(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//——————————————————————————————   文件路径获取    ——————————————————————————————————————
///获取temp路径
#define kPathTemp NSTemporaryDirectory()

///获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

///获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]



#pragma mrak  --------------------  常用的固定的宏字符串  -----------------------------

#define LASTLOGINSTATUS @"lastLoginStatus" //发送修改个人主页头部信息时，根据之前的登录状态和现在的登录状态对比(1.之前为0，那么修改个人头部，就以为着登录成功了 2.之前为1说明是在登录状态修改了个人信息，然后根据ZTuser的islogin状态，为0 说明已退出登录，仍为1，则只是更新了个人信息而已)

#define LOGINSTATUS  @"loginStatus"//判断登录状态的宏

#define LASTAPPVERSION  @"lastAppVersion" //本地存储最新版本的APP版本号

#define NETERRORMSG  @"网络在开小差"  ///错误提示宏

#define SIGNDAYS  @"signDays" //签到天数的宏

#define yyyyMMddHHmmss @"yyyy-MM-dd HH:mm:ss"  //时间格式

#define emptyImageName @"zt_empty_112x94_" ///无数据占位图
#define emptyTip  @"重新加载"

#define placeHolderMini @"placeholder"  //图片占位图（小的）

#define placeHolderLarge @"placeholderLarge"  //图片占位图（大的）

#define placeHolderAvatar @"zt_mine_unloginicon_83x83_"   //头像的占位图

#define ISFIRSTINSTALL  @"isFirstInstall"

#define OLDDEVICETOKEN @"oldDeviceToken"
#define NEWDEVICETOKEN @"newDeviceToken"


#endif /* Marco_h */
