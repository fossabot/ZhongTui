//
//  MainTableViewCell.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

/** 类方法快速返回搜索cell */
+ (UINib *)replySearchCell
{

    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    return nib;
//    MainTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
//    return cell;
}

/** 类方法快速返回轮播cell */
+ (UINib *)replyScrollCell
{

    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    return nib;
//    id cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][1];
//    return cell;
}


/** 类方法快速返回广告cell */
+ (UINib *)replyADCell
{
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    return nib;
//    id cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
//    return cell;
}

@end
