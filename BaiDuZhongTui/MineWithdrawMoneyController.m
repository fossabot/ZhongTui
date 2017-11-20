//
//  MineWithdrawMoneyController.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/16.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "MineWithdrawMoneyController.h"
#import "ZTWithdrawMoneyCell.h"


@interface MineWithdrawMoneyController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *money;

@property (nonatomic, strong) UILabel *tip;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *withdrawMoneyButton;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MineWithdrawMoneyController
{
    NSIndexPath *_lastIndexPath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.navigationItem.title = @"提现";
    _lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self createSubView];
}

- (void)createSubView {
    
    UILabel *money = [[UILabel alloc] init];
    money.font = sysFont(30);
    money.textColor = [UIColor redColor];
    money.text = @"￥1.00";
    self.money = money;
    [self.view addSubview:money];
    
    UILabel *tip = [[UILabel alloc] init];
    tip.font = SubTitleFont;
    tip.textColor = UnenableTitleColor;
    tip.text = @"余额超过10元可提现";
    self.tip = tip;
    [self.view addSubview:tip];
    
    [self.view addSubview:self.tableView];
    
    UIButton *withdrawMoney = [UIButton buttonWithType:UIButtonTypeCustom];
    [withdrawMoney setTitle:@"提现" forState:UIControlStateNormal];
    withdrawMoney.titleLabel.font = NavTitleFont;
    [withdrawMoney setTitleColor:WhiteColor forState:UIControlStateNormal];
    withdrawMoney.backgroundColor = ThemeColor;
    [withdrawMoney addTarget:self action:@selector(withDrawMoneyClick:) forControlEvents:UIControlEventTouchUpInside];
    self.withdrawMoneyButton = withdrawMoney;
    [self.view addSubview:withdrawMoney];
    
    
    [self.money makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(40);
        make.centerX.equalTo(self.view);
    }];
    
    [self.tip makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.money.bottom).offset(10);
        make.centerX.equalTo(self.view);
    }];
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.tip.bottom).offset(40);
        make.left.right.equalTo(self.view);
        make.height.equalTo(180);
    }];

    [self.withdrawMoneyButton makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.tableView.bottom).offset(60);
        make.centerX.equalTo(self.view);
        make.left.equalTo(30);
        make.right.equalTo(-30);
        make.height.equalTo(50);
    }];
}


/* 提现*/
- (void)withDrawMoneyClick:(UIButton *)sender {
    
    if (!_lastIndexPath) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请选择提现方式";
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:1];
        return;
    }
    self.money.text = @"￥0.00";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提现成功" message:@"提现金额会以微信红包的形式发放到用户的微信中，注意查收!\n首次提现，系统奖励您1元，祝您财源滚滚哦！" preferredStyle:UIAlertControllerStyleAlert];
    
    YYWeakSelf
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [kKeyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}




#pragma mark tableview 代理方法  ---------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _lastIndexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (_lastIndexPath) {
//        
//        ZTWithdrawMoneyCell *lastCell = [tableView cellForRowAtIndexPath:_lastIndexPath];
//        lastCell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    
//    ZTWithdrawMoneyCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [tableView reloadData];
}

#pragma mark tableview 数据源方法  ---------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZTWithdrawMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:ZTWithdrawMoneyCellId];
    NSString *image = self.dataSource[indexPath.row][@"image"];
    NSString *title = self.dataSource[indexPath.row][@"title"];
    NSString *subTitle = self.dataSource[indexPath.row][@"subTitle"];
    cell.walletImage.image = imageNamed(image);
    cell.title.text = title;
    cell.subTitle.text = subTitle;
    
    if (_lastIndexPath == indexPath) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}


#pragma mark  懒加载方法区域   -------------------------------------------

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.tintColor = [UIColor redColor];
        [_tableView registerClass:[ZTWithdrawMoneyCell class] forCellReuseIdentifier:ZTWithdrawMoneyCellId];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObject:@{@"image":@"baiduWallet_24x24",@"title":@"百度钱包",@"subTitle":@"随机获得理财加息券"}];
        [_dataSource addObject:@{@"image":@"alipay_24x24",@"title":@"支付宝",@"subTitle":@"推荐支付宝用户使用"}];
        [_dataSource addObject:@{@"image":@"wechat_24x24",@"title":@"微信",@"subTitle":@"推荐微信用户使用"}];
    }
    return _dataSource;
}

@end
