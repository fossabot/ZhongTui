//
//  ZTMainViewModel.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/25.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTMainViewModel.h"
#import "ZTAdModel.h"

#import "MainButtonCell.h"
#import "MainSearchCell.h"
#import "MainScrollCell.h"
#import "MainAdCell.h"

@interface ZTMainViewModel ()

/** timesq请求的次数，依次加1*/
@property (nonatomic, assign) NSInteger times;

/** dataSource*/
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ZTMainViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _times = 1;
    }
    return self;
}

- (void)fetchNewDataCompletion:(void (^)(BOOL success))completion {
    
    _times = 1;
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"ad",PARAC,@"getDefault",PARAM,@(_times),TIMES, nil];
    [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
        
        if (responseObject && [responseObject[STATE] isEqualToString:@"0"]) {
            self.dataSource = [ZTAdModel mj_objectArrayWithKeyValuesArray:responseObject[@"ad_arr"]];
            completion(YES);
        }else {
            [MBProgressHUD showErrorMessage:@"网络状态不好，稍后再试"];
            completion(NO);
        }
    } failure:^(NSError *error) {
        
        [MBProgressHUD showErrorMessage:@"网络状态不好，稍后再试"];
        completion(NO);
    }];
    
}


- (void)fetchMoreDataCompletion:(void (^)(BOOL success, BOOL noMoreData))completion {
    
    self.times += 1;
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"ad",PARAC,@"getDefault",PARAM,@(_times),TIMES, nil];
    [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
     
        if (responseObject && [responseObject[STATE] isEqualToString:@"0"]) {
            
            NSMutableArray *arr = [ZTAdModel mj_objectArrayWithKeyValuesArray:responseObject[@"ad_arr"]];
            if (arr.count) {
                [self.dataSource addObjectsFromArray:arr];
                if (arr.count < 10) {
                    completion(YES,YES);
                }else{
                    completion(YES,NO);
                }
            }
        }else {
            self.times -= 1;
            completion(NO,NO);
        }
    } failure:^(NSError *error) {
        self.times -= 1;
        completion(NO,NO);
    }];
    
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
    
    ZTAdModel *model = self.dataSource[indexPath.row];
   
    if (indexPath.section == 3) {
        
        if (self.cellSelectBlock) {
            self.cellSelectBlock(model.ad_id, indexPath);
        }
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
        
        ZTWeakSelf
        MainButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:buttonCellId];
        cell.selectedBlock = ^(UIButton *selectedBtn) {
          
            if (weakSelf.tenVocationBlock) {
                weakSelf.tenVocationBlock(selectedBtn);
            }
        };
        
        return cell;
    }else {
        
        MainAdCell *cell = [tableView dequeueReusableCellWithIdentifier:adCellId];
        ZTAdModel *model = self.dataSource[indexPath.row];
        [cell.adImage sd_setImageWithURL:[NSURL URLWithString:model.ads_picture] placeholderImage:imageNamed(emptyImageName)];
        cell.adTag.text = model.ad_sort;
        cell.shareMoney.text = model.cost_per_mille;
        cell.clickMoney.text = model.cost_per_click;
        
        return cell;
    }
    
}





#pragma mark -- lazyMethods 懒加载区域  --------------------------

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
