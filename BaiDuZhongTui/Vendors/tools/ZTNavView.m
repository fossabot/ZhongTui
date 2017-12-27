//
//  ZTNavView.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/12.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTNavView.h"


CGFloat leftMargin = 10.f;
CGFloat navigationBarH = 44.f;

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define StatusbarHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height)  //导航栏高度

@interface ZTNavView()

@property (nonatomic, strong) UIView *statusView;   //
@property (nonatomic, strong) UIView *navigationView;  //

@property (nonatomic, strong) UILabel *titleLabel;  //
@property (nonatomic, strong) UIButton *leftItem;  //


@end

@implementation ZTNavView

- (instancetype)initWithNavHeight:(CGFloat)height {
    
    self = [super initWithFrame:CGRectMake(0, 0, screenWidth, height)];
    if (self) {
        
        _navHeight = height;
        [self initial];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, screenWidth, navigationBarH)];
    if (self) {
     
        _navHeight = navigationBarH + StatusbarHeight;;
        [self initial];
    }
    return self;
}

/** 初始化数据*/
- (void)initial {

    _navBackgroundColor = [UIColor whiteColor];
    _titleFontValue = 20.f;
    _titleColor = [UIColor blackColor];
    _leftTitleFontValue = 16.f;
    [self createSubViews];
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self masonrySubViews];
}

/**
 创建子控件
 */
- (void)createSubViews {
    
    UIView *statusView = [[UIView alloc] init];
    statusView.backgroundColor = [UIColor whiteColor];
    self.statusView = statusView;
    [self addSubview:statusView];
    
    UIView *navigationView = [[UIView alloc] init];
    navigationView.backgroundColor = _navBackgroundColor;
    self.navigationView = navigationView;
    [self addSubview:navigationView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:_titleFontValue];
    titleLabel.textColor = _titleColor;
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.titleLabel.font = [UIFont systemFontOfSize:_leftTitleFontValue];
    [leftItem setImage:[UIImage imageNamed:_leftImageName] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.leftItem = leftItem;
    [self addSubview:leftItem];
    
}


/**
 布局子控件
 */
- (void)masonrySubViews {
    
    [self.statusView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(self);
        make.height.equalTo(StatusbarHeight);
    }];
    
    [self.navigationView makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.statusView.bottom);
    }];
    
    [self.leftItem makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(leftMargin);
        make.top.bottom.equalTo(self.navigationView);
        make.height.equalTo(self.leftItem.width);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.navigationView);
    }];
    
}


- (void)leftItemClick:(UIButton *)item {
    
    if ([self.delegate respondsToSelector:@selector(navView:didSelectedLeftItem:)]) {
        [self.delegate navView:self didSelectedLeftItem:item];
    }
}


#pragma mark setter / getter

- (void)setNavBackgroundColor:(UIColor *)navBackgroundColor {
    
    _navBackgroundColor = navBackgroundColor;
    self.statusView.backgroundColor = navBackgroundColor;
    self.navigationView.backgroundColor = navBackgroundColor;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTitleFontValue:(CGFloat)titleFontValue {
    _titleFontValue = titleFontValue;
    self.titleLabel.font = [UIFont systemFontOfSize:titleFontValue];
}

- (void)setLeftTitle:(NSString *)leftTitle {
    _leftTitle = leftTitle;
    [self.leftItem setTitle:leftTitle forState:UIControlStateNormal];
}

- (void)setLeftTitleFontValue:(CGFloat)leftTitleFontValue {
    
    _leftTitleFontValue = leftTitleFontValue;
    self.leftItem.titleLabel.font = [UIFont systemFontOfSize:leftTitleFontValue];

}

- (void)setLeftImageName:(NSString *)leftImageName {
    
    _leftImageName = leftImageName;
    [self.leftItem setImage:[UIImage imageNamed:leftImageName] forState:UIControlStateNormal];
}


@end
