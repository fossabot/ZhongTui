//
//  ArticleDetailViewController.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/5.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import <MBProgressHUD.h>
#import "ShareView.h"
#import "PlaceHolderView.h"
#import "MineWalletController.h"


static NSString * urlstr = @"http://test.ywvx.com/zhongtui/articleDetails.html";

@interface ArticleDetailViewController ()<UIWebViewDelegate>

@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:imageNamed(@"share_32x32") style:UIBarButtonItemStyleDone target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = right;    
    
    UIWebView *web = [[UIWebView alloc] init];
    web.delegate = self;
    [self.view addSubview:web];
    [web makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:imageNamed(@"shareImage") forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    [shareBtn makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
        make.width.equalTo(60);
        make.height.equalTo(60);
    }];
    
    NSURL *url = [NSURL URLWithString:self.url];
    [web loadRequest:[NSURLRequest requestWithURL:url]];
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView {

    [MBProgressHUD showActivityMessageInView:@"加载中...."];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [hud hideAnimated:YES];
    
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [MBProgressHUD showErrorMessage:@"网络出错"];

    weakObject(webView)
    [PlaceHolderView showInView:webView imageName:emptyImageName tip:emptyTip completion:^{
       
        [weakwebView reload];
    }];
}




- (void)share {
    
    ZTWeakSelf
    [ShareView shareWithTitle:self.navigationItem.title subTitle:@"" webUrl:self.url imageUrl:nil isCollected:NO shareViewContain:nil shareContentType:ShareContentTypeWeb finished:^(ShareViewType shareViewType, BOOL isFavor, BOOL success) {
        
        if (success) {//分享成功回调
            
            [PlaceHolderView showShareSucceed:^{
               
                MineWalletController *wallet = [[MineWalletController alloc] init];
                [weakSelf.navigationController pushViewController:wallet animated:YES];
            }];
        }
    }];
}





@end
