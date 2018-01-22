//
//  ZTUserViewController.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/29.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTUserViewController.h"
#import "ZTTableView.h"
#import "ZTUserTableViewCell.h"
#import "ZTUserNameTableViewCell.h"

#import "ZTUser.h"
#import "ZTUserManager.h"
#import "NSString+Predicate.h"
#import "ZTPicker.h"

@interface ZTUserViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ZTPickerDelegate>

/** */
@property (nonatomic, strong) ZTTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

/** header*/
@property (nonatomic, strong) UIView *header;

@end

@implementation ZTUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



#pragma mark -- lazyMethods 懒加载区域  --------------------------

- (UIView *)header{
    if (!_header) {
        _header = [[UIView alloc] init];
    }
    return _header;
}


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (ZTTableView *)tableView{
    if (!_tableView) {
        _tableView = [[ZTTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
