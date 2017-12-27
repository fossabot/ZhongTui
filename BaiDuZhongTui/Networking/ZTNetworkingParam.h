//
//  ZTNetworkingParam.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/14.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ZTHttpRequestType) {
    ZTHttpRequestTypeGet,
    ZTHttpRequestTypePost,
    ZTHttpRequestTypeUpload,
};;

//网络状态
#define NetworkNotReachable  @"NetworkNotReachable"
#define NetworkWWAN  @"NetworkWWAN"
#define NetworkWIFI  @"NetworkWIFI"

//项目的基本接口host

#define ZTHOST  @"http://zt.ywvx.com"
#define ZTBaseUrl  @"http://zt.ywvx.com/application/index.php"

