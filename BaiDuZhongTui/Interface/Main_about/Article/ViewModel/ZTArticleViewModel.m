//
//  ZTArticleViewModel.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/26.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTArticleViewModel.h"
#import "ArticleCell.h"
#import "ZTEmptyTableViewCell.h"
#import "ArticleCellModel.h"
#import "ZTShareParaModel.h"
#import "ZTUser.h"

@interface ZTArticleViewModel ()

/** 广告主推荐的DataSource*/
@property (nonatomic, strong) NSMutableArray *dataSource;

/** 系统推荐的dataSource*/
@property (nonatomic, strong) NSMutableArray *recommendDataSource;

@end

@implementation ZTArticleViewModel


- (void)fetchNewDataCompletion:(void (^)(BOOL success))completion {
    
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"article",PARAC,@"getartbyid",PARAM,self.adid,@"adid", nil];
    [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
        
        if (responseObject) {
            self.dataSource = [ArticleCellModel mj_objectArrayWithKeyValuesArray:responseObject[@"aderarticle"]];
            self.recommendDataSource = [ArticleCellModel mj_objectArrayWithKeyValuesArray:responseObject[@"sysarticle"]];
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
    
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:@"ad",PARAC,@"getDefault",PARAM, nil];
    [PPNetworkHelper POST:BaseUrl parameters:para success:^(id responseObject) {
        
        if (responseObject && [responseObject[STATE] isEqualToNumber:@0]) {
            
            NSMutableArray *arr = [ArticleCellModel mj_objectArrayWithKeyValuesArray:responseObject[@"ad_arr"]];
            if (arr.count) {
                [self.recommendDataSource addObjectsFromArray:arr];
                if (arr.count < 10) {
                    completion(YES,YES);
                }else{
                    completion(YES,NO);
                }
            }
        }else {
            completion(NO,NO);
        }
    } failure:^(NSError *error) {
        completion(NO,NO);
    }];
    
}



#pragma mark tableview 代理方法  ---------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.dataSource.count ? self.dataSource.count : 1;
    }else {
        return self.recommendDataSource.count ? self.recommendDataSource.count : 1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((!self.dataSource.count && indexPath.section == 0) || (!self.recommendDataSource.count && indexPath.section == 1)) {
        return 40;
    }
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
    
    if ((!self.dataSource.count && indexPath.section == 0) || (!self.recommendDataSource.count && indexPath.section == 1)) {
        return;
    }
    
    ZTWeakSelf
    ArticleCellModel *model = self.recommendDataSource[indexPath.row];
    ZTUser *user = [ZTUser shareUser];
    [self searchAdUrlArticleId:model.article_id adId:self.adid userId:user.userid completion:^(NSString *url) {
        
        if (weakSelf.articleSelectBlock) {
            weakSelf.articleSelectBlock(model, url, indexPath);
        }
        
    }];
}


- (void)searchAdUrlArticleId:(NSString *)articleId adId:(NSString *)adId userId:(NSString *)userId completion:(void(^)(NSString * url))completion {

    NSString *getUrl = @"http://zt.ywvx.com/application/getShareParam.php";
    NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:userId,@"userid",articleId,@"articleid",adId,@"toadid", nil];
    [PPNetworkHelper GET:getUrl parameters:para success:^(id responseObject) {
        
        ZTShareParaModel *model = [ZTShareParaModel mj_objectWithKeyValues:responseObject[@"wx"]];
        completion(model.share_url);
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark tableview 数据源方法  ---------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:ArticleCellId];
    ArticleCellModel *model;
    
    if ((!self.dataSource.count && indexPath.section == 0) || (!self.recommendDataSource.count && indexPath.section == 1)) {
        
        ZTEmptyTableViewCell *emptyCell = [tableView dequeueReusableCellWithIdentifier:ZTEmptyTableViewCellId];
        return emptyCell;
    }
    
    if (indexPath.section == 0) {
        model = self.dataSource[indexPath.row];
    }else {
        model = self.recommendDataSource[indexPath.row];
    }
    
    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.article_picurl] placeholderImage:imageNamed(@"")];
    cell.title.text = model.article_title;
    cell.ratingView.currentScore = 9.5f;
    cell.tagLabel.text = model.article_sort;
    cell.usedTimes.text = model.use_count;
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


@end
