//
//  ZTLogInController.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/12.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTLogInController.h"
#import "ZTSignUpController.h"
#import "ZTForgetPwdController.h"

#import "ZTNavView.h"
#import "ZTTextFilter.h"
#import "UITextField+LeftView.h"
#import "ZTUserManager.h"
#import "SAMKeychain.h"
#import "ZTCountDownButton.h"


@interface ZTLogInController ()<NavViewDelegate,ZTTextFilterDelegate,UITextFieldDelegate>


@property (nonatomic, strong) ZTNavView *navView;
@property (nonatomic, strong) UIImageView *imageView;

/** container*/
@property (nonatomic, strong) UIView *container;

/** teleTextField*/
@property (nonatomic, strong) UITextField *teleTextField;

/** separator1*/
@property (nonatomic, strong) UIView *separator1;

/** pwdTextField*/
@property (nonatomic, strong) UITextField *pwdTextField;

/** separator1*/
@property (nonatomic, strong) UIView *separator2;

/** regist*/
@property (nonatomic, strong) UIButton *regist;

/** forgot*/
@property (nonatomic, strong) UIButton *forgot;

/** logIn*/
@property (nonatomic, strong) UIButton *logIn;


/** textField filter*/
@property (nonatomic,strong) ZTTextFilter *textFilterAccount;
@property (nonatomic,strong) ZTTextFilter *textFilterPassword;


@end

@implementation ZTLogInController
{
    UIStatusBarStyle _statusBarStyle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubViews];
    [self masonrySubViews];
    [self configTextfield];
    kApplication.statusBarStyle = UIStatusBarStyleDefault;
//    _statusBarStyle = kApplication.statusBarStyle;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
//    kApplication.statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [kApplication setStatusBarStyle:_statusBarStyle animated:YES];
}

/**
 创建子控件
 */
- (void)createSubViews {
    
    ZTNavView *navView = [[ZTNavView alloc] init];
    navView.title = @"登录";
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
    
    UITextField *teleTextField = [[UITextField alloc] init];
    teleTextField.delegate = self;
    teleTextField.font = SubTitleFont;
    teleTextField.placeholder = @"请输入手机号";
//    teleTextField.tintColor = ThemeColor;
    [teleTextField setLeftViewWithImage:@"textfield_leftview_telephone_25x25_"];
    [self.container addSubview:teleTextField];
    self.teleTextField = teleTextField;
    
    UIView *separator1 = [[UIView alloc] init];
    separator1.backgroundColor = ThemeColor;
    self.separator1 = separator1;
    [self.container addSubview:separator1];
    
    UITextField *pwdTextField = [[UITextField alloc] init];
    pwdTextField.delegate = self;
    pwdTextField.secureTextEntry = YES;
    pwdTextField.font = SubTitleFont;
    pwdTextField.placeholder = @"请输入密码(至少6位)";
//    pwdTextField.tintColor = ThemeColor;
    [pwdTextField setLeftViewWithImage:@"textfield_leftview_password_25x25_"];
    [self.container addSubview:pwdTextField];
    self.pwdTextField = pwdTextField;
    
    UIView *separator2 = [[UIView alloc] init];
    separator2.backgroundColor = ThemeColor;
    self.separator2 = separator2;
    [self.container addSubview:separator2];
    
    UIButton *regist = [UIButton buttonWithType:UIButtonTypeCustom];
    regist.titleLabel.font = SubTitleFont;
    [regist setTitle:@"注册众推" forState:UIControlStateNormal];
    [regist setTitleColor:ThemeColor forState:UIControlStateNormal];
    [regist addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.regist = regist;
    [self.view addSubview:regist];
    
    UIButton *forgot = [UIButton buttonWithType:UIButtonTypeCustom];
    forgot.titleLabel.font = SubTitleFont;
    [forgot setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgot setTitleColor:ThemeColor forState:UIControlStateNormal];
    [forgot addTarget:self action:@selector(forgotPasswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.forgot = forgot;
    [self.view addSubview:forgot];
    
    UIButton *logIn = [UIButton buttonWithType:UIButtonTypeCustom];
    logIn.enabled = NO;
    logIn.titleLabel.font = TitleFont;
    [logIn setBackgroundColor:LightGraySeperatorColor];
    [logIn setTitle:@"登录" forState:UIControlStateNormal];
    [logIn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [logIn addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.logIn = logIn;
    [self.view addSubview:logIn];
    
}


/**
 布局子控件
 */
- (void)masonrySubViews {
    
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
    
    [self.teleTextField makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self.container);
        make.height.equalTo(35);
    }];
    
    [self.separator1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.teleTextField);
        make.top.equalTo(self.teleTextField.bottom).offset(2);
        make.height.equalTo(1);
    }];
    
    [self.pwdTextField makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.container);
        make.top.equalTo(self.separator1.bottom).offset(5);
        make.height.equalTo(35);
    }];
    
    [self.separator2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.pwdTextField);
        make.top.equalTo(self.pwdTextField.bottom).offset(2);
        make.height.equalTo(1);
        make.bottom.equalTo(self.container.bottom).offset(-5);
    }];
    
    [self.regist makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.container);
        make.top.equalTo(self.container.bottom).offset(10);
        make.width.equalTo(60);
        make.height.equalTo(20);
    }];
    
    [self.forgot makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.container);
        make.top.equalTo(self.container.bottom).offset(10);
        make.width.equalTo(60);
        make.height.equalTo(20);
    }];
    
    [self.logIn makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.container.bottom).offset(60);
        make.width.equalTo(kSCREENWIDTH/2);
        make.height.equalTo(40);
    }];
    
}

#pragma mark -- inner Methods 自定义方法  -------------------------------

/** 登录按钮点击事件*/
- (void)loginButtonClick:(UIButton *)sender {
    
    [ZTUserManager loginSucceedWithAccount:self.teleTextField.text password:self.pwdTextField.text responseMsg:^(BOOL success) {
        
        //loginmanager 内部已经处理好了所有用户体验的东西,包括，这里拿到登录状态跳转页面
        if (success) {
            [self dismissViewControllerAnimated:YES completion:nil];
            //这时候登录成功了，可以全局通知，我登录成功了，该刷新的刷新去吧
            
            [kUserDefaults setBool:YES forKey:LOGINSTATUS];
            [kUserDefaults synchronize];
            [kNotificationCenter postNotificationName:ZTUserInfoDidChangedNotification object:nil userInfo:@{LASTLOGINSTATUS:@NO}];
            [kNotificationCenter postNotificationName:ZTLoginStatusDidChangedNotification object:nil];
            
            [self exit];
        }
        
    }];
    
}


/** 注册账号按钮点击事件*/
- (void)registerButtonClick:(UIButton *)sender {
    
    ZTSignUpController *regist = [[ZTSignUpController alloc] init];
    [self presentViewController:regist animated:YES completion:nil];
    
}

/** 忘记密码按钮点击事件*/
- (void)forgotPasswordButtonClick:(UIButton *)sender {
    
    ZTForgetPwdController *forget = [[ZTForgetPwdController alloc] init];
    [self presentViewController:forget animated:YES completion:nil];
    
}

/** 退出登录*/
- (void)exit {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark navViewDelegate

- (void)navView:(UIView *)navView didSelectedLeftItem:(UIButton *)leftItem {
    
    [self exit];
}

#pragma mark -- uitextfieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //这里不用验证手机及密码输入框的正确性，只需改变第一响应者，loginmethod里判断
    if (textField == self.teleTextField) {
        
        [self.teleTextField resignFirstResponder];
        [self.pwdTextField becomeFirstResponder];
    }
    if (textField == self.pwdTextField) {
        [self.view endEditing:YES];
        [self loginButtonClick:self.logIn];
    }
    return YES;
}



/** 配置输入框的相关属性*/
- (void)configTextfield{
    
    [self.teleTextField setLeftViewWithImage:@"textfield_leftview_telephone_25x25_"];
    self.textFilterAccount = [[ZTTextFilter alloc] init];
    [self.textFilterAccount SetFilter:self.teleTextField
                             delegate:self
                               maxLen:11
                             allowNum:YES
                              allowCH:NO
                          allowLetter:NO
                          allowLETTER:NO
                          allowSymbol:NO
                          allowOthers:nil];
    
    [self.pwdTextField setLeftViewWithImage:@"textfield_leftview_password_25x25_"];
    self.textFilterPassword = [[ZTTextFilter alloc] init];
    [self.textFilterPassword SetFilter:self.pwdTextField
                              delegate:self
                                maxLen:30
                              allowNum:YES
                               allowCH:NO
                           allowLetter:YES
                           allowLETTER:YES
                           allowSymbol:YES
                           allowOthers:nil];
    
    //输入框添加监听事件，监听输入长度，使重置密码按钮可点击
    [self.teleTextField addTarget:self action:@selector(observeLengthForTextField:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdTextField addTarget:self action:@selector(observeLengthForTextField:) forControlEvents:UIControlEventEditingChanged];
}

/** 监听手机号和密码的输入长度*/
- (void)observeLengthForTextField:(UITextField *)textField {
    if (textField == self.teleTextField) {
        self.pwdTextField.text = [SAMKeychain passwordForService:KEYCHAIN_SERVICE_LOGIN account:self.teleTextField.text];
    }
    //输入框都满足条件，则注册按钮可点击
    self.logIn.enabled = [self validToLogin];
    self.logIn.backgroundColor = [self validToLogin] ? ThemeColor : LightGraySeperatorColor;
}

- (BOOL)validToLogin {
    if(self.teleTextField.text.length == 11 && self.pwdTextField.text.length >= 6){
        return YES;
    }else {
        return NO;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}


@end
