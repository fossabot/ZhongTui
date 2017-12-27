//
//  ZTAdModel.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/25.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTAdModel : NSObject

/** ad_id*/
@property (nonatomic, copy) NSString *ad_id;

/** ads_picture*/
@property (nonatomic, copy) NSString *ads_picture;

/** ad_sort*/
@property (nonatomic, copy) NSString *ad_sort;

/** cost_per_click*/
@property (nonatomic, copy) NSString *cost_per_click;

/** cost_per_mille*/
@property (nonatomic, copy) NSString *cost_per_mille;


@end

