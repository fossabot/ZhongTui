//
//  ZTTenVocationViewModel.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/26.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTBaseViewModel.h"

typedef void(^CellSelectedBlock)(id data);

@interface ZTTenVocationViewModel : ZTBaseViewModel

/** block*/
@property (nonatomic, copy) CellSelectedBlock cellSelectedBlock;

/** vocation*/
@property (nonatomic, copy) NSString *vocation;

@end
