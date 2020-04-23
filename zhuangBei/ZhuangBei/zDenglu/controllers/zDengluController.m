//
//  zDengluController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zDengluController.h"
#import "LoginTextField.h"
#import "zDengluRequst.h"

@interface zDengluController ()

@property(strong,nonatomic)LoginTextField * accountField;

@property(strong,nonatomic)LoginTextField * passWordField;

@end

@implementation zDengluController



-(LoginTextField*)accountField
{
    if (!_accountField) {
        _accountField = [[LoginTextField alloc]init];
        _accountField.icon = [UIImage imageNamed:@"login_icon_shouji"];
        _accountField.keyboardType = UIKeyboardTypePhonePad;
        _accountField.maxLength = 11;
        _accountField.myPlaceHolder = @"请输入手机号";
    }
    return _accountField;
}

-(LoginTextField*)passWordField
{
    if (!_passWordField) {
        _passWordField = [[LoginTextField alloc]init];
        _passWordField.icon = [UIImage imageNamed:@"login_icon_shouji"];
        _passWordField.keyboardType = UIKeyboardTypePhonePad;
        _passWordField.maxLength = 12;
        _passWordField.secureTextEntry = YES;
        _passWordField.myPlaceHolder = @"请输入密码";
    }
    return _passWordField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.passWordField];
    
    [zDengluRequst getLoginWithParameters:@{} success:^(id  _Nonnull response) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-kWidthFlot(30));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(SCREEN_WIDTH-100),kWidthFlot(40)));
    }];
    
    [self.passWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.accountField.mas_bottom).offset(kWidthFlot(20));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(SCREEN_WIDTH-100),kWidthFlot(40)));
    }];
}



@end
