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
#import "ZTLogInController.h"

#import "ZTTableView.h"
#import "PlaceHolderView.h"
#import "AdvertisementController.h"
#import "ArticleViewController.h"
//#import "MainTableViewCell.h"
#import "MainButtonCell.h"
#import "MainSearchCell.h"
#import "MainScrollCell.h"
#import "MainAdCell.h"
#import "AdModel.h"
#import "ZTMainViewModel.h"

#import <MJRefresh/MJRefresh.h>
#import "ZTTestViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) ZTTableView *tableView;
/** viewModel*/
@property (nonatomic, strong) ZTMainViewModel *viewModel;

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
    [self loadNewData];
    [self.tableView reloadData];
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    kApplication.statusBarStyle = UIStatusBarStyleLightContent;
    ZTLogFunc
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    ZTLogFunc
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    ZTLogFunc
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
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
    
//    self.dataSource = [AdModel mj_objectArrayWithFilename:@"ad.plist"];
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



- (void)configSubView {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:imageNamed(@"personal_20x20") style:UIBarButtonItemStyleDone target:self action:@selector(showLeft)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:imageNamed(@"message_20x20") style:UIBarButtonItemStyleDone target:self action:@selector(showMessage)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:imageNamed(@"titleViewImage")];
    [self.view addSubview:self.tableView];
    
}


- (void)showPlaceHolder {
    
    ZTWeakSelf
    [PlaceHolderView show:^{
        AdvertisementController *ad = [[AdvertisementController alloc] init];
        [weakSelf.navigationController pushViewController:ad animated:YES];
    }];
}


- (void)showLeft {
    
    ZTUser *user = [ZTUser shareUser];
    if (user.isLogin) {
        
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }else {
        [self presentViewController:[[ZTLogInController alloc] init] animated:YES completion:nil];
    }
}


- (void)showMessage {
    
    ZTTestViewController *test = [[ZTTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
//    [self presentViewController:test animated:YES completion:nil];
    //暂未开通
}



#pragma mark -- lazyMethods 懒加载区域  --------------------------

- (ZTMainViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[ZTMainViewModel alloc] init];
        
        ZTWeakSelf
        _viewModel.cellSelectBlock = ^(id data, NSIndexPath *indexPath) {
          
            
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
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainSearchCell class]) bundle:nil] forCellReuseIdentifier:searchCellId];
        [_tableView registerClass:[MainScrollCell class] forCellReuseIdentifier:scrollCellId];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainAdCell class]) bundle:nil] forCellReuseIdentifier:adCellId];
        
        [_tableView registerClass:[MainButtonCell class] forCellReuseIdentifier:buttonCellId];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
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
