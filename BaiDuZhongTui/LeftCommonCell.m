//
//  LeftCommonCell.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/3.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "LeftCommonCell.h"

@implementation LeftCommonCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    
    UIImageView *leftImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:leftImageView];
    self.leftImageView = leftImageView;
    
    UILabel *title = [[UILabel alloc] init];
    title.font = SubTitleFont;
    title.textColor = TitleColor;
    [self.contentView addSubview:title];
    self.title = title;
    
    [self.leftImageView makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(20);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(25);
        make.height.equalTo(25);
        
    }];
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.leftImageView.right).offset(20);
        make.centerY.equalTo(self.contentView);
    }];
    
}



@end
