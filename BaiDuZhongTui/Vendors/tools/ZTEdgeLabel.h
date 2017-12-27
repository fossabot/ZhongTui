//
//  ZTEdgeLabel.h
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/15.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTEdgeLabel : UILabel

/** 内边距*/
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

+ (instancetype)edgeInsetLabelWithTitle:(NSString *)title
                             titleColor:(UIColor *)titleColor
                             edgeInsets:(UIEdgeInsets)edgeInsets
                            borderColor:(UIColor *)borderColor
                            borderWidth:(CGFloat)borderWidth
                               fontSize:(CGFloat)fontSize
                           maskToBounds:(BOOL)maskToBounds
                           cornerRadius:(CGFloat)cornerRadius;


@end
