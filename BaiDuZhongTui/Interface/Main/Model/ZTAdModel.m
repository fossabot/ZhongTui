//
//  ZTAdModel.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/25.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTAdModel.h"

@implementation ZTAdModel

- (NSString *)cost_per_click {
    return [NSString stringWithFormat:@"点击佣金￥%@",_cost_per_click];
}

- (NSString *)cost_per_mille {
    return [NSString stringWithFormat:@"分享佣金￥%@",_cost_per_mille];
}

@end
