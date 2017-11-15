//
//  MainButtonCell.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "MainButtonCell.h"

static CGFloat const edgeMargin = 20;
static CGFloat const buttonW = 40;
static CGFloat const buttonH = 60;

@interface MainButtonCell()


/** titles*/
@property (nonatomic, strong) NSArray *titles;

/** images*/
@property (nonatomic, strong) NSArray *images;

@end
@implementation MainButtonCell

/** 类方法快速返回轮播cell */
+ (UINib *)replyScrollCell
{
    id cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][1];
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubview];
    }
    return self;
}


/**
 *  创建子控件
 */
- (void)createSubview {
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        btn.buttonPositionStyle = BAButtonPositionStyleTop;
        [btn setImage:imageNamed(self.images[i]) forState:UIControlStateNormal];
        [btn setTitleColor:SubTitleColor forState:UIControlStateNormal];
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = SubTitleFont;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(30, -55, -20, 0)];
        btn.tag = 100+i;
//        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [arr addObject:btn];
        [self.contentView addSubview:btn];
    }
    
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:buttonW leadSpacing:afterScale(20) tailSpacing:afterScale(20)];
    [arr makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.height.equalTo(60);
    }];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i=5; i<10; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        btn.buttonPositionStyle = BAButtonPositionStyleTop;
        [btn setTitle:self.titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:SubTitleColor forState:UIControlStateNormal];
        [btn setImage:imageNamed(self.images[i]) forState:UIControlStateNormal];
        btn.titleLabel.font = SubTitleFont;
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 20, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(30, -55, -20, 0)];
        btn.tag = 100+i;
//        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [arr1 addObject:btn];
        [self.contentView addSubview:btn];
        
        if (i==7) {
            btn.userInteractionEnabled = NO;
        }
    }
    
    UIButton *btn = arr[0];
    [arr1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:buttonW leadSpacing:afterScale(20) tailSpacing:afterScale(20)];
    [arr1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.bottom).offset(10);
        make.height.equalTo(60);
        make.bottom.equalTo(-10);
    }];
}



#pragma mark -- lazyMethods 懒加载区域  --------------------------

- (NSArray *)titles{//@"行情",
    if (!_titles) {
        _titles = [NSArray arrayWithObjects:@"房产",@"科技",@"金融",@"娱乐",@"教育",@"餐饮",@"医疗",@"服务",@"汽车",@"其他", nil];
    }
    return _titles;
}


- (NSArray *)images{
    if (!_images) {
        _images = [NSArray arrayWithObjects:
                   @"house_57x57",
                   @"technology_57x57",
                   @"finance_57x57",
                   @"entertainment_57x57",
                   @"education_57x57",
                   @"diet_57x57",
                   @"medical_57x57",
                   @"service_57x57",
                   @"vehicle_57x57",
                   @"other_57x57",
                   @"",nil];
    }
    return _images;
}


@end
