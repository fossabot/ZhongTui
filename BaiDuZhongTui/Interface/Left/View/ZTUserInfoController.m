//
//  ZTUserInfoController.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2017/12/17.
//  Copyright © 2017年 YiWangTech. All rights reserved.
//

#import "ZTUserInfoController.h"
#import "ZTTableView.h"
#import "ZTUserTableViewCell.h"
#import "ZTUserNameTableViewCell.h"

#import "ZTUser.h"
#import "ZTUserManager.h"
#import "NSString+Predicate.h"
#import "ZTPicker.h"

@interface ZTUserInfoController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ZTPickerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet ZTTableView *userTableview;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

/** rawDataSource*/
@property (nonatomic, strong) NSMutableArray *rawDataSource; //原始的个人信息数据
/** editedDataSource*/
@property (nonatomic, strong) NSMutableArray *editedDataSource; //修改之后的个人信息数据
/** userinfoDatas*/
@property (nonatomic, strong) NSMutableArray *userinfoDatas;


@end

@implementation ZTUserInfoController
{
    BOOL _isChanging;
    BOOL _isChanged;
    NSIndexPath *_selectIndexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self config];
}

- (void)config {
    
    _isChanging = NO;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal];
    
    [self.userTableview registerClass:[ZTUserTableViewCell class] forCellReuseIdentifier:ZTUserTableViewCellId];
    [self.userTableview registerClass:[ZTUserTableViewCell class] forCellReuseIdentifier:ZTUserTableViewCellId];
    
    self.navigationItem.title = @"个人信息";
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(editUserInfo:)];
    self.rightItem = rightItem;
    
}

/** 编辑个人信息*/
- (void)editUserInfo:(UIBarButtonItem *)item {
    
    _isChanged = [ZTUser checkUserInfoChanged:@[] rawUserProperty:@[]];
    if (_isChanging) {
        //当前状态是正在改变个人数据，点击则是为了完成修改
        [self.view endEditing:YES];
    }
    _isChanging = !_isChanging;
    item.title = _isChanging ? @"编辑" : @"完成";
    
}

- (IBAction)iconClick:(UIButton *)sender {
    
    if (_isChanging) {
        ZTLog(@"可以编辑个人信息");
    }else {
        ZTLog(@"不可以编辑个人信息");
    }
}

#pragma -- mark TableViewDelegate  -----------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!_isChanging) {
        return;
    }

    _selectIndexPath = indexPath;
    if (indexPath.section == indexPath.row == 0) {
        ZTUserNameTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.nameText becomeFirstResponder];
    }else {
        
        ZTPicker *picker = [ZTPicker pickerView];
        picker.datas = self.userinfoDatas[indexPath.section][indexPath.row];
        picker.title = [self leftTitle][indexPath.section][indexPath.row];
        picker.delegate = self;
        [picker show];
    }
    
}

#pragma -- mark TableViewDataSource  --------------

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        ZTUserNameTableViewCell *nameCell = [tableView dequeueReusableCellWithIdentifier:ZTUserNameTableViewCellId];
        nameCell.leftLabel.text = [self leftTitle][indexPath.section][indexPath.row];
        nameCell.nameText.text = self.rawDataSource[indexPath.section][indexPath.row];
        nameCell.nameText.delegate = self;
        return nameCell;
        
    }else {
        
        ZTUserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ZTUserTableViewCellId];
        cell.leftLabel.text = [self leftTitle][indexPath.section][indexPath.row];
        cell.contentLabel.text = self.rawDataSource[indexPath.section][indexPath.row];
        return cell;
    }

}


- (NSArray *)leftTitle {
    return @[@[@"昵称",@"性别",@"年龄"],@[@"行业",@"城市"]];
}


#pragma mark pickerdelegate

/** 为每行数据提供数据源*/
- (nullable NSString *)picker:(ZTPicker *_Nullable)picker titleForRow:(NSInteger)row {
    NSArray *arr = self.userinfoDatas[_selectIndexPath.section][_selectIndexPath.row];
    
    return arr[row];
}

- (nullable NSString *)firstTitleForPicker:(ZTPicker *_Nullable)picker {
    return self.rawDataSource[_selectIndexPath.section][_selectIndexPath.row];
}

/** 选中了那个选项*/
- (void)picker:(ZTPicker *_Nullable)picker didSelectAtRow:(NSInteger)row title:(NSString * _Nullable)title {
    
    ZTLog(@"选中%@",title);
}


#pragma mark  textfielddelegate  -------------

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    BOOL isBlank = [NSString isBlankString:textField.text];
    
    ZTUserNameTableViewCell *cell = [self.userTableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.tipLabel.text = isBlank ? @"昵称不能为空" : @"";
    return YES;
}

#pragma mark -- lazyMethods 懒加载区域  --------------------------

- (NSMutableArray *)rawDataSource{
    if (!_rawDataSource) {
        ZTUser *user = [ZTUser shareUser];
        _rawDataSource = [NSMutableArray arrayWithObjects:@[user.user_name,user.gender,user.age],@[user.vocation,user.address], nil];
    }
    return _rawDataSource;
}

- (NSMutableArray *)editedDataSource{
    if (!_editedDataSource) {
        _editedDataSource = [NSMutableArray arrayWithArray:self.rawDataSource];
    }
    return _editedDataSource;
}

- (NSMutableArray *)userinfoDatas {
    
    if (!_userinfoDatas) {
        
        NSString * genderPath = [[NSBundle mainBundle] pathForResource:@"Gender" ofType:@"plist"];
        NSArray *gender = [[NSArray alloc] initWithContentsOfFile:genderPath];
        NSString * agePath = [[NSBundle mainBundle] pathForResource:@"Age" ofType:@"plist"];
        NSArray *age = [[NSArray alloc] initWithContentsOfFile:agePath];
        NSString * tradesPath = [[NSBundle mainBundle] pathForResource:@"Trades" ofType:@"plist"];
        NSArray *trades = [[NSArray alloc] initWithContentsOfFile:tradesPath];
        NSString * addressPath = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
        NSArray *address = [[NSArray alloc] initWithContentsOfFile:addressPath];
        _userinfoDatas = [NSMutableArray arrayWithObjects:@[@"",gender,age],@[trades,address], nil];
    }
    
    return _userinfoDatas;
}


@end
