//
//  PlaceHolderView.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.


#import "PlaceHolderView.h"

typedef void(^Completion)();

@interface PlaceHolderView()


@property (nonatomic, copy) Completion completion;

@end

@implementation PlaceHolderView

/** 单例*/
+ (instancetype)sharedPlaceHolderView{
    static dispatch_once_t once;
    static PlaceHolderView *placeHolder;
    dispatch_once(&once, ^ { placeHolder = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return placeHolder;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubView];
    }
    return self;
}


- (void)createSubView {
    
    
}


+ (void)showInView:(UIView *)view imageName:(NSString *)imageNmae tip:(NSString *)tip completion:(void (^)())completion {
    
    PlaceHolderView *placeHolder = [PlaceHolderView sharedPlaceHolderView];
    placeHolder.completion = completion;
    placeHolder.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [view addSubview:placeHolder];
    UIImageView *image = [[UIImageView alloc] initWithImage:imageNamed(imageNmae)];
    image.yy_width = 112;
    image.yy_height = 94;
    image.yy_center = view.yy_center;
    image.userInteractionEnabled = YES;
    [placeHolder addSubview:image];
    placeHolder.imageView = image;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = tip;
    [placeHolder addSubview:label];
    placeHolder.tip = label;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:placeHolder action:@selector(jump:)];
    [image addGestureRecognizer:tap];
}

+ (void)show:(void(^)())completion {
    
    PlaceHolderView *view = [PlaceHolderView sharedPlaceHolderView];
    view.completion = completion;
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [kKeyWindow addSubview:view];
    UIImageView *image = [[UIImageView alloc] initWithImage:imageNamed(@"mainTaskTipImage_540x400")];
    image.yy_width = 270;
    image.yy_height = 200;
    image.yy_center = view.yy_center;
    image.userInteractionEnabled = YES;
    [view addSubview:image];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(jump:)];
    [image addGestureRecognizer:tap];
    
}

- (void)jump:(UITapGestureRecognizer *)gesture {

    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
    if (_completion) {
        _completion();
    }

}


//展示分享成功的遮罩提示
+ (void)showShareSucceed:(void(^)())completion {
    
    PlaceHolderView *view = [PlaceHolderView sharedPlaceHolderView];
    view.completion = completion;
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [kKeyWindow addSubview:view];
    UIImageView *image = [[UIImageView alloc] initWithImage:imageNamed(@"shareSuccess")];
    view.imageView = image;
//    image.yy_width = 270;
//    image.yy_height = 328;
//    image.yy_center = view.yy_center;
    [view addSubview:image];
    [image makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(view.centerX);
        make.centerY.equalTo(view.centerY);
        make.width.equalTo(270);
        make.height.equalTo(328);
    }];
 
    UILabel *tip = [[UILabel alloc] init];
    tip.numberOfLines = 2;
    tip.textAlignment = NSTextAlignmentCenter;
    tip.font = TitleFont;
    tip.textColor = TitleColor;
    tip.textAlignment = NSTextAlignmentCenter;
    [image addSubview:tip];
    view.tip = tip;
    
    [tip makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(image.centerX);
        make.top.equalTo(image.bottom).offset(-60);
    }];
    
    NSMutableAttributedString * attri = [[NSMutableAttributedString alloc] initWithString:@"分享成功"];
    NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:@"\r\n获得"];
    [attri appendAttributedString:attr1];
    NSAttributedString *attr2 = [[NSAttributedString alloc] initWithString:@" 1 " attributes:@{NSFontAttributeName:sysFont(20),NSForegroundColorAttributeName:ZTRGB(255, 66, 45)}];
    [attri appendAttributedString:attr2];
    NSAttributedString *attr3 = [[NSAttributedString alloc] initWithString:@"元现金奖励"];
    [attri appendAttributedString:attr3];
    
    tip.attributedText = attri;
    [tip sizeToFit];
    
//    tip.yy_centerY = image.yy_height-50;
//    tip.yy_width = 250;
//    tip.yy_centerX = view.yy_centerX;
    
    UIButton *withdrawMoney = [UIButton buttonWithType:UIButtonTypeCustom];
    withdrawMoney.backgroundColor = ZTRGB(253, 122, 4);
    withdrawMoney.titleLabel.font = TitleFont;
    [withdrawMoney setTitle:@"立即提现" forState:UIControlStateNormal];
    [withdrawMoney addTarget:view action:@selector(withdrawMoney:) forControlEvents:UIControlEventTouchUpInside];
//    withdrawMoney.yy_centerY = image.yy_y+image.yy_height+10;
//    withdrawMoney.yy_width = 140;
//    withdrawMoney.yy_height = 40;
//    withdrawMoney.yy_centerX = view.yy_centerX;
    
    [view addSubview:withdrawMoney];
    [withdrawMoney makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(image.bottom).offset(10);
        make.centerX.equalTo(image.centerX);
        make.width.equalTo(140);
        make.height.equalTo(40);
    }];
    
}

- (void)withdrawMoney:(UIButton *)sender {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
    if (_completion) {
        _completion();
    }
    
}



//- (void)layoutSubviews {
//    
//    [super layoutSubviews];
//    
//    self.tip.yy_centerY = self.imageView.yy_height-47;
//    self.tip.yy_width = 250;
//    self.tip.yy_centerX = self.yy_centerX-25;
//    
//}

@end
