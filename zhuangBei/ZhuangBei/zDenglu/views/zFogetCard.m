//
//  zFogetCard.m
//  ZhuangBei
//
//  Created by aa on 2020/7/23.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zFogetCard.h"
#import "LoginTextField.h"
#import "phoneNumCheck.h"

#define  heightMargin 45
#define  leftMargin 25

#define NUM @"0123456789"
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface zFogetCard ()<UITextFieldDelegate>

@property(strong,nonatomic)NSArray * labelTitleArray;

@property(strong,nonatomic)NSMutableArray * labelArray;

@property(strong,nonatomic)LoginTextField * nameField;
@property(strong,nonatomic)LoginTextField * passwordField1;
@property(strong,nonatomic)LoginTextField * passwordField2;
@property(strong,nonatomic)LoginTextField * checkField;
//@property(strong,nonatomic)LoginTextField * inviteField;

//@property(strong,nonatomic)UIButton * eyesButton;
@property(strong,nonatomic)UIButton * getCheckNumButton;
@property(strong,nonatomic)UIButton * loginBtn;

//@property(strong,nonatomic)UIButton * aggreBtn;//同意
//@property(strong,nonatomic)UILabel * userKnow;//用户须知

//@property(strong,nonatomic)TYAttributedLabel*gotoLoginLabel;

@property(strong,nonatomic)NSMutableDictionary * userDic;

@end

@implementation zFogetCard


-(NSMutableDictionary*)userDic
{
    if (!_userDic) {
        _userDic = [NSMutableDictionary dictionary];
    }
    return _userDic;
}

-(NSArray*)labelTitleArray
{
    if (!_labelTitleArray) {
        _labelTitleArray = @[@"手机号：",@"验证码：",@"新密码：",@"确认密码："];
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
        _nameField.myPlaceHolder = @"请输入手机号";
    }
    return _nameField;
}

-(LoginTextField*)passwordField1
{
    if (!_passwordField1) {
        _passwordField1 = [[LoginTextField alloc]init];
        _passwordField1.delegate = self;
        _passwordField1.icon = [UIImage imageNamed:@"blank"];
        _passwordField1.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordField1.maxLength = 12;
        [_passwordField1 setSecureTextEntry:YES];
        _passwordField1.myPlaceHolder = @"请输入新密码";
    }
    return _passwordField1;
}

-(LoginTextField*)passwordField2
{
    if (!_passwordField2) {
        _passwordField2 = [[LoginTextField alloc]init];
        _passwordField2.delegate = self;
        _passwordField2.icon = [UIImage imageNamed:@"blank"];
        _passwordField2.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordField2.maxLength = 12;
        [_passwordField2 setSecureTextEntry:YES];
        _passwordField2.myPlaceHolder = @"请输入确认密码";
    }
    return _passwordField2;
}


-(LoginTextField*)checkField
{
    if (!_checkField) {
        _checkField = [[LoginTextField alloc]init];
        _checkField.icon = [UIImage imageNamed:@"blank"];
        _checkField.keyboardType = UIKeyboardTypeASCIICapable;
        _checkField.maxLength = 11;
        _checkField.myPlaceHolder = @"请输入验证码";
    }
    return _checkField;
}




-(UIButton*)getCheckNumButton
{
    if (!_getCheckNumButton) {
        _getCheckNumButton = [[UIButton alloc]init];
        _getCheckNumButton.titleLabel.font = kFont(14);
        [_getCheckNumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getCheckNumButton.tag = 2;
        [_getCheckNumButton setTitle:@"获取" forState:UIControlStateNormal];
        [_getCheckNumButton setBackgroundColor:[kMainSingleton colorWithHexString:@"#3F50B5" alpha:1]];
        [_getCheckNumButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCheckNumButton;
}


-(UIButton*)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        _loginBtn.titleLabel.font = kFont(20);
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"提交" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        _loginBtn.layer.cornerRadius = kWidthFlot(20);
        _loginBtn.clipsToBounds = YES;
        _loginBtn.tag = 4;
        [_loginBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
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
        [self addSubview:self.passwordField1];
        [self addSubview:self.passwordField2];
        [self addSubview:self.checkField];
        [self addSubview:self.getCheckNumButton];
        
        [self addSubview:self.loginBtn];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    for (int i = 0; i<self.labelArray.count; i++) {
        UILabel * nameLabel = self.labelArray[i];
        
        CGFloat top = leftMargin + (heightMargin + leftMargin)* i;
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(top);
            make.left.mas_equalTo(leftMargin);
            make.height.mas_equalTo(40);
        }];
    }
    
    CGFloat left = kWidthFlot(100);
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + (heightMargin + leftMargin) * 0);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(40);
    }];
    
    [self.checkField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + (heightMargin + leftMargin) * 1);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-(leftMargin + 80));
        make.height.mas_equalTo(40);
    }];
    
    [self.getCheckNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.checkField.mas_bottom);
        make.right.mas_equalTo(-leftMargin);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    [self.passwordField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + (heightMargin + leftMargin) * 2);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(40);
    }];

    [self.passwordField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + (heightMargin + leftMargin) * 3);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-(leftMargin));
        make.height.mas_equalTo(40);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordField2.mas_bottom).offset(kWidthFlot(40));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(kWidthFlot(285));
        make.height.mas_equalTo(kWidthFlot(45));
    }];
}

-(void)buttonClick:(UIButton*)button
{
    if (button.tag == 1) {
        return;
    }
    if (button.tag == 2) {
        //验证码
        BOOL rightNum = [phoneNumCheck validateMobile:self.nameField.text];
        if (rightNum) {
            if (self.getMessageCodeTapBack) {
                self.getMessageCodeTapBack(self.nameField.text);
            }
            [self daojishi];
        }else
        {
            [[zHud shareInstance]showMessage:@"请输入正确的手机号"];
        }
        return;
    }
    if (button.tag == 3) {
        return;
    }
    if (button.tag == 4) {
        //注册
        if (self.nameField.text.length==0) {
            [[zHud shareInstance]showMessage:@"姓名不可为空"];
            return;
        }
        if (self.passwordField1.text.length==0) {
            [[zHud shareInstance]showMessage:@"手机号不可为空"];
            return;
        }
        if (self.passwordField1.text.length<6) {
            [[zHud shareInstance]showMessage:@"请输入至少6位数密码"];
            return;
        }
        if (self.checkField.text.length==0) {
            [[zHud shareInstance]showMessage:@"验证码不可为空"];
            return;
        }
        if (![self.passwordField1.text isEqualToString:self.passwordField2.text]) {
            [[zHud shareInstance]showMessage:@"请输相同的密码"];
            return;
        }
        
        NSString * password = self.passwordField1.text;
        [self.userDic setObject:self.nameField.text forKey:@"username"];
//        [self.userDic setObject:self.passwordField1.text forKey:@"password"];
        [self.userDic setObject:password forKey:@"password"];
        [self.userDic setObject:self.checkField.text forKey:@"verificationCode"];
        
        if (self.zhuceBack) {
            self.zhuceBack(self.userDic);
        }
    }
}


-(void)daojishi
{
    __block NSInteger second = 60;
       //(1)创建一个队列
       dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
       //(2)创建一个定时器模拟事件源
       dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
       //(3)设置定时间隔
       dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
       //(4)设置定时器响应回调
       dispatch_source_set_event_handler(timer, ^{
           dispatch_async(dispatch_get_main_queue(), ^{
               if (second == 0) {
                   self.getCheckNumButton.userInteractionEnabled = YES;
                   [self.getCheckNumButton setTitle:[NSString stringWithFormat:@"获取"] forState:UIControlStateNormal];
                   second = 60;
                   //(6)取消定时器
                   dispatch_cancel(timer);
               } else {
                   self.getCheckNumButton.userInteractionEnabled = NO;
                   [self.getCheckNumButton setTitle:[NSString stringWithFormat:@"%ldS",second] forState:UIControlStateNormal];
                   second--;
               }
           });
       });
       //(5)启动定时器
       dispatch_resume(timer);

}

//初始化文字信息 设置颜色及点击事件
-(TYTextContainer*)creatTextContainerWithCurrentStr:(NSString*)currentStr totalStr:(NSString*)total
{
    TYTextContainer *textContainer = [[TYTextContainer alloc]init];
//    张九龄
    NSString * string = [currentStr substringFromIndex:currentStr.length];
    NSString * text = total;
    textContainer.text = text;
    
    //取出需要变色的字
    TYTextStorage *textheader = [[TYTextStorage alloc]init];
    textheader.range = [text rangeOfString:currentStr];
    textheader.textColor = [kMainSingleton colorWithHexString:@"#D0021B" alpha:1];
    textheader.font = [UIFont fontWithName:@"TamilSangamMN" size:kWidthFlot(18)];
    [textContainer addTextStorage:textheader];

    //取出剩余的字
    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
    textStorage.range = [text rangeOfString:string];
    textStorage.textColor = [UIColor blackColor];
//    TamilSangamMN-Bold
    textStorage.font = [UIFont fontWithName:@"TamilSangamMN" size:kWidthFlot(16)];
    [textContainer addTextStorage:textStorage];
    textContainer.linesSpacing = 5;
    textContainer = [textContainer createTextContainerWithTextWidth:kWidthFlot(300)];
    return textContainer;
}

-(void)updateTYTLabel:(TYAttributedLabel*)label
{
    // 水平对齐方式
    label.textAlignment = kCTTextAlignmentCenter;
    // 垂直对齐方式
    label.verticalAlignment = TYVerticalAlignmentCenter;
    // 文字间隙
    label.characterSpacing = 2;
    // 文本行间隙
    label.linesSpacing = 2;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

@end
