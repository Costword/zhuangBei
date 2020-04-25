//
//  zhuCeCard.m
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zhuCeCard.h"
#import "LoginTextField.h"

#define  heightMargin 50
#define  leftMargin 20

@interface zhuCeCard ()

@property(strong,nonatomic)NSArray * labelTitleArray;

@property(strong,nonatomic)NSMutableArray * labelArray;

@property(strong,nonatomic)LoginTextField * nameField;
@property(strong,nonatomic)LoginTextField * accountField;
@property(strong,nonatomic)LoginTextField * passWordField;
@property(strong,nonatomic)LoginTextField * checkField;
@property(strong,nonatomic)LoginTextField * inviteField;

@property(strong,nonatomic)UIButton * eyesButton;

@property(strong,nonatomic)UIButton * getCheckNumButton;

@end

@implementation zhuCeCard

-(NSArray*)labelTitleArray
{
    if (!_labelTitleArray) {
        _labelTitleArray = @[@"姓名：",@"手机号：",@"密码：",@"验证码：",@"邀请码："];
    }
    return _labelTitleArray;
}

-(NSMutableArray*)labelArray
{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

-(LoginTextField*)nameField
{
    if (!_nameField) {
        _nameField = [[LoginTextField alloc]init];
        _nameField.icon = [UIImage imageNamed:@"blank"];
        _nameField.keyboardType = UIKeyboardTypePhonePad;
        _nameField.maxLength = 11;
        _nameField.myPlaceHolder = @"请输入姓名";
    }
    return _nameField;
}

-(LoginTextField*)accountField
{
    if (!_accountField) {
        _accountField = [[LoginTextField alloc]init];
        _accountField.icon = [UIImage imageNamed:@"blank"];
        _accountField.keyboardType = UIKeyboardTypePhonePad;
        _accountField.maxLength = 11;
        _accountField.myPlaceHolder = @"请输入账号";
    }
    return _accountField;
}

-(LoginTextField*)passWordField
{
    if (!_passWordField) {
        _passWordField = [[LoginTextField alloc]init];
        _passWordField.icon = [UIImage imageNamed:@"blank"];
        _passWordField.keyboardType = UIKeyboardTypePhonePad;
        _passWordField.maxLength = 12;
        _passWordField.secureTextEntry = YES;
        _passWordField.myPlaceHolder = @"请输入密码";
    }
    return _passWordField;
}


-(LoginTextField*)checkField
{
    if (!_checkField) {
        _checkField = [[LoginTextField alloc]init];
        _checkField.icon = [UIImage imageNamed:@"blank"];
        _checkField.keyboardType = UIKeyboardTypePhonePad;
        _checkField.maxLength = 11;
        _checkField.myPlaceHolder = @"请输入验证码";
    }
    return _checkField;
}

-(LoginTextField*)inviteField
{
    if (!_inviteField) {
        _inviteField = [[LoginTextField alloc]init];
        _inviteField.icon = [UIImage imageNamed:@"blank"];
        _inviteField.keyboardType = UIKeyboardTypePhonePad;
        _inviteField.maxLength = 11;
        _inviteField.myPlaceHolder = @"请输入邀请码（选填）";
    }
    return _inviteField;
}

-(UIButton*)eyesButton
{
    if (!_eyesButton) {
        _eyesButton = [[UIButton alloc]init];
        [_eyesButton setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
        [_eyesButton setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
        _eyesButton.tag = 1;
        [_eyesButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eyesButton;
}

-(UIButton*)getCheckNumButton
{
    if (!_getCheckNumButton) {
        _getCheckNumButton = [[UIButton alloc]init];
        _getCheckNumButton.titleLabel.font = kFont(14);
        [_getCheckNumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getCheckNumButton.tag = 1;
        [_getCheckNumButton setTitle:@"获取" forState:UIControlStateNormal];
        [_getCheckNumButton setBackgroundColor:[UIColor blueColor]];
        [_getCheckNumButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCheckNumButton;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        for (int i=0; i<self.labelTitleArray.count; i++) {
            UILabel * nameLabel = [[UILabel alloc]init];
            nameLabel.textColor = [UIColor blackColor];
            nameLabel.font = kFont(18);
            nameLabel.text = self.labelTitleArray[i];
            nameLabel.numberOfLines = 0;
            [self addSubview:nameLabel];
            [self.labelArray addObject:nameLabel];
        }
        
        [self addSubview:self.nameField];
        [self addSubview:self.accountField];
        [self addSubview:self.passWordField];
        [self addSubview:self.checkField];
        [self addSubview:self.inviteField];
        
        [self addSubview:self.eyesButton];
        [self addSubview:self.getCheckNumButton];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    for (int i = 0; i<self.labelArray.count; i++) {
        UILabel * nameLabel = self.labelArray[i];
        
        CGFloat top = leftMargin + heightMargin * i;
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(top);
            make.left.mas_equalTo(leftMargin);
            make.height.mas_equalTo(40);
        }];
    }
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + heightMargin * 0);
        make.left.mas_equalTo(kWidthFlot(80));
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(40);
    }];
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + heightMargin * 1);
        make.left.mas_equalTo(kWidthFlot(80));
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(40);
    }];

    [self.passWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + heightMargin * 2);
        make.left.mas_equalTo(kWidthFlot(80));
        make.right.mas_equalTo(-(leftMargin + 40));
        make.height.mas_equalTo(40);
    }];
    
    [self.eyesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passWordField.mas_centerY);
        make.right.mas_equalTo(-leftMargin);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];

    [self.checkField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + heightMargin * 3);
        make.left.mas_equalTo(kWidthFlot(80));
        make.right.mas_equalTo(-(leftMargin + 80));
        make.height.mas_equalTo(40);
    }];
    
    [self.getCheckNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.checkField.mas_bottom);
        make.right.mas_equalTo(-leftMargin);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];

    [self.inviteField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + heightMargin * 4);
        make.left.mas_equalTo(kWidthFlot(80));
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(40);
    }];
}

-(void)buttonClick:(UIButton*)button
{
    
}



@end
