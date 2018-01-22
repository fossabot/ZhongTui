//
//  MainScrollCollectionCell.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "MainScrollCollectionCell.h"

@implementation MainScrollCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatSubView];
    }
    return self;
}


- (void)creatSubView {
    
    self.scrollImageView = [[UIImageView alloc] init];
    self.scrollImageView.layer.masksToBounds = YES;
    self.scrollImageView.layer.cornerRadius = 20;
    [self.contentView addSubview:self.scrollImageView];
    
    self.scrollTitle = [[UILabel alloc] init];
    self.scrollTitle.textColor = TitleColor;
    self.scrollTitle.font = TitleFont;
    [self.contentView addSubview:self.scrollTitle];
    
    self.scrollTag = [[ZTEdgeLabel alloc] init];
    self.scrollTag.textColor = SubTitleColor;
    self.scrollTag.font = UnenableTitleFont;
    self.scrollTag.layer.borderColor = SubTitleColor.CGColor;
    self.scrollTag.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.scrollTag];
    
    self.scrollTag1 = [[ZTEdgeLabel alloc] init];
    self.scrollTag1.textColor = SubTitleColor;
    self.scrollTag1.font = UnenableTitleFont;
    self.scrollTag1.layer.borderColor = SubTitleColor.CGColor;
    self.scrollTag1.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.scrollTag1];
    
    self.scrollTag2 = [[ZTEdgeLabel alloc] init];
    self.scrollTag2.textColor = SubTitleColor;
    self.scrollTag2.font = UnenableTitleFont;
    self.scrollTag2.layer.borderColor = SubTitleColor.CGColor;
    self.scrollTag2.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.scrollTag2];
    
    [self.scrollImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(10);
        make.left.equalTo(20);
        make.width.height.equalTo(40);
        
    }];
    
    [self.scrollTitle makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.scrollImageView.right).offset(10);
        make.top.equalTo(self.scrollImageView);
    }];
    
    [self.scrollTag makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.scrollImageView.right).offset(10);
        make.bottom.equalTo(self.scrollImageView);
    }];
    
    [self.scrollTag1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.scrollTag.right).offset(10);
        make.bottom.equalTo(self.scrollImageView);
    }];
    
    [self.scrollTag2 makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.scrollTag1.right).offset(10);
        make.bottom.equalTo(self.scrollImageView);
    }];
}

@end
