//
//  MineCardsController.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/17.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "MineCardsController.h"
#import "ZTTableView.h"
#import "ZTMineCardCell.h"

@interface MineCardsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZTTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation MineCardsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.navigationItem.title = @"我的卡券";
    [self createSubView];
}

- (void)createSubView {
    
    
    [self.view addSubview:self.tableView];
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).offset(UIEdgeInsetsZero);
    }];

}


#pragma mark tableview 代理方法  ---------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kSCREENWIDTH*0.75;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark tableview 数据源方法  ---------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *imageName = self.dataSource[indexPath.row];
    ZTMineCardCell *cell = [tableView dequeueReusableCellWithIdentifier:ZTMineCardCellId];
    cell.cardImage.image = imageNamed(imageName);
    return cell;
}



#pragma mark  懒加载方法区域   -------------------------------------------

- (ZTTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[ZTTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tintColor = [UIColor redColor];
        [_tableView registerClass:[ZTMineCardCell class] forCellReuseIdentifier:ZTMineCardCellId];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@"upper1-1_active",@"upper1-2_unactive",@"upper1-5_unactive",@"upper2-0_unactive", nil];
    }
    return _dataSource;
}



@end
