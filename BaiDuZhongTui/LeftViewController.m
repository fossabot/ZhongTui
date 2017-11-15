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
#import "YYEdgeLabel.h"
#import "MineWalletController.h"

#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+MMDrawerController.h"


@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UIView *header;

@property (nonatomic, strong) UIImageView *avatar;

@property (nonatomic, strong) UILabel *nickName;

@property (nonatomic, strong) YYEdgeLabel *level;

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

- (void)createSubView {
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.header;
    [self.header addSubview:self.avatar];
    [self.header addSubview:self.nickName];
    [self.header addSubview:self.level];
    [self.header addSubview:self.speedTip];
    [self.view addSubview:self.adImageView];
    [self.adImageView addSubview:self.adTipImage];
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 84, 0));
    }];
    
//    [self.header makeConstraints:^(MASConstraintMaker *make) {
//    
//        make.height.equalTo(300);
//        make.width.equalTo(self.tableView);
//    }];
    
//    [self.avatar makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.left.top.equalTo(20);
//        make.width.equalTo(60);
//        make.height.equalTo(60);
//    }];
//    
//    [self.nickName makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.top.equalTo(self.avatar);
//        make.left.equalTo(self.avatar.right).offset(20);
//    }];
//    
//    [self.level makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.left.equalTo(self.nickName);
//        make.top.equalTo(self.nickName.bottom).offset(10);
//        make.height.equalTo(20);
//        make.width.equalTo(40);
//    }];
//    
//    [self.speedTip makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.level.right).offset(10);
//        make.centerY.equalTo(self.level);
//        make.height.equalTo(20);
//    }];
    
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
    return 5;
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
        model5.leftImage = @"setting_33x33";
        model5.title = @"我的设置";
        model5.destinationVc = @"setting_33x33";
        [_dataSource addObject:model5];
        
    }
    return _dataSource;
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT-84) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.scrollEnabled = NO;
        _tableView.contentInset = UIEdgeInsetsMake(-20, 0, 30, 0);
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[LeftAchievementCell class] forCellReuseIdentifier:LeftAchievementCellId];
        [_tableView registerClass:[LeftCommonCell class] forCellReuseIdentifier:LeftCommonCellId];
    }
    return _tableView;
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

- (YYEdgeLabel *)level {
    
    if (!_level) {
        _level = [[YYEdgeLabel alloc] initWithFrame:CGRectMake(90, 70, 40, 14)];
        _level.backgroundColor = YYRGB(255, 66, 45);
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
        _speedTip.textColor = YYRGB(253, 122, 4);;
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
