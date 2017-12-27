//
//  YYConst.h
//  壹元服务
//
//  Created by VINCENT on 2017/3/22.
//  Copyright © 2017年 北京京壹元资讯信息服务有限公司. All rights reserved.
//


#import <UIKit/UIKit.h>

#pragma mark -------------------------  普通常量  ------------------------------


/** 分页cell的tab高度*/
UIKIT_EXTERN CGFloat const TabHeaderH;

/** 分页cell的tab高度*/
UIKIT_EXTERN CGFloat const ToolBarHeight;


/** 新闻列表的第一个cell的标题字号*/
UIKIT_EXTERN CGFloat const YYInfoCellTitleFont;
/** 新闻列表的第一个cell的描述的字号*/
UIKIT_EXTERN CGFloat const YYInfoCellDescFont;
/** 新闻列表cell里面来源时间点击量的字号*/
UIKIT_EXTERN CGFloat const YYInfoCellSubtitleFont;


/** 新闻列表cell标题的高度*/
UIKIT_EXTERN CGFloat const YYInfoCellTitleHeight;
/** 新闻列表cell里面来源时间点击量的高度*/
UIKIT_EXTERN CGFloat const YYInfoCellSubtitleHeight;
/** 新闻列表大的cellimageView的高度*/
UIKIT_EXTERN CGFloat const YYInfoCellBigImageViewHeight;
/** 新闻列表小的cellimageView的高度*/
UIKIT_EXTERN CGFloat const YYInfoCellMiniImageViewHeight;
/** 新闻列表小的cellimageView的宽度*/
UIKIT_EXTERN CGFloat const YYInfoCellMiniImageViewWidth;


/** 新闻列表的通用间隙*/
UIKIT_EXTERN CGFloat const YYInfoCellCommonMargin;
/** 新闻列表副标题的文字间隔*/
UIKIT_EXTERN CGFloat const YYInfoCellSubMargin;


/** 音乐播放器的高度*/
UIKIT_EXTERN CGFloat const YYInfoMusicPlayerHeight;


/** 手机号长度*/
UIKIT_EXTERN NSInteger const telephoneLength;
/** 验证码长度*/
UIKIT_EXTERN NSInteger const verificationLength;




#pragma mark -----------------------  友盟分享的三方平台  -------------------------

/** 友盟APPKEY*/
UIKIT_EXTERN NSString * const USHARE_APPKEY;

/** qq开放平台APPID 和 QQ互联的APPID一致*/
UIKIT_EXTERN NSString * const QQ_APPID;

/** qq开放平台APPKEY*/
UIKIT_EXTERN NSString * const QQ_APPKEY;

/** 微信APPID*/
UIKIT_EXTERN NSString * const WECHAT_APPID;

/** 微信APPSECRET*/
UIKIT_EXTERN NSString * const WECHAT_APPSECRET;

/** 新浪APPID*/
UIKIT_EXTERN NSString * const SINA_APPKEY;

/** 新浪APPSECRET*/
UIKIT_EXTERN NSString * const SINA_APPSECRET;




#pragma mark ------------------------  友盟推送  --------------------------------

/** 友盟推送 APPKEY*/
UIKIT_EXTERN NSString * const UPUSH_APPKEY;

/** 友盟推送 APPSECRET*/
UIKIT_EXTERN NSString * const UPUSH_APPSECRET;




#pragma mark ----------------------  腾讯Bugly错误统计  --------------------------

/** 腾讯Bugly错误统计 APPID*/
UIKIT_EXTERN NSString * const BUGLY_APPID;

/** 腾讯Bugly错误统计 APPKEY*/
UIKIT_EXTERN NSString * const BUGLY_APPKEY;




#pragma mark -----------------------  钥匙串的Service  --------------------------

/** 保存密码的keychain Service*/
UIKIT_EXTERN NSString * const KEYCHAIN_SERVICE_LOGIN;

/** 最后一次登录的账号*/
UIKIT_EXTERN NSString * const KEYCHAIN_LASTLOGINACCOUNT;



#pragma mark ------------------------  网络变化的通知  ---------------------------

/** 网络变化*/
UIKIT_EXTERN NSString * const kNetworkChangedNotification;




#pragma mark ------------------------  常用的通知宏  ----------------------------

/** 重复点击tabbar的通知宏*/
UIKIT_EXTERN NSString * const ZTTabbarItemDidRepeatClickNotification;

/** 接收到远程消息的通知*/
UIKIT_EXTERN NSString * const ZTReceivedRemoteNotification;

/** 用户单例类信息发生改变的通知*/
UIKIT_EXTERN NSString * const ZTUserInfoDidChangedNotification;


