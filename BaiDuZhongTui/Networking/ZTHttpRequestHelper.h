//
//  ZTHttpRequestHelper.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/14.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface ZTHttpRequestHelper : NSObject


+ (void)GETUrl:(NSString *)url param:(id)param success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;


+ (void)POSTUrl:(NSString *)url param:(id)param success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;


+ (void)UPLOADFileWithUrl:(NSString *)url
                    param:(id )param
                    image:(UIImage *)image
               serverName:(NSString *)serverName
                savedName:(NSString *)filename
                 progress:(void (^)(int64_t bytesProgress,int64_t totalBytesProgress))progress
                  success:(void(^)(id result))success
                  failure:(void(^)(NSError *error))failure;


+ (void)cancelAllOpreation;

@end
