//
//  ZTPicker.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/21.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#define SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH   [UIScreen mainScreen].bounds.size.width

#define MainBackColor [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1]

#define BackViewH 300
#define TopH 50
#define PickerViewCornerRadius 10

#import "ZTPicker.h"

@interface ZTPicker ()

/** view */
@property (nonatomic,strong) UIView *backView;
/** button */
@property (nonatomic,strong) UIButton *doneBtn;
/** titleLabel*/
@property (nonatomic, strong) UILabel *titleLabel;
/** pickerView */
@property (nonatomic,strong) UIPickerView *pickerView;


@end

@implementation ZTPicker
{
    NSInteger _selectedRow;
//    NSInteger _selectedComponent;
    CGAffineTransform _backTransForm;
}
//快速创建
+(instancetype _Nullable)pickerView
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    if (self) {
        
        self.isFeedbackResultWhenConfirm = YES;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
//        [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self configSubView];
    }
    return self;
}

- (void)configSubView {
    
    self.backView = [[UIView alloc]init];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    self.doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.doneBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.doneBtn];
    
    UILabel *titlelb = [[UILabel alloc]init];
    titlelb.textColor = BlackColor;
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.text = @"请选择";
    titlelb.font = [UIFont systemFontOfSize:25];
    [self.backView addSubview:titlelb];
    self.titleLabel = titlelb;
    
    self.pickerView = [[UIPickerView alloc]init];
    [self.pickerView setBackgroundColor:MainBackColor];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    [self.pickerView selectRow:0 inComponent:0 animated:YES];
    [self.backView addSubview:self.pickerView];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if ([self.delegate respondsToSelector:@selector(firstTitleForPicker:)]) {
        NSString * title = [self.delegate firstTitleForPicker:self];
        [self chooseInitTitle:title];
    }else {
        [self.pickerView selectRow:0 inComponent:0 animated:YES];
        ZTLog(@"没有实现初始化选择数据的方法");
    }
    
    self.backView.frame = CGRectMake(0, SCREENHEIGHT-BackViewH, SCREENWIDTH, BackViewH);
    self.doneBtn.frame = CGRectMake(SCREENWIDTH-60, 5, 50, 40);
//    self.titleLabel.yy_centerX = self.backView.yy_centerX;
//    self.titleLabel.yy_y = 20;
    self.titleLabel.frame = CGRectMake(100, 10, SCREENWIDTH-200, 30);
    self.pickerView.frame = CGRectMake(0, TopH, SCREENWIDTH, BackViewH-TopH);
    
    //为view上面的两个角做成圆角。不喜欢的可以注掉
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.backView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.backView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.backView.layer.mask = maskLayer;
    
    
}

/** 选择初始的标题的那个字符*/
- (void)chooseInitTitle:(NSString *)title {
    
    NSInteger index = [self.datas indexOfObject:title];
    
    [self.pickerView selectRow:index inComponent:0 animated:YES];
}

#pragma mark -- inner Methods 自定义方法  -------------------------------

//弹出
- (void)show
{
    [self showInView:[UIApplication sharedApplication].keyWindow];
}

//添加弹出移除的动画效果
- (void)showInView:(UIView *)view
{
    ZTLogFunc
    [view addSubview:self];
    // 浮现
    [UIView animateWithDuration:0.5 animations:^{
//        CGPoint point = self.backView.center;
//        point.y -= BackViewH;
//        self.backView.center = point;
        self.backView.transform = CGAffineTransformMakeTranslation(0, -BackViewH);
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)quit
{
    
    if (_isFeedbackResultWhenConfirm && [self.delegate respondsToSelector:@selector(picker:didSelectAtRow:title:)]) {
        [self.delegate picker:self didSelectAtRow:_selectedRow title:self.datas[_selectedRow]];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        CGPoint point = self.backView.center;
        point.y += BackViewH;
        self.backView.center = point;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.datas.count;
}

#pragma mark - 代理
// 返回第component列第row行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.delegate picker:self titleForRow:row];
}

// 选中第component第row的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedRow = row;
    if (!_isFeedbackResultWhenConfirm) {
        
        [self.delegate picker:self didSelectAtRow:row title:self.datas[row]];
    }
}



#pragma  mark  setter

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

@end
