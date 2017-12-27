//
//  ArticleCellModel.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/3.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ArticleCellModel.h"

@implementation ArticleCellModel

- (NSString *)usedTimes {
    return [NSString stringWithFormat:@"已被使用%@次",_usedTimes];
}

@end
