//
//  ZTAroundController.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/17.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTAroundController.h"

@interface ZTAroundController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZTAroundController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的周边";
    self.imageView = [[UIImageView alloc] initWithImage:imageNamed(@"WechatIMG80")];
//    self.imageView.image = ;
    [self.baseScrollView addSubview:self.imageView];
    
    
    
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.baseScrollView).offset(UIEdgeInsetsZero);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
