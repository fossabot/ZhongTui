//
//  THBaseScrollViewController.m
//  基类封装
//
//  Created by VINCENT on 2017/6/21.
//  Copyright © 2017年 北京京壹元资讯信息服务有限公司. All rights reserved.
//

#import "THBaseScrollViewController.h"


@interface THBaseScrollViewController ()

@end

@implementation THBaseScrollViewController


#pragma mark -- lifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.baseScrollView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGFloat baseViewHeight = 0;
    CGFloat baseViewWidth = 0;
    NSArray *subViews = self.baseScrollView.subviews;
    
    //遍历视图中MAXY值最大的和MAXX最大的控件，然后设置ScrollView的contentsize
    for (UIView *subView in subViews) {
        
        CGFloat maxX = CGRectGetMaxX(subView.frame);
        CGFloat maxY = CGRectGetMaxY(subView.frame);
        
        if ( maxX > baseViewWidth) {
            baseViewWidth = maxX;
        }
        if ( maxY > baseViewHeight) {
            baseViewHeight = maxY;
        }
        
    }
    
    CGFloat contentWidth = baseViewWidth > kSCREENWIDTH ? baseViewWidth : 0;
  
    CGFloat contentHeight = baseViewHeight >= kSCREENHEIGHT ? baseViewHeight+20 : kSCREENHEIGHT+20;
    
    self.baseScrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    
}


#pragma mark -- lazyMethods 懒加载区域

- (UIScrollView *)baseScrollView{
    if (!_baseScrollView) {
        CGRect rect;
        if (self.navigationController) {
            rect = CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT-ZTTopNaviHeight);
        }else {
            rect = self.view.bounds;
        }
        _baseScrollView = [[UIScrollView alloc] initWithFrame:rect];
        
    }
    return _baseScrollView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
