//
//  ZTUser.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/15.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTUser : NSObject

ZTSingletonH(User)

#pragma mark ---------  后台的个人信息数据  ------------
/** userid*/
@property (nonatomic, copy) NSString *userid;

/** user_name*/
@property (nonatomic, copy) NSString *user_name;

/** avatar 头像*/
@property (nonatomic, copy) NSString *avatar;

/** address 地址*/
@property (nonatomic, copy) NSString *address;

/** gender 性别*/
@property (nonatomic, copy) NSString *gender;

/** age 年岭*/
@property (nonatomic, copy) NSString *age;

/** vocation 职业*/
@property (nonatomic, copy) NSString *vocation;

/** mobile 手机*/
@property (nonatomic, copy) NSString *mobile;

/** password 密码*/
@property (nonatomic, copy) NSString *password;

/** experience 经验*/
@property (nonatomic, copy) NSString *experience;

/** his_revenue 历史收入*/
@property (nonatomic, copy) NSString *his_revenue;

/** rest_revenue 余额*/
@property (nonatomic, copy) NSString *rest_revenue;

/** user_team 团队贡献*/
@property (nonatomic, copy) NSString *user_team;

/** install_time 安装的时间*/
@property (nonatomic, copy) NSString *install_time;

/** register_time 注册的时间*/
@property (nonatomic, copy) NSString *register_time;

/** speed_card_state 加速卡的状态*/
@property (nonatomic, copy) NSString *speed_card_state;

/** speed_card 加速卡*/
@property (nonatomic, copy) NSString *speed_card;

/** mobile_type 手机类型  iOS/Android*/
@property (nonatomic, copy) NSString *mobile_type;

/** login_state 登录状态*/
@property (nonatomic, copy) NSString *login_state;

/** devicetoken  设备唯一标识*/
@property (nonatomic, copy) NSString *devicetoken;

/** token 认证标识*/
@property (nonatomic, copy) NSString *token;


#pragma mark  -----------  本地的个人信息数据  -------------

/** 登录状态isLogin*/
@property (nonatomic, assign) BOOL isLogin;


/**
 填充个人信息
 */
+ (void)configUserInfoWithDic:(NSDictionary *)infoDic;

/**
 *  检查用户个人信息是否发生了变化
 */
+ (BOOL)checkUserInfoChanged:(NSArray <NSString *>*)userProperty rawUserProperty:(NSArray <NSString *>*)rawUserProperty;

/**
 用户登出，删除所有用户信息
 */
+ (void)logOut;



@end
