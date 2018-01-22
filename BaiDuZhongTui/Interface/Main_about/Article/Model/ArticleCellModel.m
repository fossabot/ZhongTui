//
//  ArticleCellModel.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/3.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ArticleCellModel.h"

@implementation ArticleCellModel

- (NSString *)use_count {
    return [NSString stringWithFormat:@"已被使用%@次",_use_count];
}

@end
