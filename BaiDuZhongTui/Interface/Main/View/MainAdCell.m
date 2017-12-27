//
//  MainAdCell.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "MainAdCell.h"


@implementation MainAdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.adTag.layer.masksToBounds = YES;
    self.adTag.layer.cornerRadius = 3;
    self.adTag.layer.borderWidth = 0.5;
    self.adTag.layer.borderColor = ThemeColor.CGColor;
    self.adTag.edgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
