//
//  LeftAchievementCell.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/3.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "LeftAchievementCell.h"

@interface LeftAchievementCell()

@property (nonatomic, strong) UILabel *achiveMentTitle;

@property (nonatomic, strong) UIButton *finaceValueBtn;

@property (nonatomic, strong) UIButton *currentMoneyValueBtn;

@property (nonatomic, strong) UIButton *contributionValueBtn;


@property (nonatomic, strong) UILabel *finaceValueLabel;

@property (nonatomic, strong) UILabel *currentMoneyValueLabel;

@property (nonatomic, strong) UILabel *contributionValueLabel;


@end


@implementation LeftAchievementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createSubView];
    }
    return self;
}


- (void)createSubView {
    
    UILabel *achiveMentTitle = [[UILabel alloc] init];
    achiveMentTitle.font = TitleFont;
    achiveMentTitle.textColor = TitleColor;
    achiveMentTitle.text = @"众推成就";
    self.achiveMentTitle = achiveMentTitle;
    [self.contentView addSubview:achiveMentTitle];
    
    UIButton *finaceValueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finaceValueBtn.contentMode = UIControlContentHorizontalAlignmentLeft;
    finaceValueBtn.titleLabel.font = TitleFont;
    [finaceValueBtn setTitleColor:TitleColor forState:UIControlStateNormal];
    [finaceValueBtn setImage:imageNamed(@"leftTotalMoney_30x30") forState:UIControlStateNormal];
    [finaceValueBtn setTitle:@"1020" forState:UIControlStateNormal];
    [finaceValueBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    finaceValueBtn.userInteractionEnabled = NO;
    self.finaceValueBtn = finaceValueBtn;
    [self.contentView addSubview:finaceValueBtn];
    
    UIButton *currentMoneyValueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    currentMoneyValueBtn.contentMode = UIControlContentHorizontalAlignmentLeft;
    [currentMoneyValueBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    currentMoneyValueBtn.titleLabel.font = TitleFont;
    [currentMoneyValueBtn setTitleColor:TitleColor forState:UIControlStateNormal];
    [currentMoneyValueBtn setImage:imageNamed(@"leftMoney_30x30") forState:UIControlStateNormal];
    [currentMoneyValueBtn setTitle:@"9.20" forState:UIControlStateNormal];
    currentMoneyValueBtn.userInteractionEnabled = NO;
    self.currentMoneyValueBtn = currentMoneyValueBtn;
    [self.contentView addSubview:currentMoneyValueBtn];
    
    UIButton *contributionValueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    contributionValueBtn.contentMode = UIControlContentHorizontalAlignmentLeft;
    [contributionValueBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    contributionValueBtn.titleLabel.font = TitleFont;
    [contributionValueBtn setTitleColor:TitleColor forState:UIControlStateNormal];
    [contributionValueBtn setImage:imageNamed(@"leftTeamContribution_30x30") forState:UIControlStateNormal];
    [contributionValueBtn setTitle:@"200" forState:UIControlStateNormal];
    contributionValueBtn.userInteractionEnabled = NO;
    self.contributionValueBtn = contributionValueBtn;
    [self.contentView addSubview:contributionValueBtn];
    
    UILabel *finaceValueLabel = [[UILabel alloc] init];
    finaceValueLabel.font = UnenableTitleFont;
    finaceValueLabel.textColor = UnenableTitleColor;
    finaceValueLabel.text = @"历史创收";
    self.finaceValueLabel = finaceValueLabel;
    [self.contentView addSubview:finaceValueLabel];
    
    UILabel *currentMoneyValueLabel = [[UILabel alloc] init];
    currentMoneyValueLabel.font = UnenableTitleFont;
    currentMoneyValueLabel.textColor = UnenableTitleColor;
    currentMoneyValueLabel.text = @"当前余额";
    self.currentMoneyValueLabel = currentMoneyValueLabel;
    [self.contentView addSubview:currentMoneyValueLabel];
    
    UILabel *contributionValueLabel = [[UILabel alloc] init];
    contributionValueLabel.font = UnenableTitleFont;
    contributionValueLabel.textColor = UnenableTitleColor;
    contributionValueLabel.text = @"团队贡献";
    self.contributionValueLabel = contributionValueLabel;
    [self.contentView addSubview:contributionValueLabel];
    

    [self.achiveMentTitle makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(20);
    }];
    
    [self.finaceValueBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.achiveMentTitle);
        make.top.equalTo(self.achiveMentTitle.bottom).offset(20);
    }];
    
    [self.currentMoneyValueBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.finaceValueBtn.right).offset(20);
        make.top.equalTo(self.achiveMentTitle.bottom).offset(20);
    }];
    
    [self.contributionValueBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.currentMoneyValueBtn.right).offset(20);
        make.top.equalTo(self.achiveMentTitle.bottom).offset(20);
    }];
    
    [self.finaceValueLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.finaceValueBtn);
        make.top.equalTo(self.finaceValueBtn.bottom).offset(10);
    }];

    [self.currentMoneyValueLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.currentMoneyValueBtn);
        make.top.equalTo(self.currentMoneyValueBtn.bottom).offset(10);
    }];
    
    [self.contributionValueLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contributionValueBtn);
        make.top.equalTo(self.contributionValueBtn.bottom).offset(10);
    }];
    
    
}


- (void)setFinaceValue:(NSString *)finaceValue {
    
    _finaceValue = finaceValue;
    [self.finaceValueBtn setTitle:finaceValue forState:UIControlStateNormal];
}

- (void)setContributionValue:(NSString *)contributionValue {
    
    _contributionValue = contributionValue;
    [self.contributionValueBtn setTitle:contributionValue forState:UIControlStateNormal];
}

@end
