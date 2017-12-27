//
//  MineWalletController.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/5.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "MineWalletController.h"
#import "MineWithdrawMoneyController.h"

#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+MMDrawerController.h"

@interface MineWalletController ()

@property (nonatomic, strong) UILabel *currentMoneyValue;

@end

@implementation MineWalletController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    [self configSubView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //关闭抽屉模式
//    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    
}

- (void)configSubView {
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"明细" style:UIBarButtonItemStyleDone target:self action:@selector(detail)];
    self.navigationItem.rightBarButtonItem = right;
    
    UIButton *tip = [UIButton buttonWithType:UIButtonTypeCustom];
    tip.userInteractionEnabled = NO;
    tip.backgroundColor = ZTRGB(244, 245, 246);
    [tip setImage:imageNamed(@"security_15x15") forState:UIControlStateNormal];
    [tip setTitle:@"已通过百度安全检测，放心享有安全保障" forState:UIControlStateNormal];
    tip.titleLabel.font = SubTitleFont;
    [tip setTitleColor:SubTitleColor forState:UIControlStateNormal];
    [self.view addSubview:tip];
    
    [tip makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(60);
    }];
    
    
    UILabel *myMoneyTip = [[UILabel alloc] init];
    myMoneyTip.textColor = BlackColor;
    myMoneyTip.font = sysFont(24);
    myMoneyTip.text = @"我的钱包";
    [self.baseScrollView addSubview:myMoneyTip];
    [myMoneyTip makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(20);
    }];
    
    UIImageView *cardImageView = [[UIImageView alloc] init];
    cardImageView.image = imageNamed(@"moneyCard");
    [self.baseScrollView addSubview:cardImageView];
    
    [cardImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.baseScrollView);
        make.top.top.equalTo(myMoneyTip.bottom).offset(20);
        make.width.equalTo(kSCREENWIDTH);
        make.height.equalTo((kSCREENWIDTH)*0.6);
    }];
    
    UILabel *currentMoneyTip = [[UILabel alloc] init];
    currentMoneyTip.font = SubTitleFont;
    currentMoneyTip.textColor = TitleColor;
    currentMoneyTip.text = @"当前余额";
    [self.baseScrollView addSubview:currentMoneyTip];
    
    UILabel *currentMoneyValue = [[UILabel alloc] init];
    currentMoneyValue.font = sysFont(20);
    currentMoneyValue.textColor = BlackColor;
    currentMoneyValue.text = @"1.00元";
    self.currentMoneyValue = currentMoneyValue;
    [self.baseScrollView addSubview:currentMoneyValue];
 
    UIButton *withdrawMoney = [UIButton buttonWithType:UIButtonTypeCustom];
    [withdrawMoney setTitle:@"提现" forState:UIControlStateNormal];
    withdrawMoney.titleLabel.font = NavTitleFont;
    [withdrawMoney setTitleColor:BlackColor forState:UIControlStateNormal];
    withdrawMoney.backgroundColor = LightGraySeperatorColor;
    [withdrawMoney addTarget:self action:@selector(withDrawMoneyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseScrollView addSubview:withdrawMoney];
    
    [currentMoneyTip makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(myMoneyTip);
        make.top.equalTo(cardImageView.bottom).offset(20);
    }];
    
    [currentMoneyValue makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(myMoneyTip);
        make.top.equalTo(currentMoneyTip.bottom).offset(10);
    }];
    
    [withdrawMoney makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.view.right).offset(-20);
        make.top.equalTo(cardImageView.bottom).offset(20);
        make.width.equalTo(80);
        make.bottom.equalTo(currentMoneyValue);
    }];
    
}


/* 明细*/
- (void)detail {
    
    
}


/* 提现*/
- (void)withDrawMoneyClick:(UIButton *)sender {
    
    MineWithdrawMoneyController *withdrawVc = [[MineWithdrawMoneyController alloc] init];
    [self.navigationController pushViewController:withdrawVc animated:YES];
    
}

@end
