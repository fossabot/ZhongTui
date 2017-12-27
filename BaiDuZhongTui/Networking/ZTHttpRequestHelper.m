//
//  ZTHttpRequestHelper.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/14.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTHttpRequestHelper.h"
#import "AFNetworking.h"
#import "UIImage+Category.h"

static AFHTTPSessionManager *_httpManager;

@implementation ZTHttpRequestHelper


+ (AFHTTPSessionManager *)httpManager {

    if (!_httpManager) {
        _httpManager = [AFHTTPSessionManager manager];
    }
    return _httpManager;
}


+ (void)GETUrl:(NSString *)url param:(id)param success:(void(^)(id result))success failure:(void(^)(NSError *error))failure {
    
    [[self httpManager] GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)POSTUrl:(NSString *)url param:(id)param success:(void(^)(id result))success failure:(void(^)(NSError *error))failure {
    
    [[self httpManager] POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)UPLOADFileWithUrl:(NSString *)url param:(id)param image:(UIImage *)image serverName:(NSString *)serverName savedName:(NSString *)filename progress:(void (^)(int64_t, int64_t))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    UIImage *scaleImage = [image compressToByte:400*1024];
    NSData *imageData = UIImageJPEGRepresentation(scaleImage, 1.0);
    [[self httpManager] POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:serverName fileName:filename mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        ZTLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
    
}

+ (void)cancelAllOpreation {
    
    [[self httpManager].operationQueue cancelAllOperations];
}


@end
