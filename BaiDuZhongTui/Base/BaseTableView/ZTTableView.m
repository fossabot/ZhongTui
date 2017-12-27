//
//  ZTTableView.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/14.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTTableView.h"

@implementation ZTTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
 
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
#endif
    
    }
    return self;
}

@end
