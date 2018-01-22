//
//  ZTInviteController.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2018/1/2.
//  Copyright © 2018年 YiWangTech. All rights reserved.
//

#import "ZTInviteController.h"
#import <MBProgressHUD.h>
#import "ShareView.h"
#import "PlaceHolderView.h"
#import "MineWalletController.h"


static NSString * shareUrl = @"http://zt.ywvx.com/zhongtui/downloadAPP.php?userid=";
static NSString * inviteUrl = @"http://zt.ywvx.com/zhongtui/inviteFriends.php";

@interface ZTInviteController ()<UIWebViewDelegate>

@end

@implementation ZTInviteController

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
    
    NSURL *url = [NSURL URLWithString:inviteUrl];
    [web loadRequest:[NSURLRequest requestWithURL:url]];
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [MBProgressHUD showActivityMessageInView:@"加载中...."];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //    MBProgressHUD *hud = [MBProgressHUD HUDForView:webView];
    ////    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //    [hud hideAnimated:YES];
    
    [MBProgressHUD hideHUD];
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
    [ShareView shareWithTitle:self.navigationItem.title subTitle:@"" webUrl:shareUrl imageUrl:nil isCollected:NO shareViewContain:nil shareContentType:ShareContentTypeWeb finished:^(ShareViewType shareViewType, BOOL isFavor, BOOL success) {
        
        //        switch (shareViewType) {
        //            case ShareViewTypeWechat:
        //            case ShareViewTypeWechatTimeline:{
        //
        //                NSString *url = @"http://zt.ywvx.com/application/getShareParam.php";
        //                NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:<#(nonnull id), ...#>, nil]
        //                [PPNetworkHelper POST:url parameters:<#(id)#> success:<#^(id responseObject)success#> failure:<#^(NSError *error)failure#>];
        //
        //            }
        //                break;
        //            default:{
        //
        //            }
        //                break;
        //        }
        //
        
        if (success) {//分享成功回调
            
            [MBProgressHUD showSuccessMessage:@"分享成功"];
        }
    }];
    
}
@end
