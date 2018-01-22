//
//  ZTTenVocationViewModel.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/26.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTTenVocationViewModel.h"
#import "ZTAdModel.h"
#import "MainAdCell.h"

@interface ZTTenVocationViewModel ()<UITableViewDelegate,UITableViewDataSource>

/** timesq请求的次数，依次加1*/
@property (nonatomic, assign) NSInteger times;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ZTTenVocationViewModel


- (void)fetchNewDataCompletion:(void (^)(BOOL))completion {
    
    _times = 1;
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"ad",PARAC,@"getDiffent",PARAM,@(_times),TIMES,self.vocation,@"type", nil];
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

- (void)fetchMoreDataCompletion:(void (^)(BOOL, BOOL))completion {
 
    self.times += 1;
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"ad",PARAC,@"getDefault",PARAM,@(_times),TIMES,self.vocation,@"type", nil];
    [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
        
        if (responseObject && [responseObject[STATE] isEqualToNumber:@0]) {
            
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZTAdModel *admodel = self.dataSource[indexPath.row];
    if (_cellSelectedBlock) {
        _cellSelectedBlock(admodel.ad_id);
    }
    
}


#pragma mark tableview 数据源方法  ---------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainAdCell *cell = [tableView dequeueReusableCellWithIdentifier:adCellId];
    ZTAdModel *model = self.dataSource[indexPath.row];
    [cell.adImage sd_setImageWithURL:[NSURL URLWithString:model.ads_picture] placeholderImage:imageNamed(placeHolderMini)];
    cell.adTag.text = model.ad_sort;
    cell.shareMoney.text = model.cost_per_mille;
    cell.clickMoney.text = model.cost_per_click;
    
    return cell;
    
}


#pragma mark  懒加载方法区域   -------------------------------------------

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}



@end
