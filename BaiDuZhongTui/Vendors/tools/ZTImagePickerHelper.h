//
//  ZTImagePickerHelper.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2018/1/5.
//  Copyright © 2018年 YiWangTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTImagePickerHelper : NSObject

+ (void)showImagePicker:(void(^)(UIImage *sourceImage))completion;

@end
