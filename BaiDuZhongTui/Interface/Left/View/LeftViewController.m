//
//  LeftViewController.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftAchievementCell.h"
#import "LeftCommonCellModel.h"
#import "LeftCommonCell.h"
#import "ZTEdgeLabel.h"
#import "MineWalletController.h"
#import "ZTAroundController.h"
#import "MineCardsController.h"
#import "LoginedHeader.h"
#import "UnloginHeader.h"
#import "ZTUserInfoController.h"
#import "ZTLogInController.h"


#import "ZTUser.h"
#import "ZTTableView.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+MMDrawerController.h"

static CGFloat leftViewWidth = 100;

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZTTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIView *header;

@property (nonatomic, strong) LoginedHeader *loginedHeader;

@property (nonatomic, strong) UnloginHeader *unloginHeader;

@property (nonatomic, strong) UIImageView *avatar;

@property (nonatomic, strong) UILabel *nickName;

@property (nonatomic, strong) ZTEdgeLabel *level;

@property (nonatomic, strong) UILabel *speedTip;

@property (nonatomic, strong) UIImageView *adImageView;

@property (nonatomic, strong) UIImageView *adTipImage;

@end

@implementation LeftViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        [self setRestorationIdentifier:LeftViewControllerIdetifier];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    [self addObserver];
    [self createSubView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

}

/** 添加观察者*/
- (void)addObserver {
    
    [kNotificationCenter addObserver:self selector:@selector(refreshHeaderView:) name:ZTUserInfoDidChangedNotification object:nil];
}

/** 根据登录状态刷新左侧视图头部View*/
- (void)refreshHeaderView:(NSNotification *)notice {
    
    ZTUser *user = [ZTUser shareUser];
    
    if (!notice) {
        //没有notice代表是初始化控制器的View，只需直接判断登录状态，直接装载相应的header
        if (user.isLogin) {
            self.tableView.tableHeaderView = self.loginedHeader;
        }else{
            self.tableView.tableHeaderView = self.unloginHeader;
        }
        
    }else {
        //有notice代表是初始化完毕View之后有发生登录退出或者改变个人信息的相应操作了
        BOOL lastLoginStatus = notice.userInfo[LASTLOGINSTATUS];
        if (lastLoginStatus && user.isLogin) {
            //过去是登录，现在还是登录，只是修改个人信息
            [self.loginedHeader setUser:user];
        }else if (!lastLoginStatus && user.isLogin) {
            //过去是退出状态，现在是登录，说明就是登录操作
            self.tableView.tableHeaderView = nil;
            self.tableView.tableHeaderView = self.loginedHeader;
        }else if (lastLoginStatus && !user.isLogin) {
            //过去是登录，现在是退出，说明就是退出操作
            self.tableView.tableHeaderView = nil;
            self.tableView.tableHeaderView = self.unloginHeader;
        }
    }
    
}


- (void)createSubView {
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.header;
    
    [self refreshHeaderView:nil];
//    [self.header addSubview:self.avatar];
//    [self.header addSubview:self.nickName];
//    [self.header addSubview:self.level];
//    [self.header addSubview:self.speedTip];
    [self.view addSubview:self.adImageView];
    [self.adImageView addSubview:self.adTipImage];
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 84, 0));
    }];
    
    [self.adImageView makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(280*0.3);
    }];
    
    [self.adTipImage makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.adImageView.right).offset(-5);
        make.top.equalTo(self.adImageView.top).offset(5);
        make.width.equalTo(23);
        make.height.equalTo(14);
    }];
}



#pragma mark tableview 代理方法  ---------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 150;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        MineWalletController *mineWallet = [[MineWalletController alloc] init];
        mineWallet.jz_wantsNavigationBarVisible = YES;
        mineWallet.jz_navigationBarTintColor = WhiteColor;
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:mineWallet animated:NO];
        
        //拿到我们的LitterLCenterViewController，让它去push
      
        //当我们push成功之后，关闭我们的抽屉
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        MineCardsController *cardController = [[MineCardsController alloc] init];
        cardController.jz_wantsNavigationBarVisible = YES;
        cardController.jz_navigationBarTintColor = WhiteColor;
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:cardController animated:NO];
        
        //拿到我们的LitterLCenterViewController，让它去push
        
        //当我们push成功之后，关闭我们的抽屉
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }
    
    if (indexPath.section == 1 && indexPath.row == 4) {
        
        ZTAroundController *aroundController = [[ZTAroundController alloc] init];
        aroundController.jz_wantsNavigationBarVisible = YES;
        aroundController.jz_navigationBarTintColor = WhiteColor;
        UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
        [nav pushViewController:aroundController animated:NO];
        
        //拿到我们的LitterLCenterViewController，让它去push
        
        //当我们push成功之后，关闭我们的抽屉
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
            [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        }];
    }
}

#pragma mark tableview 数据源方法  ---------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        LeftAchievementCell *cell = [tableView dequeueReusableCellWithIdentifier:LeftAchievementCellId];
        
        return cell;
    }else {
        
        LeftCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:LeftCommonCellId];
        LeftCommonCellModel *model = self.dataSource[indexPath.row];
        cell.leftImageView.image = imageNamed(model.leftImage);
        cell.title.text = model.title;
        
        return cell;
    }
}
 



#pragma mark  懒加载方法区域   -------------------------------------------

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
        LeftCommonCellModel *model1 = [[LeftCommonCellModel alloc] init];
        model1.leftImage = @"wallet_33x33";
        model1.title = @"我的钱包";
        model1.destinationVc = @"wallet_33x33";
        [_dataSource addObject:model1];
        
        LeftCommonCellModel *model2 = [[LeftCommonCellModel alloc] init];
        model2.leftImage = @"leftCard_33x33";
        model2.title = @"我的卡券";
        model2.destinationVc = @"leftCard_33x33";
        [_dataSource addObject:model2];
        
        LeftCommonCellModel *model3 = [[LeftCommonCellModel alloc] init];
        model3.leftImage = @"leftTask_33x33";
        model3.title = @"我的任务";
        model3.destinationVc = @"leftTask_33x33";
        [_dataSource addObject:model3];

        LeftCommonCellModel *model4 = [[LeftCommonCellModel alloc] init];
        model4.leftImage = @"leftInvition_33x33";
        model4.title = @"邀请好友";
        model4.destinationVc = @"leftInvition_33x33";
        [_dataSource addObject:model4];

        LeftCommonCellModel *model5 = [[LeftCommonCellModel alloc] init];
        model5.leftImage = @"leftAround_33x33";
        model5.title = @"我的周边";
        model5.destinationVc = @"leftAround_33x33";
        [_dataSource addObject:model5];
        
        LeftCommonCellModel *model6 = [[LeftCommonCellModel alloc] init];
        model6.leftImage = @"setting_33x33";
        model6.title = @"我的设置";
        model6.destinationVc = @"setting_33x33";
        [_dataSource addObject:model6];
        
    }
    return _dataSource;
}


- (ZTTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[ZTTableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT-ZTTopNaviHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(-ZTStatusBarH, 0, 30, 0);
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[LeftAchievementCell class] forCellReuseIdentifier:LeftAchievementCellId];
        [_tableView registerClass:[LeftCommonCell class] forCellReuseIdentifier:LeftCommonCellId];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (LoginedHeader *)loginedHeader {
    if (!_loginedHeader) {
        _loginedHeader = [LoginedHeader headerView];
        _loginedHeader.frame = CGRectMake(0, 0, leftViewWidth, ZTStatusBarH+140);
        ZTWeakSelf
        
        _loginedHeader.changeUserInfoBlock = ^{
            
            ZTUserInfoController *userInfo = [[ZTUserInfoController alloc] init];
            [weakSelf presentViewController:userInfo animated:YES completion:nil];
        };
    }
    return _loginedHeader;
}

- (UnloginHeader *)unloginHeader {
    if (!_unloginHeader) {
        _unloginHeader = [UnloginHeader headerView];
        _unloginHeader.frame = CGRectMake(0, 0, leftViewWidth, ZTStatusBarH+120);
        ZTWeakSelf
        _unloginHeader.loginBlock = ^{
          
            ZTLogInController *login = [[ZTLogInController alloc] init];
            [weakSelf presentViewController:login animated:YES completion:nil];
        };
    }
    return _unloginHeader;
}

- (UIView *)header {
    
    if (!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 100)];
        _header.backgroundColor = [WhiteColor colorWithAlphaComponent:0.8];
        _header.userInteractionEnabled = YES;
        
    }
    return _header;
}

- (UIImageView *)avatar {
    
    if (!_avatar) {
        _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 60, 60)];
        _avatar.userInteractionEnabled = YES;
        _avatar.image = imageNamed(@"avatar");
    }
    return _avatar;
}

- (UILabel *)nickName {
    
    if (!_nickName) {
        _nickName = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 150, 20)];
        _nickName.textColor = TitleColor;
        _nickName.font = NavTitleFont;
        _nickName.text = @"188****0767";
    }
    return _nickName;
}

- (ZTEdgeLabel *)level {
    
    if (!_level) {
        _level = [[ZTEdgeLabel alloc] initWithFrame:CGRectMake(90, 70, 40, 14)];
        _level.backgroundColor = ZTRGB(255, 66, 45);
        _level.textAlignment = NSTextAlignmentCenter;
        _level.textColor = WhiteColor;
        _level.font = SubTitleFont;;
        _level.text = @"LV.1";
        _level.layer.masksToBounds = YES;
        _level.layer.cornerRadius = 8;
    }
    return _level;
}

- (UILabel *)speedTip {
    
    if (!_speedTip) {
        _speedTip = [[UILabel alloc] initWithFrame:CGRectMake(140, 70, 100, 14)];
        _speedTip.text = @"1.0倍加速中";
        _speedTip.textColor = ZTRGB(253, 122, 4);;
        _speedTip.font = SubTitleFont;
    }
    return _speedTip;
}

- (UIImageView *)adImageView {
    
    if (!_adImageView) {
        _adImageView = [[UIImageView alloc] init];
        _adImageView.image = imageNamed(@"ad");
    }
    return _adImageView;
}

- (UIImageView *)adTipImage {
    
    if (!_adTipImage) {
        _adTipImage = [[UIImageView alloc] initWithImage:imageNamed(@"adTipImage")];
    }
    return _adTipImage;
}


@end
