//
//  ZTForgetPwdController.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/19.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTForgetPwdController.h"

@interface ZTForgetPwdController ()

@end

@implementation ZTForgetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/** 完全退出控制器*/
- (void)dismissCompletely {
    
    UIViewController *rootVC = self.presentingViewController;
    while (rootVC.presentingViewController) {
        rootVC = rootVC.presentingViewController;
    }
    [rootVC dismissViewControllerAnimated:YES completion:nil];
}

@end
