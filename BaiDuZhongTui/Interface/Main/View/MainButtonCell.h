//
//  MainButtonCell.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//
#define buttonCellId @"buttonCell"

#import <UIKit/UIKit.h>


typedef void(^TenVocztionSelected)(UIButton *selectedBtn);

@interface MainButtonCell : UITableViewCell

/** 选中的button回调*/
@property (nonatomic, copy) TenVocztionSelected selectedBlock;

@end
