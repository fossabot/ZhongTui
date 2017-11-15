//
//  MainScrollCell.m
//  BaiDuZhongTui
//
//  Created by 杨春禹 on 2017/11/2.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "MainScrollCell.h"
#import <YJBannerView.h>
#import "MainScrollCollectionCell.h"
#import <MJExtension.h>
#import "MainScrollModel.h"

@interface MainScrollCell()<YJBannerViewDelegate,YJBannerViewDataSource>

@property (nonatomic, strong) YJBannerView *normalBannerView;

@property (nonatomic, strong) NSArray *men;

@end

@implementation MainScrollCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.normalBannerView];
        [self.normalBannerView reloadData];
    }
    return self;
}


- (NSArray *)bannerViewImages:(YJBannerView *)bannerView {
    
    return self.men;
}

// 自定义Cell方法
- (Class)bannerViewCustomCellClass:(YJBannerView *)bannerView{
    return [MainScrollCollectionCell class];
}

// 自定义Cell的数据刷新方法
- (void)bannerView:(YJBannerView *)bannerView customCell:(MainScrollCollectionCell *)customCell index:(NSInteger)index{
    
    MainScrollCollectionCell *scrollCell = (MainScrollCollectionCell *)customCell;
    
    MainScrollModel *model = self.men[index];
//    [scrollCell.scrollImageView sd_setImageWithURL:[NSURL URLWithString:model] placeholderImage:imageNamed(@"searchBar")];
    scrollCell.scrollImageView.image = imageNamed(model.image);
    
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[model.name stringByAppendingString:[NSString stringWithFormat:@"  %@",model.tip]]];
    NSAttributedString *tipStr = [[NSAttributedString alloc] initWithString:model.money attributes:@{NSForegroundColorAttributeName:YYRGB(255, 66, 45),NSFontAttributeName:NavTitleFont}];
    [string appendAttributedString:tipStr];
    NSAttributedString *yuan = [[NSAttributedString alloc] initWithString:@"元"];
    [string appendAttributedString:yuan];
    
    scrollCell.scrollTitle.attributedText = string;
//    scrollCell.scrollTitle.text = [model.name stringByAppendingString:model.tip];
    scrollCell.scrollTag.text = model.age;
    scrollCell.scrollTag1.text = model.city;
    scrollCell.scrollTag2.text = model.job;
}

// 代理方法 点击了哪个bannerView 的 第几个元素
-(void)bannerView:(YJBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
//    NSString *title = [self.titlesDataSources objectAtIndex:index];
    
    
    NSLog(@"当前%@-->%ld", bannerView, index);
}




#pragma mark  懒加载方法区域   -------------------------------------------

- (NSArray *)men {
    
    if (!_men) {
        
        NSMutableArray *arr = [MainScrollModel mj_objectArrayWithFilename:@"man.plist"];
        _men = [NSArray arrayWithArray:arr];
    }
    return _men;
}

-(YJBannerView *)normalBannerView{
    if (!_normalBannerView) {
        _normalBannerView = [YJBannerView bannerViewWithFrame:CGRectMake(0, 0, kSCREENWIDTH, 60) dataSource:self delegate:self placeholderImageName:@"searchBar" selectorString:@"sd_setImageWithURL:placeholderImage:"];
        _normalBannerView.pageControlStyle = PageControlNone;
        _normalBannerView.cycleScrollEnable = YES;
        _normalBannerView.bannerViewScrollDirection = BannerViewDirectionTop;
        _normalBannerView.autoDuration = 5.f;
    }
    return _normalBannerView;
}
@end
