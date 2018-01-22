//
//  ZTMainViewModel.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/25.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTBaseViewModel.h"

typedef void(^TenVocationBlock)(UIButton *button);

@interface ZTMainViewModel : ZTBaseViewModel

/** 十大行业的button回调*/
@property (nonatomic, copy) TenVocationBlock tenVocationBlock;

@end
