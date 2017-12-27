//
//  ZTBaseViewModel.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/25.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

typedef void(^CellDidSelectBlock)(id data, NSIndexPath *indexPath);

@interface ZTBaseViewModel : NSObject<UITableViewDelegate,UITableViewDataSource>


/**
 *  加载新数据
 */
- (void)fetchNewDataCompletion:(void(^)(BOOL success))completion;


/**
 *  加载更多数据
 */
- (void)fetchMoreDataCompletion:(void(^)(BOOL success, BOOL noMoreData))completion;

/** selectedBlock*/
@property (nonatomic, copy) CellDidSelectBlock cellSelectBlock;

@end
