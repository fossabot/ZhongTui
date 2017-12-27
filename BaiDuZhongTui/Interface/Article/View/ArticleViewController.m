//
//  ArticleViewController.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/3.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ArticleViewController.h"
#import "ZTTableView.h"
#import "ArticleCell.h"
#import "ArticleCellModel.h"

#import "ZTArticleViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import "AdvertisementController.h"
#import "ArticleDetailViewController.h"


@interface ArticleViewController ()

@property (nonatomic, strong) ZTTableView *tableView;

@property (nonatomic, strong) ZTArticleViewModel *viewModel;


@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubView];
    [self.tableView reloadData];
}


- (void)configSubView {
    
    self.navigationItem.title = @"选择文章";
    [self.view addSubview:self.tableView];
    
//    self.dataSource = [ArticleCellModel mj_objectArrayWithFilename:@"article.plist"];
//    self.recommendDataSource = [ArticleCellModel mj_objectArrayWithFilename:@"article.plist"];
    
}

- (void)loadNewData {
    
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
    
    ZTWeakSelf
    [self.viewModel fetchNewDataCompletion:^(BOOL success) {
        
        if (success) {
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)loadMoreData {
    
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    
    ZTWeakSelf
    [self.viewModel fetchMoreDataCompletion:^(BOOL success, BOOL noMoreData) {
        
        if (success) {
            if (noMoreData) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [weakSelf.tableView reloadData];
            }
        }
    }];
}





#pragma mark  懒加载方法区域   -------------------------------------------

- (ZTArticleViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[ZTArticleViewModel alloc] init];
        _viewModel.adid = self.adid;
        ZTWeakSelf
        _viewModel.cellSelectBlock = ^(id data, NSIndexPath *indexPath) {

            ArticleDetailViewController *detail = [[ArticleDetailViewController alloc] init];
            detail.url = data;
            [weakSelf.navigationController pushViewController:detail animated:YES];
        };
    }
    return _viewModel;
}

- (ZTTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[ZTTableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self.viewModel;
        _tableView.dataSource = self.viewModel;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        [_tableView registerClass:[ArticleCell class] forCellReuseIdentifier:ArticleCellId];
        
        ZTWeakSelf
        _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            
            ZTStrongSelf
            [strongSelf loadNewData];
        }];
        
        _tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        
            ZTLog(@"暂无加载更多");
//            ZTStrongSelf
//            [strongSelf loadMoreData];
        }];
    }
    return _tableView;
}








@end
