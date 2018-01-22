//
//  YYConst.m
//  壹元服务
//
//  Created by VINCENT on 2017/3/22.
//  Copyright © 2017年 北京京壹元资讯信息服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 分页cell的tab高度*/
CGFloat const TabHeaderH = 40;

/** 分页cell的tab高度*/
CGFloat const ToolBarHeight = 45;

/** 新闻列表的第一个cell的标题字号*/
CGFloat const YYInfoCellTitleFont = 16;
/** 新闻列表的第一个cell的描述的字号*/
CGFloat const YYInfoCellDescFont = 14;
/** 新闻列表cell里面来源时间点击量的字号*/
CGFloat const YYInfoCellSubtitleFont = 12;


/** 新闻列表cell标题的高度*/
CGFloat const YYInfoCellTitleHeight = 30.f;
/** 新闻列表cell里面来源时间点击量的高度*/
CGFloat const YYInfoCellSubtitleHeight = 15.f;
/** 新闻列表cellimageView的高度*/
CGFloat const YYInfoCellBigImageViewHeight = 60.f;
/** 新闻列表小的cellimageView的高度*/
CGFloat const YYInfoCellMiniImageViewHeight = 30.f;
/** 新闻列表小的cellimageView的宽度*/
CGFloat const YYInfoCellMiniImageViewWidth = 45.f;


/** 新闻列表的通用间隙*/
CGFloat const YYInfoCellCommonMargin = 10.f;
/** 新闻列表副标题的文字间隔*/
CGFloat const YYInfoCellSubMargin = 5.f;


/** 音乐播放器的高度*/
CGFloat const YYInfoMusicPlayerHeight = 60.f;


/** 手机号长度*/
NSInteger const telephoneLength = 11;
/** 验证码长度*/
NSInteger const verificationLength = 6;


#pragma mark -----------------------  友盟分享的三方数据  -------------------------

/** 友盟APPKEY*/
NSString * const USHARE_APPKEY = @"5a12908fb27b0a44f000000d";

/** qq开放平台APPID 和 QQ互联的APPID一致*/
NSString * const QQ_APPID = @"1106454167"; 

/** qq开放平台APPKEY*/
NSString * const QQ_APPKEY = @"v8XNYPspV8L1GT6M";

/** 微信APPID*/
NSString * const WECHAT_APPID = @"wxb7115c36f5d4325b";

/** 微信APPSECRET*/
NSString * const WECHAT_APPSECRET = @"e68db74b53ca36e21134f6c63d733dc0";

/** 新浪APPID*/
NSString * const SINA_APPKEY = @"1029653543";

/** 新浪APPSECRET*/
NSString * const SINA_APPSECRET = @"7dd9d036191294b4b3ebc2eb2c83646e";


#pragma mark ------------------------  友盟推送   ----------------------------

/** 友盟推送 APPKEY*/
NSString * const UPUSH_APPKEY = @"595e0296b27b0a077f000674";

/** 友盟推送 APPSECRET*/
NSString * const UPUSH_APPSECRET = @"t6qxjcjxk2eug5p5loicscx2qztaidlp";


#pragma mark ----------------------  腾讯Bugly错误统计  --------------------------

/** 腾讯Bugly错误统计 APPID*/
NSString * const BUGLY_APPID = @"660117ce1d";

/** 腾讯Bugly错误统计 APPKEY*/
NSString * const BUGLY_APPKEY = @"937af888-4415-4931-9bee-ab4f2d8db41c";


#pragma mark ------------------------  钥匙串的Service ----------------------------

/** 保存密码的keychain Service*/
NSString * const KEYCHAIN_SERVICE_LOGIN = @"kerchain_service_login";

NSString * const KEYCHAIN_LASTLOGINACCOUNT = @"kerchain_lastloginaccount";


#pragma mark -----------------------------  网络变化的通知 -------------------

/** 网络变化*/
NSString * const kNetworkChangedNotification = @"kNetworkChangedNotification";


#pragma mark -----------------------------  常用的通知宏   -------------------------------

/** 重复点击tabbar的通知宏*/
NSString * const ZTTabbarItemDidRepeatClickNotification = @"ZTTabbarItemDidRepeatClickNotification";

/** 接收到远程消息的通知*/
NSString * const ZTReceivedRemoteNotification = @"ZTReceivedRemoteNotification";

/** 用户单例类信息发生改变的通知  userInfo：{ LASTLOGINSTATUS: @"0"代表之前是退出状态  @"1"代表之前是登录状态}*/
NSString * const ZTUserInfoDidChangedNotification = @"ZTUserInfoDidChangedNotification";

/** 用户的登录状态发生改变的时候*/
NSString * const ZTLoginStatusDidChangedNotification = @"ZTLoginStatusDidChangedNotification";



