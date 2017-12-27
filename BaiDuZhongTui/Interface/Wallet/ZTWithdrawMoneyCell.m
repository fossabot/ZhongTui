//
//  ZTWithdrawMoneyCell.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/17.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTWithdrawMoneyCell.h"

@implementation ZTWithdrawMoneyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubView];
    }
    return self;
}


- (void)createSubView {
    
    UIImageView *walletImage = [[UIImageView alloc] init];
    [self.contentView addSubview:walletImage];
    self.walletImage = walletImage;
    
    UILabel *title = [[UILabel alloc] init];
    title.font = TitleFont;
    title.textColor = TitleColor;
    self.title = title;
    [self.contentView addSubview:title];
    
    UILabel *subTitle = [[UILabel alloc] init];
    subTitle.font = SubTitleFont;
    subTitle.textColor = UnenableTitleColor;
    self.subTitle = subTitle;
    [self.contentView addSubview:subTitle];
    
    [self.walletImage makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(20);
        make.centerY.equalTo(self.contentView.centerY);
        make.width.height.equalTo(40);
        
    }];
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.walletImage.right).offset(20);
        make.top.equalTo(self.walletImage);
    }];
    
    [self.subTitle makeConstraints:^(MASConstraintMaker *make) {
    
        make.bottom.equalTo(self.walletImage.bottom);
        make.left.equalTo(self.walletImage.right).offset(20);
    }];
    
    
}

@end
