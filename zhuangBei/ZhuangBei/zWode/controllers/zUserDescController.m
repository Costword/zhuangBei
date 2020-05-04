//
//  zUserDescController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zUserDescController.h"
#import <UITextView+WZB.h>

@interface zUserDescController ()<UITextViewDelegate>

@property(strong,nonatomic)UIButton * imageHeader;

@property(strong,nonatomic)UIButton * nameLabel;

@property(strong,nonatomic)UITextView * descTextView;

@property(strong,nonatomic)UIButton * editButton;

@end

@implementation zUserDescController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


-(UIButton*)imageHeader
{
    if (!_imageHeader) {
        _imageHeader = [[UIButton alloc]init];
        _imageHeader.layer.cornerRadius = kWidthFlot(2);
        _imageHeader.clipsToBounds = YES;
        [_imageHeader setBackgroundImage:[UIImage imageNamed:@"testicon"] forState:UIControlStateNormal];
    }
    return _imageHeader;
}
-(UIButton*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UIButton alloc]init];
        _nameLabel.titleLabel.font = kFont(20);
        _nameLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_nameLabel setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
        [_nameLabel setTitle:@"阿秀" forState:UIControlStateNormal];
        _nameLabel.clipsToBounds = YES;
        _nameLabel.tag = 1;
    }
    return _nameLabel;
}


-(UITextView*)descTextView
{
    if (!_descTextView) {
        _descTextView = [[UITextView alloc]init];
        _descTextView.font = kFont(18);
        _descTextView.backgroundColor = [UIColor whiteColor];
        _descTextView.textColor = [UIColor colorWithHexString:@"#000000"];
        _descTextView.layer.cornerRadius = kWidthFlot(15);
        _descTextView.layer.borderWidth = 1;
        _descTextView.layer.borderColor = [UIColor colorWithHexString:@"#E1E5EA"].CGColor;
        _descTextView.delegate =self;
        [_descTextView setWzb_placeholder:@"请填写个人简介"];
        [_descTextView setWzb_placeholderColor:[UIColor colorWithHexString:@"#bababa"]];
    }
    return _descTextView;
}

-(UIButton*)editButton
{
    if (!_editButton) {
        _editButton = [[UIButton alloc]init];
        _editButton.titleLabel.font = kFont(20);
        [_editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        _editButton.backgroundColor = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        _editButton.layer.cornerRadius = kWidthFlot(20);
        _editButton.clipsToBounds = YES;
        _editButton.tag = 1;
        [_editButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageHeader];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.descTextView];
    [self.view addSubview:self.editButton];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.imageHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(44));
        make.top.mas_equalTo(kWidthFlot(15));
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(50), kWidthFlot(50)));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageHeader.mas_right).offset(5);
        make.top.mas_equalTo(kWidthFlot(15));
        make.right.mas_equalTo(-kWidthFlot(40));
        make.height.mas_equalTo(kWidthFlot(50));
    }];
    
    [self.descTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageHeader.mas_bottom).offset(30);
        make.right.mas_equalTo(-kWidthFlot(40));
        make.left.mas_equalTo(kWidthFlot(45));
        make.height.mas_equalTo(kWidthFlot(200));
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descTextView.mas_bottom).offset(30);
        make.right.mas_equalTo(-kWidthFlot(40));
        make.left.mas_equalTo(kWidthFlot(45));
        make.height.mas_equalTo(kWidthFlot(40));
    }];
}

-(void)buttonClick:(UIButton*)button
{
    if (self.descTextView.text.length>0) {
        [[zHud shareInstance] showMessage:self.descTextView.text];
    }else
    {
        [[zHud shareInstance] showMessage:@"请填写个人简介"];
    }
    
}

@end
