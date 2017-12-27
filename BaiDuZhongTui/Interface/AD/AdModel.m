//
//  AdModel.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/6.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "AdModel.h"

@implementation AdModel

- (NSString *)share {
    
    return [NSString stringWithFormat:@"曝光佣金:￥%@/次",_share];
}

- (NSString *)clicks {
    
    return [NSString stringWithFormat:@"点击佣金:￥%@/次",_clicks];
}

@end
