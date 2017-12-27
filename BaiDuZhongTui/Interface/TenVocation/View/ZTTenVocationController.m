//
//  ZTTenVocationController.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/26.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTTenVocationController.h"
#import "ZTTableView.h"
#import "ZTTenVocationViewModel.h"
#import "MainAdCell.h"
#import <MJRefresh/MJRefresh.h>

@interface ZTTenVocationController ()

/** viewModel*/
@property (nonatomic, strong) ZTTenVocationViewModel *viewModel;

/** tableView*/
@property (nonatomic, strong) ZTTableView *tableView;


@end

@implementation ZTTenVocationController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)loadNewData {
    
    [self.viewModel fetchNewDataCompletion:^(BOOL success) {
        
    }];
}

- (void)loadMoreData {
    
}

#pragma mark -- lazyMethods 懒加载区域  --------------------------

- (ZTTenVocationViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[ZTTenVocationViewModel alloc] init];
    }
    return _viewModel;
}

- (ZTTableView *)tableView{
    if (!_tableView) {
        _tableView = [[ZTTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self.viewModel;
        _tableView.dataSource = self.viewModel;
        [_tableView registerClass:[MainAdCell class] forCellReuseIdentifier:adCellId];
        
        ZTWeakSelf
        _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
           
            ZTStrongSelf
            [strongSelf loadNewData];
        }];
        
        _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
            
            ZTStrongSelf
            [strongSelf loadMoreData];
        }];
        
        FOREmptyAssistantConfiger *config = [[FOREmptyAssistantConfiger alloc] init];
        config.emptyImage = imageNamed(@"");
        config.emptyTitle = @"网络出错，暂无数据";
        config.emptyTitleColor = UnenableTitleColor;
        config.emptyTitleFont = SubTitleFont;
        config.emptyBtnClickBlock = ^{
            
            [weakSelf loadNewData];
        };
        config.emptyViewDidAppear = ^{
          
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        };
        [_tableView emptyViewConfiger:config];
    
        
    }
    return _tableView;
}
@end
