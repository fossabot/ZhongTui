//
//  ZTPicker.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/21.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZTPicker;

@protocol ZTPickerDelegate <NSObject>

@required
/** 为每行数据提供数据源*/
- (nullable NSString *)picker:(ZTPicker *_Nullable)picker titleForRow:(NSInteger)row;

@optional
- (nullable NSString *)firstTitleForPicker:(ZTPicker *_Nullable)picker;

/** 选中了那个选项*/
- (void)picker:(ZTPicker *_Nullable)picker didSelectAtRow:(NSInteger)row title:(NSString * _Nullable)title;

@end

@interface ZTPicker : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

/** delegate*/
@property (nullable, nonatomic, weak) id<ZTPickerDelegate> delegate;

/** title*/
@property (nullable, nonatomic, copy) NSString * title;

/** datas*/
@property (nullable, nonatomic, strong) NSArray * datas;

/** 是否在点击确定时返回选中数据*/
@property (nonatomic, assign) BOOL isFeedbackResultWhenConfirm;

//快速创建
+ (instancetype _Nullable)pickerView;

//弹出
- (void)show;

//添加弹出移除的动画效果
- (void)showInView:(UIView * _Nullable)view;

@end
