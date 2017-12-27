//
//  Api.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/11.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#ifndef Api_h
#define Api_h

#define BaseUrl  @"http://zt.ywvx.com/application/index.php"

#pragma mark  request parameters key  ----------------

#define PARAC @"c"
#define PARAM @"m"
#define MOBILE @"mobile"
#define PWD  @"pwd"
#define DEVICETOKEN  @"devicetoken"
#define VERCODE  @"verCode"

#define MOBILETYPE  @"mobileType"
#define USERID  @"userid"
#define TOKEN  @"token"

#define TIMES  @"times"


#pragma mark  response parameters key  ------------------

#define STATE @"state"   //返回知道状态码 0成功  1失败
#define MSG  @"msg"    //返回的状态信息，没啥用
#define USERINFO @"userInfo"  //个人信息


#endif /* Api_h */
