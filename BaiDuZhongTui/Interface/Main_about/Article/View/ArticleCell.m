//
//  ArticleCell.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/3.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ArticleCell.h"

@interface ArticleCell()



@end
@implementation ArticleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createSubView];
    }
    return self;
}


- (void)createSubView {
    
    UIImageView *leftImageView = [[UIImageView alloc] init];
    self.leftImageView = leftImageView;
    [self.contentView addSubview:leftImageView];
    
    UILabel *title = [[UILabel alloc] init];
    title.textColor = TitleColor;
    title.font = TitleFont;
    title.numberOfLines = 2;
    self.title = title;
    [self.contentView addSubview:title];
    
    ZTEdgeLabel *tagLabel = [[ZTEdgeLabel alloc] init];
    tagLabel.layer.masksToBounds = YES;
    tagLabel.layer.borderColor = ThemeColor.CGColor;
    tagLabel.textColor = ThemeColor;
    tagLabel.font = UnenableTitleFont;
    self.tagLabel = tagLabel;
    [self.contentView addSubview:tagLabel];
    
    LEEStarRating *ratingView = [[LEEStarRating alloc] initWithFrame:CGRectMake(0, 0, 70, 25) Count:5];
    
    ratingView.spacing = 3.0f;
    
    ratingView.checkedImage = [UIImage imageNamed:@"star_orange"];
    
    ratingView.uncheckedImage = [UIImage imageNamed:@"star_gray"];
    
    ratingView.type = RatingTypeUnlimited;
    
    ratingView.touchEnabled = NO;
    
    ratingView.slideEnabled = NO;
    
    ratingView.maximumScore = 10.0f;
    
    ratingView.minimumScore = 0.0f;
    self.ratingView = ratingView;
    [self.contentView addSubview:ratingView];
    
    // 请在设置完成最大最小的分数后再设置当前分数
    
    ratingView.currentScore = 9.5f;
 
    UILabel *usedTimes = [[UILabel alloc] init];
    usedTimes.textColor = SubTitleColor;
    usedTimes.font = SubTitleFont;
    self.usedTimes = usedTimes;
    [self.contentView addSubview:usedTimes];

    [self.leftImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(10);
        make.width.equalTo(100);
        make.height.equalTo(70);
    }];
    
    [self.title makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.leftImageView.right).offset(10);
        make.top.equalTo(self.leftImageView);
        make.right.equalTo(self.contentView.right).offset(-10);
    }];
 
    [self.tagLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.title);
        make.top.equalTo(self.title.bottom).offset(10);
    }];
    
    [self.ratingView makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.title);
        make.top.equalTo(self.tagLabel.bottom).offset(10);
        make.width.equalTo(70);
        make.height.equalTo(20);
    }];
    
    [self.usedTimes makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.tagLabel.bottom).offset(10);
    }];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    LEEStarRating *ratingView = [[LEEStarRating alloc] initWithFrame:CGRectMake(15, 300, CGRectGetWidth(self.contentView.frame) - 30, 0) Count:10];
//    
//    ratingView.spacing = 10.0f;
//    
//    ratingView.checkedImage = [UIImage imageNamed:@"star_orange"];
//    
//    ratingView.uncheckedImage = [UIImage imageNamed:@"star_gray"];
//    
//    ratingView.type = RatingTypeUnlimited;
//    
//    ratingView.touchEnabled = YES;
//    
//    ratingView.slideEnabled = YES;
//    
//    ratingView.maximumScore = 10.0f;
//    
//    ratingView.minimumScore = 0.0f;
//    
//    [self.contentView addSubview:ratingView];
//    
//    ratingView.currentScoreChangeBlock = ^(CGFloat score){
//        
//        
//        
//        NSLog(@"三 [%.2f]" , score);
//    };
    
    // 请在设置完成最大最小的分数后再设置当前分数
    
//    ratingView.currentScore = 9.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
