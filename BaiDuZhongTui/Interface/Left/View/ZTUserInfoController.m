//
//  ZTUserInfoController.m
//  BaiDuZhongTui
//
//  Created by VINCENT on 2018/1/3.
//  Copyright © 2018年 YiWangTech. All rights reserved.
//

#import "ZTUserInfoController.h"
#import "ZTUserInfoView.h"
#import "ZTUserInfoPickerCell.h"
#import "ZTPicker.h"
#import "ZTImagePickerHelper.h"


static ZTPicker *_picker;

@interface ZTUserInfoController ()<ZTPickerDelegate>

/** icon*/
@property (nonatomic, strong) UIButton *icon;
@property (nonatomic, strong) UIButton *edit;

/** name*/
@property (nonatomic, strong) ZTUserInfoView *nameCell;

/** picker*/
@property (nonatomic, strong) ZTUserInfoPickerCell *genderView;
@property (nonatomic, strong) ZTUserInfoPickerCell *ageView;
@property (nonatomic, strong) ZTUserInfoPickerCell *vocationView;
@property (nonatomic, strong) ZTUserInfoPickerCell *cityView;

/** datasource*/
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ZTUserInfoController
{
    NSString *_firstTitle;
    ZTUserInfoPickerCell *_selectedPicker;
    BOOL _isEditing;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isEditing = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self configSubView];
    [self masonrySubView];
    [self setUser];
    [self setUserinteractionEnable];
}

- (void)setUser {
    
    ZTUser *user = [ZTUser shareUser];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:user.avatar] forState:UIControlStateNormal placeholderImage:imageNamed(placeHolderAvatar)];
    self.nameCell.nameText.text = user.user_name;
    [self.genderView.userinfoPickerBtn setTitle:user.gender forState:UIControlStateNormal];
    [self.ageView.userinfoPickerBtn setTitle:user.age forState:UIControlStateNormal];
    [self.vocationView.userinfoPickerBtn setTitle:user.vocation forState:UIControlStateNormal];
    [self.cityView.userinfoPickerBtn setTitle:user.address forState:UIControlStateNormal];
    
}

- (void)configSubView {
    
    self.baseScrollView.backgroundColor = GrayBackGroundColor;
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(edit:)];
    self.navigationItem.rightBarButtonItem = edit;
    
    
    UIButton *icon = [UIButton buttonWithType:UIButtonTypeCustom];
    icon.layer.cornerRadius = 30;
    icon.layer.masksToBounds = YES;
    [icon setImage:imageNamed(placeHolderAvatar) forState:UIControlStateNormal];
    icon.titleLabel.font = SubTitleFont;
    [icon addTarget:self action:@selector(iconClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseScrollView addSubview:icon];
    self.icon = icon;
    
    UIButton *editIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    [editIcon setTitle:@"修改头像" forState:UIControlStateNormal];
    editIcon.titleLabel.font = SubTitleFont;
    [editIcon setTitleColor:UnenableTitleColor forState:UIControlStateNormal];
    [editIcon addTarget:self action:@selector(iconClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseScrollView addSubview:editIcon];
    self.edit = editIcon;
    
    ZTWeakSelf
    ZTUserInfoView *nameCell = [ZTUserInfoView userinfoView];
    nameCell.leftLabel.text = @"姓名";
    [self.baseScrollView addSubview:nameCell];
    nameCell.nameViewBlock = ^(NSString *name) {
        
    };
    self.nameCell = nameCell;
    
    ZTUserInfoPickerCell *genderCell = [ZTUserInfoPickerCell userinfoView];
    genderCell.leftLabel.text = @"性别";
    [self.baseScrollView addSubview:genderCell];
    genderCell.buttonTouchedBlock = ^{
        
        [weakSelf genderClick];
    };
    self.genderView = genderCell;
    
    ZTUserInfoPickerCell *ageCell = [ZTUserInfoPickerCell userinfoView];
    ageCell.leftLabel.text = @"年龄";
    [self.baseScrollView addSubview:ageCell];
    ageCell.buttonTouchedBlock = ^{
        
        [weakSelf ageClick];
    };
    self.ageView = ageCell;
    
    ZTUserInfoPickerCell *vocationCell = [ZTUserInfoPickerCell userinfoView];
    vocationCell.leftLabel.text = @"行业";
    [self.baseScrollView addSubview:vocationCell];
    vocationCell.buttonTouchedBlock = ^{
        
        [weakSelf vocationClick];
    };
    self.vocationView = vocationCell;
    
    ZTUserInfoPickerCell *cityCell = [ZTUserInfoPickerCell userinfoView];
    cityCell.leftLabel.text = @"城市";
    [self.baseScrollView addSubview:cityCell];
    cityCell.buttonTouchedBlock = ^{
        
        [weakSelf cityClick];
    };
    self.cityView = cityCell;
    
}


- (void)masonrySubView {
    
    [self.icon makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(60);
        make.width.height.equalTo(afterScale(80));
        make.centerX.equalTo(self.baseScrollView);
    }];
    
    [self.edit makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.icon.bottom).offset(5);
        make.centerX.equalTo(self.icon);
    }];
    
    [self.nameCell makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.edit.bottom).offset(30);
        make.width.equalTo(self.baseScrollView);
        make.centerX.equalTo(self.baseScrollView);
        make.height.equalTo(60);
    }];
    
    [self.genderView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.nameCell.bottom);
        make.width.equalTo(self.baseScrollView);
        make.centerX.equalTo(self.baseScrollView);
        make.height.equalTo(60);
    }];
    
    [self.ageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.genderView.bottom);
        make.width.equalTo(self.baseScrollView);
        make.centerX.equalTo(self.baseScrollView);
        make.height.equalTo(60);
    }];
    
    [self.vocationView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.ageView.bottom).offset(30);
        make.width.equalTo(self.baseScrollView);
        make.centerX.equalTo(self.baseScrollView);
        make.height.equalTo(60);
    }];
    
    [self.cityView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.vocationView.bottom);
        make.width.equalTo(self.baseScrollView);
        make.centerX.equalTo(self.baseScrollView);
        make.height.equalTo(60);
    }];
    
}


#pragma mark -- inner Methods 自定义方法  -------------------------------

- (void)edit:(UIBarButtonItem *)item {
    
    _isEditing = !_isEditing;
    item.title = _isEditing ? @"取消" : @"编辑";
    
//    [self.baseScrollView.subviews makeObjectsPerformSelector:@selector(setUserInteractionEnabled:) withObject:@(_isEditing)];
    [self setUserinteractionEnable];
    
}

- (void)setUserinteractionEnable {
    
    self.icon.userInteractionEnabled = _isEditing;
    self.edit.userInteractionEnabled = _isEditing;
    self.nameCell.userInteractionEnabled = _isEditing;
    self.genderView.userInteractionEnabled = _isEditing;
    self.ageView.userInteractionEnabled = _isEditing;
    self.vocationView.userInteractionEnabled = _isEditing;
}


/** 点击切换头像*/
- (void)iconClick:(UIButton *)icon {
    
    if (!_isEditing) {
        return;
    }
    ZTWeakSelf
    ZTUser *user = [ZTUser shareUser];
    [ZTImagePickerHelper showImagePicker:^(UIImage *sourceImage) {
       
        [MBProgressHUD showIndicatorConstantInWindow];
        
        NSDictionary *para = [NSDictionary dictionaryWithObjectsAndKeys:user.userid,USERID, nil];
        [PPNetworkHelper uploadImagesWithURL:avatorUrl parameters:para name:@"file" images:@[sourceImage] fileNames:nil imageScale:0.5 imageType:@"png" progress:^(NSProgress *progress) {
            
            
        } success:^(id responseObject) {
            ZTLog(@"上传头像成功");
            [user setAvatar:responseObject[@"avatar"]];
            [MBProgressHUD hideHUD];
            [weakSelf.icon setImage:sourceImage forState:UIControlStateNormal];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            ZTLog(@"上传头像失败");
        }];
    }];
}


- (void)genderClick {
    
    if (!_isEditing) {
        return;
    }
    ZTUser *user = [ZTUser shareUser];
    _firstTitle = user.gender;
    _selectedPicker = self.genderView;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Gender" ofType:@"plist"];
    self.dataSource = [NSMutableArray arrayWithContentsOfFile:path];
    ZTPicker *picker = [self picker];
    picker.datas = self.dataSource;
    picker.title = @"性别";
    [picker show];
}

- (void)ageClick {
    
    if (!_isEditing) {
        return;
    }
    ZTUser *user = [ZTUser shareUser];
    _firstTitle = user.age;
    _selectedPicker = self.ageView;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Age" ofType:@"plist"];
    self.dataSource = [NSMutableArray arrayWithContentsOfFile:path];
    ZTPicker *picker = [self picker];
    picker.datas = self.dataSource;
    picker.title = @"年龄";
    [picker show];
}

- (void)vocationClick {
    
    if (!_isEditing) {
        return;
    }
    ZTUser *user = [ZTUser shareUser];
    _firstTitle = user.vocation;
    _selectedPicker = self.vocationView;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Trades" ofType:@"plist"];
    self.dataSource = [NSMutableArray arrayWithContentsOfFile:path];
    ZTPicker *picker = [self picker];
    picker.datas = self.dataSource;
    picker.title = @"行业";
    [picker show];
}

- (void)cityClick {
    
    if (!_isEditing) {
        return;
    }
    ZTUser *user = [ZTUser shareUser];
    _firstTitle = user.address;
    _selectedPicker = self.cityView;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.dataSource = [NSMutableArray arrayWithContentsOfFile:path];
    ZTPicker *picker = [self picker];
    picker.datas = self.dataSource;
    picker.title = @"城市";
    [picker show];
}



- (ZTPicker *)picker {
    
    if (!_picker) {
        _picker = [ZTPicker pickerView];
        _picker.delegate = self;
    }
    return _picker;
}

#pragma mark  ---  pickerDelegate

- (NSString *)picker:(ZTPicker *)picker titleForRow:(NSInteger)row {
    
    return self.dataSource[row];
}

- (void)picker:(ZTPicker *)picker didSelectAtRow:(NSInteger)row title:(NSString *)title {
    
    [_selectedPicker selecTitle:title];
    ZTLog(@"选中了 %ld 行 title: %@",row,title);
}

- (NSString *)firstTitleForPicker:(ZTPicker *)picker {
    
    return _firstTitle;
}

@end
