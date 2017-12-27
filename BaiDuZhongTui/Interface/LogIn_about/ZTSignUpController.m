//
//  ZTSignUpController.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/12.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTSignUpController.h"

#import "ZTCountDownButton.h"
#import "ZTTextFilter.h"
#import "ZTNavView.h"
#import "ZTUserManager.h"

#import <SAMKeychain.h>

#import "NSString+Predicate.h"
#import "UITextField+LeftView.h"

@interface ZTSignUpController ()<NavViewDelegate,ZTTextFilterDelegate,UITextFieldDelegate>

/** navView*/
@property (nonatomic, strong) ZTNavView *navView;
@property (nonatomic, strong) UIImageView *imageView;

/** container*/
@property (nonatomic, strong) UIView *container;

/** 手机号*/
@property (strong, nonatomic) UITextField *telephoneTextfield;

/** separator1*/
@property (nonatomic, strong) UIView *separator1;

/** 验证码*/
@property (strong, nonatomic) UITextField *verificationTextfield;

/** verificationBtn*/
@property (nonatomic, strong) ZTCountDownButton *verificationBtn;

/** separator2*/
@property (nonatomic, strong) UIView *separator2;

/** 密码*/
@property (strong, nonatomic) UITextField *passwordTextfield;

/** separator3*/
@property (nonatomic, strong) UIView *separator3;

/** 注册按钮*/
@property (strong, nonatomic) UIButton *registeButton;

/** textFilter*/
@property (nonatomic,strong) ZTTextFilter *textFilterAccount; //账号输入框限制条件
@property (nonatomic,strong) ZTTextFilter *textFilterPassword; //密码输入框限制条件
@property (nonatomic,strong) ZTTextFilter *textFilterVerification; //验证码输入框限制条件


@end

@implementation ZTSignUpController
{
    UIStatusBarStyle _statusBarStyle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubView];
    [self masonrySubView];
    [self configTextfield];
    kApplication.statusBarStyle = UIStatusBarStyleDefault;
//    _statusBarStyle = kApplication.statusBarStyle;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    kApplication.statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [kApplication setStatusBarStyle:_statusBarStyle animated:YES];
}


#pragma mark -- layout 子控件配置及相关布局方法  ---------------------------

- (void)configSubView {
    
    ZTNavView *navView = [[ZTNavView alloc] init];
    navView.title = @"注册";
    navView.leftImageName = @"login_close";
    navView.delegate = self;
    self.navView = navView;
    [self.view addSubview:navView];
    
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.image = imageNamed(@"loginHeader");
    self.imageView = headerImageView;
    [self.view addSubview:headerImageView];
    
    UIView *container = [[UIView alloc] init];
    self.container = container;
    [self.view addSubview:container];
    
    UITextField *telephoneTextfield = [[UITextField alloc] init];
    telephoneTextfield.delegate = self;
    telephoneTextfield.font = SubTitleFont;
    telephoneTextfield.placeholder = @"请输入手机号";
//    telephoneTextfield.tintColor = ThemeColor;
    [telephoneTextfield setLeftViewWithImage:@"textfield_leftview_telephone_25x25_"];
    [self.container addSubview:telephoneTextfield];
    self.telephoneTextfield = telephoneTextfield;
    
    UIView *separator1 = [[UIView alloc] init];
    separator1.backgroundColor = ThemeColor;
    self.separator1 = separator1;
    [self.container addSubview:separator1];
    
    UITextField *verificationtextField = [[UITextField alloc] init];
    verificationtextField.delegate = self;
    verificationtextField.font = SubTitleFont;
    verificationtextField.placeholder = @"请输入验证码";
//    verificationtextField.tintColor = ThemeColor;
    [verificationtextField setLeftViewWithImage:@"textfield_leftview_verification_25x25_"];
    [self.container addSubview:verificationtextField];
    self.verificationTextfield = verificationtextField;
    
    ZTCountDownButton *verificationBtn = [[ZTCountDownButton alloc] init];
    verificationBtn.titleLabel.font = SubTitleFont;
    verificationBtn.layer.cornerRadius = 5;
    verificationBtn.layer.borderColor = ThemeColor.CGColor;
    verificationBtn.layer.borderWidth = 0.5;
    verificationBtn.backgroundColor = WhiteColor;
    [verificationBtn setTitleColor:ThemeColor forState:UIControlStateNormal];
    [verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verificationBtn addTarget:self action:@selector(getVerificattion:) forControlEvents:UIControlEventTouchUpInside];
    self.verificationBtn = verificationBtn;
    [self.container addSubview:verificationBtn];
    
    
    UIView *separator2 = [[UIView alloc] init];
    separator2.backgroundColor = ThemeColor;
    self.separator2 = separator2;
    [self.container addSubview:separator2];
    
    UITextField *pwdTextField = [[UITextField alloc] init];
    pwdTextField.delegate = self;
    pwdTextField.font = SubTitleFont;
    pwdTextField.placeholder = @"请输入密码(至少6位)";
//    pwdTextField.tintColor = ThemeColor;
    [pwdTextField setLeftViewWithImage:@"textfield_leftview_password_25x25_"];
    [self.container addSubview:pwdTextField];
    self.passwordTextfield = pwdTextField;
    
    UIView *separator3 = [[UIView alloc] init];
    separator3.backgroundColor = ThemeColor;
    self.separator3 = separator3;
    [self.container addSubview:separator3];
    
    UIButton *registeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registeButton.enabled = NO;
    registeButton.titleLabel.font = TitleFont;
    registeButton.backgroundColor = LightGraySeperatorColor;
    [registeButton setTitle:@"注册" forState:UIControlStateNormal];
    [registeButton setTitleColor:WhiteColor forState:UIControlStateNormal];
    [registeButton addTarget:self action:@selector(registeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.registeButton = registeButton;
    [self.view addSubview:registeButton];
    
}

- (void)masonrySubView {
    
    [self.navView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(ZTTopNaviHeight);
    }];
    
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.navView.bottom);
        make.height.equalTo(kSCREENWIDTH*0.4);
    }];
    
    [self.container makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.imageView.bottom).offset(20*heightRatio);
        make.width.equalTo(kSCREENWIDTH-80);
    }];
    
    [self.telephoneTextfield makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.container);
        make.height.equalTo(35);
    }];
    
    [self.separator1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.container);
        make.top.equalTo(self.telephoneTextfield.bottom).offset(2);
        make.height.equalTo(1);
    }];
    
    
    [self.verificationTextfield makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.container);
        make.top.equalTo(self.separator1.bottom).offset(5);
        make.height.equalTo(35);
    }];
    
    [self.verificationBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.container);
        make.left.equalTo(self.verificationTextfield.right).offset(10);
        make.centerY.equalTo(self.verificationTextfield);
        make.width.equalTo(90);
        make.height.equalTo(30);
    }];
    
    [self.separator2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.container);
        make.top.equalTo(self.verificationTextfield.bottom).offset(2);
        make.height.equalTo(1);
    }];
    
    [self.passwordTextfield makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.container);
        make.top.equalTo(self.separator2.bottom).offset(5);
        make.height.equalTo(35);
    }];
    
    [self.separator3 makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.container);
        make.top.equalTo(self.passwordTextfield.bottom).offset(2);
        make.height.equalTo(1);
        make.bottom.equalTo(self.container.bottom).offset(-5);
    }];
    
    [self.registeButton makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.container.bottom).offset(40);
        make.width.equalTo(kSCREENWIDTH/2);
        make.height.equalTo(40);
    }];
    
}


#pragma mark navviewDelegate  ------

- (void)navView:(UIView *)navView didSelectedLeftItem:(UIButton *)leftItem {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


/** 完全退出控制器*/
- (void)dismissCompletely {
    
    UIViewController *rootVC = self.presentingViewController;
    while (rootVC.presentingViewController) {
        rootVC = rootVC.presentingViewController;
    }
    [rootVC dismissViewControllerAnimated:YES completion:nil];
}

/** 配置输入框的相关属性*/
- (void)configTextfield {
    
    //手机号的限制条件
    [self.telephoneTextfield setLeftViewWithImage:@"textfield_leftview_telephone_25x25_"];
    self.textFilterAccount = [[ZTTextFilter alloc] init];
    [self.textFilterAccount SetFilter:self.telephoneTextfield
                             delegate:self
                               maxLen:11
                             allowNum:YES
                              allowCH:NO
                          allowLetter:NO
                          allowLETTER:NO
                          allowSymbol:NO
                          allowOthers:nil];
    //密码的限制条件
    [self.passwordTextfield setLeftViewWithImage:@"textfield_leftview_password_25x25_"];
    self.textFilterPassword = [[ZTTextFilter alloc] init];
    [self.textFilterPassword SetFilter:self.passwordTextfield
                              delegate:self
                                maxLen:30
                              allowNum:YES
                               allowCH:NO
                           allowLetter:YES
                           allowLETTER:YES
                           allowSymbol:YES
                           allowOthers:nil];
    //验证码的限制条件
    [self.verificationTextfield setLeftViewWithImage:@"textfield_leftview_verification_25x25_"];
    self.textFilterVerification = [[ZTTextFilter alloc] init];
    [self.textFilterVerification SetFilter:self.verificationTextfield
                                  delegate:self
                                    maxLen:6
                                  allowNum:YES
                                   allowCH:NO
                               allowLetter:NO
                               allowLETTER:NO
                               allowSymbol:NO
                               allowOthers:nil];
    
    //输入框添加监听事件，监听输入长度，使注册按钮可点击
    [self.telephoneTextfield addTarget:self action:@selector(observeLengthForTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextfield addTarget:self action:@selector(observeLengthForTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.verificationTextfield addTarget:self action:@selector(observeLengthForTextField:) forControlEvents:UIControlEventEditingChanged];
    
}

/** 限制手机号和验证码长度*/
- (void)observeLengthForTextField:(UITextField *)textField {
    
    //输入框都满足条件，则注册按钮可点击
    self.registeButton.enabled = [self validToRegiste];
    self.registeButton.backgroundColor = [self validToRegiste] ? ThemeColor : LightGraySeperatorColor;
}

/** 检查手机号密码验证码的长度*/
- (BOOL)validToRegiste {
    if(self.telephoneTextfield.text.length == 11 && self.passwordTextfield.text.length >= 6 && self.verificationTextfield.text.length == 6){
        return YES;
    }else {
        return NO;
    }
}


#pragma mark -- inner Methods 自定义方法  -------------------------------

/** 获取验证码*/
- (void)getVerificattion:(ZTCountDownButton *)sender {
    
    BOOL isValidMobileNumber = [NSString isValidMobileNumber:self.telephoneTextfield.text];
    if (isValidMobileNumber) {
        [sender countDownFromTime:60 unitTitle:@"s后可重发" completion:^(ZTCountDownButton *countDownButton) {
            
        }];
        //发送请求，获取验证码
        assert(@"发送请求获取验证码");
//        [ZTLoginManager getRegisterVerificationByMobile:self.telephoneTextfield.text];
        
    }else{
        [MBProgressHUD showErrorMessage:@"手机号格式不正确"];
    }
    
}

/** 查看用户协议*/
- (void)userProtocol:(UIButton *)sender {
    
}

/** 注册按钮事件*/
- (void)registeButtonClick:(UIButton *)sender {

    //发送手机号 验证码 密码等给后台  注册用户  同时密码加密
    
    [ZTUserManager registeAccount:self.telephoneTextfield.text verification:self.verificationTextfield.text password:self.passwordTextfield.text response:^(BOOL success) {
       
        if (success) {
            [SAMKeychain setPassword:self.passwordTextfield.text forService:KEYCHAIN_SERVICE_LOGIN account:self.telephoneTextfield.text];
            [kUserDefaults setValue:self.telephoneTextfield.text forKey:KEYCHAIN_LASTLOGINACCOUNT];
            [kUserDefaults setBool:YES forKey:LOGINSTATUS];
            [kUserDefaults synchronize];
            [kNotificationCenter postNotificationName:ZTUserInfoDidChangedNotification object:nil userInfo:@{LASTLOGINSTATUS:@NO}];
            
//注册成功，返回到顶层，如果没有返回个人信息，那就调登录接口
            UIViewController *vc = self;
            while (vc.presentingViewController) {
                vc = vc.presentingViewController;
            }
            [vc dismissViewControllerAnimated:YES completion:nil];

        }else {
            ZTLog(@"注册失败");
        }
    }];
    
//    [ZTLoginManager registeAccount:self.telephoneTextfield.text verification:self.verificationTextfield.text password:self.passwordTextfield.text response:^(BOOL success) {
//
//        if (success) {
//            [SAMKeychain setPassword:self.passwordTextfield.text forService:KEYCHAIN_SERVICE_LOGIN account:self.telephoneTextfield.text];
//            //注册成功，返回主界面，更新个人信息，刷新主界面等操作
//            [kUserDefaults setBool:YES forKey:LOGINSTATUS];
//            [kUserDefaults synchronize];
//            [kNotificationCenter postNotificationName:ZTUserInfoDidChangedNotification object:nil userInfo:@{LASTLOGINSTATUS:@"0"}];
//            //注册成功，返回到顶层，如果没有返回个人信息，那就调登录接口
//            UIViewController *vc = self;
//            while (vc.presentingViewController) {
//                vc = vc.presentingViewController;
//            }
//            [vc dismissViewControllerAnimated:YES completion:nil];
//
//        }else{
//            //注册失败
//            ZTLog(@"注册失败");
//        }
//    }];
    
}

@end
