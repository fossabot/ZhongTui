//
//  ZTImagePickerHelper.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2018/1/5.
//  Copyright © 2018年 YiWangTech. All rights reserved.
//

#import "ZTImagePickerHelper.h"

static UIImagePickerController *_imagePicker;
static ZTImagePickerHelper *_helper;
static UIAlertController *alert;

typedef void(^Completion)(UIImage *image);

@interface ZTImagePickerHelper ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

/** completion*/
@property (nonatomic, copy) Completion completion;

@end


@implementation ZTImagePickerHelper

+ (UIImagePickerController *)imagePicker {
    
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
    }
    return _imagePicker;
}

+ (ZTImagePickerHelper *)helper {
    if (!_helper) {
        _helper = [[ZTImagePickerHelper alloc] init];
    }
    return _helper;
}

+ (void)showImagePicker:(void (^)(UIImage *))completion {
    
    [self helper].completion = completion;
    [self imagePicker].allowsEditing = YES;
    _imagePicker.delegate = [self helper];
    
    alert = [UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self addLibrary];
    [self addCamera];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancel];
    
    [kKeyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

+ (void)addLibrary {

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        NSLog(@"sorry, no PhotoLibrary or PhotoLibrary is unavailable!!!");
        
        return;
        
    }
    
    UIAlertAction *library = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self showLibrary];
    }];
    
    [alert addAction:library];
    
}

+ (void)addCamera {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        NSLog(@"sorry, no camera or camera is unavailable!!!");
        
        return;
        
    }
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self showCamera];
    }];
    [alert addAction:camera];
}

+ (void)showLibrary {
    
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [kKeyWindow.rootViewController presentViewController:_imagePicker animated:YES completion:nil];
}

+ (void)showCamera {
    
    _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [kKeyWindow.rootViewController presentViewController:_imagePicker animated:YES completion:nil];
}

#pragma mark imagepickerdelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    _helper.completion(image);
    [_imagePicker dismissViewControllerAnimated:YES completion:nil];
}

@end
