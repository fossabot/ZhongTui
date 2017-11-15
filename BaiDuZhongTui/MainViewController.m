//
//  MainViewController.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "MainViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+MMDrawerController.h"

#import "LeftViewController.h"

#import "PlaceHolderView.h"
#import "AdvertisementController.h"
#import "ArticleViewController.h"
//#import "MainTableViewCell.h"
#import "MainButtonCell.h"
#import "MainSearchCell.h"
#import "MainScrollCell.h"
#import "MainAdCell.h"
#import "AdModel.h"
#import <MJExtension.h>


@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;



@end

@implementation MainViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self setRestorationIdentifier:MainViewControllerIdetifier];
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configSubView];
    [self loadData];
    [self.tableView reloadData];
   
}

- (void)loadData {
    
    self.dataSource = [AdModel mj_objectArrayWithFilename:@"ad.plist"];
}

- (void)configSubView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:imageNamed(@"personal_20x20") style:UIBarButtonItemStyleDone target:self action:@selector(showLeft)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:imageNamed(@"message_20x20") style:UIBarButtonItemStyleDone target:self action:@selector(showLeft)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:imageNamed(@"titleViewImage")];
    [self.view addSubview:self.tableView];
    
    [self showPlaceHolder];
}


- (void)showPlaceHolder {
    
    YYWeakSelf
    [PlaceHolderView show:^{
       
        AdvertisementController *ad = [[AdvertisementController alloc] init];
        [weakSelf.navigationController pushViewController:ad animated:YES];
    }];
}


- (void)showLeft {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


- (void)showMessage {
    
    //暂未开通
}

#pragma mark tableview 代理方法  ---------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 3) {
        return self.dataSource.count;
    }
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        return 50;
    }else if (indexPath.section == 1) {
        
        return 60;
    }else if (indexPath.section == 2) {
        
        return 150;
    }else {
        
        return 170;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 3) {
        
        ArticleViewController *article = [[ArticleViewController alloc] init];
        [self.navigationController pushViewController:article animated:YES];
    }
}


#pragma mark tableview 数据源方法  ---------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        MainSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:searchCellId];
        
        return cell;
    }else if (indexPath.section == 1) {
        
        MainScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:scrollCellId];

        return cell;
    }else if (indexPath.section == 2) {
        
        MainButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:buttonCellId];
        
        return cell;
    }else {
        
        MainAdCell *cell = [tableView dequeueReusableCellWithIdentifier:adCellId];
        AdModel *model = self.dataSource[indexPath.row];
        cell.adImage.image = imageNamed(model.image);
        cell.adTag.text = model.source;
        cell.shareMoney.text = model.share;
        cell.clickMoney.text = model.clicks;
        
        return cell;
    }
    

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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainSearchCell class]) bundle:nil] forCellReuseIdentifier:searchCellId];
        [_tableView registerClass:[MainScrollCell class] forCellReuseIdentifier:scrollCellId];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainAdCell class]) bundle:nil] forCellReuseIdentifier:adCellId];
        
        [_tableView registerClass:[MainButtonCell class] forCellReuseIdentifier:buttonCellId];
        
    }
    return _tableView;
}


@end
