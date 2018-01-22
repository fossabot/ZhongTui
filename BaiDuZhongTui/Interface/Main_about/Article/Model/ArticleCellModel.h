//
//  ArticleCellModel.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/3.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleCellModel : NSObject

@property (nonatomic, copy) NSString *article_id;
@property (nonatomic, copy) NSString *article_sort;
@property (nonatomic, copy) NSString *article_title;
@property (nonatomic, copy) NSString *article_label;
@property (nonatomic, copy) NSString *article_picurl;
@property (nonatomic, copy) NSString *use_count;

@end

