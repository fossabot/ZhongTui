//
//  ZTTestViewController.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/22.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTTestViewController.h"
#import "ZTPicker.h"

@interface ZTTestViewController ()<ZTPickerDelegate>

@end

@implementation ZTTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)back:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)show:(id)sender {
    
    ZTPicker *picker = [ZTPicker pickerView];
    picker.datas = [self titles];
    picker.title = @"年龄";
    picker.delegate = self;
    [picker show];
    
}

- (NSArray *)titles {
    return @[@"70后",@"80后",@"90后",@"00后",@"10后"];
}

/** 为每行数据提供数据源*/
- (nullable NSString *)picker:(ZTPicker *_Nullable)picker titleForRow:(NSInteger)row {
    
    return [self titles][row];
}


- (nullable NSString *)firstTitleForPicker:(ZTPicker *_Nullable)picker {
     
    return @"90后";
}

/** 选中了那个选项*/
- (void)picker:(ZTPicker *)picker didSelectAtRow:(NSInteger)row title:(NSString *)title {

    NSLog(@"%@",title);
}


@end
