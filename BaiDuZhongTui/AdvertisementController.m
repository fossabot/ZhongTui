//
//  AdvertisementController.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "AdvertisementController.h"
#import "MainAdCell.h"
#import "ArticleViewController.h"
#import "AdModel.h"
#import <MJExtension.h>

@interface AdvertisementController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation AdvertisementController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择广告";
    [self configSubView];
    [self loadData];
    
}

- (void)configSubView {
 
    [self.view addSubview:self.tableView];
}

- (void)loadData {
    
    self.dataSource = [AdModel mj_objectArrayWithFilename:@"ad.plist"];
    [self.tableView reloadData];
}

#pragma mark tableview 代理方法  ---------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ArticleViewController *article = [[ArticleViewController alloc] init];
    [self.navigationController pushViewController:article animated:YES];
}


#pragma mark tableview 数据源方法  ---------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainAdCell *cell = [tableView dequeueReusableCellWithIdentifier:adCellId];
    AdModel *model = self.dataSource[indexPath.row];
    cell.adImage.image = imageNamed(model.image);
    cell.adTag.text = model.source;
    cell.shareMoney.text = model.share;
    cell.clickMoney.text = model.clicks;
    
    return cell;

    
}



#pragma mark  懒加载方法区域   -------------------------------------------

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainAdCell class]) bundle:nil] forCellReuseIdentifier:adCellId];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}


@end
