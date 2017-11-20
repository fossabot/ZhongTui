//
//  ArticleViewController.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/3.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ArticleViewController.h"
#import "ArticleCell.h"
#import "ArticleCellModel.h"
#import "ArticleDetailViewController.h"
#import <MJExtension.h>
#import "AdvertisementController.h"

@interface ArticleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *recommendDataSource;


@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择文章";
    [self configSubView];
    [self.tableView reloadData];
}


- (void)configSubView {
    
    [self.view addSubview:self.tableView];
    
    self.dataSource = [ArticleCellModel mj_objectArrayWithFilename:@"article.plist"];
    self.recommendDataSource = [ArticleCellModel mj_objectArrayWithFilename:@"article.plist"];
    
}



#pragma mark tableview 代理方法  ---------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return [self sectionHeader:@"广告主推荐文章"];
    }
    return [self sectionHeader:@"系统推荐文章"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ArticleCellModel *model = self.dataSource[indexPath.row];
    ArticleDetailViewController *detail = [[ArticleDetailViewController alloc] init];
    detail.url = model.url;
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark tableview 数据源方法  ---------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:ArticleCellId];
    ArticleCellModel *model;
    
    if (indexPath.section == 0) {
        model = self.dataSource[indexPath.row];
    }else {
        model = self.recommendDataSource[indexPath.row];
    }
    
    cell.leftImageView.image = imageNamed(model.image);
    cell.title.text = model.title;
    cell.ratingView.currentScore = 9.5f;
    cell.tagLabel.text = @"瘦身";
    cell.usedTimes.text = model.usedTimes;
    return cell;
    
}


- (UIView *)sectionHeader:(NSString *)str {
    
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 300, 40)];
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(10, 12, 2, 15)];
    redView.backgroundColor = [UIColor redColor];
    [container addSubview:redView];
    
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, 150, 15)];
    tip.textColor = SubTitleColor;
    tip.font = SubTitleFont;
    tip.text = str;
    [container addSubview:tip];
    
    return container;
    
}


#pragma mark  懒加载方法区域   -------------------------------------------

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NSMutableArray *)recommendDataSource {
    
    if (!_recommendDataSource) {
        _recommendDataSource = [NSMutableArray array];
    }
    return _recommendDataSource;
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        [_tableView registerClass:[ArticleCell class] forCellReuseIdentifier:ArticleCellId];
        
    }
    return _tableView;
}








@end
