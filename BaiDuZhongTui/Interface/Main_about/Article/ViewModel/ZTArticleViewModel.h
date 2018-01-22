//
//  ZTArticleViewModel.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/26.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTBaseViewModel.h"

typedef void(^ArticleCellDidSelectBlock)(id data, NSString *url, NSIndexPath *indexPath);

@interface ZTArticleViewModel : ZTBaseViewModel

/** adid*/
@property (nonatomic, copy) NSString *adid;

@property (nonatomic, copy) ArticleCellDidSelectBlock articleSelectBlock;

@end
