//
//  ZTMineCardCell.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/11/17.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTMineCardCell.h"

@implementation ZTMineCardCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    
    UIImageView *cardImage = [[UIImageView alloc] init];
    [self.contentView addSubview:cardImage];
    self.cardImage = cardImage;
    
    [self.cardImage makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(10);
        make.bottom.equalTo(-10);
    }];
    
}


@end
