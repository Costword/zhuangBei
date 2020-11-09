//
//  zhuCeCard.m
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zhuCeCard.h"
#import "LoginTextField.h"
#import "phoneNumCheck.h"
#import "ServiceManager.h"
#import "searchCompanyCell.h"

#define  heightMargin 15
#define  leftMargin 20

#define NUM @"0123456789"
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface zhuCeCard ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)NSArray * labelTitleArray;

@property(strong,nonatomic)NSMutableArray * labelArray;

@property(strong,nonatomic)LoginTextField * nameField;
@property(strong,nonatomic)LoginTextField * accountField;
@property(strong,nonatomic)LoginTextField * passwordField;
@property(strong,nonatomic)LoginTextField * checkField;
@property(strong,nonatomic)LoginTextField * companyField;
@property(strong,nonatomic)LoginTextField * inviteField;

@property(strong,nonatomic)UILabel * nameLabel;//姓名
@property(strong,nonatomic)UILabel * passwordLabel;//密码
@property(strong,nonatomic)UILabel * yaoqingmaLabel;//邀请码

@property(strong,nonatomic)UIButton * eyesButton;
@property(strong,nonatomic)UIButton * getCheckNumButton;
@property(strong,nonatomic)UIButton * loginBtn;

@property(strong,nonatomic)UIButton * changjia;//厂家
@property(strong,nonatomic)UIButton * jixiangshang;//经销商
@property(strong,nonatomic)UIButton * zongdaili;//总代理
@property(strong,nonatomic)UIButton * currentSelectBtn;//判空使用无其他意义

@property(nonatomic,strong)UIVisualEffectView  * blurEffectView;//毛玻璃效果遮盖

@property(strong,nonatomic)UILabel * changjiaTypeDesc;//用户须知

@property(strong,nonatomic)UIButton * aggreBtn;//同意
@property(strong,nonatomic)UILabel * userKnow;//用户须知

@property(strong,nonatomic)TYAttributedLabel*gotoLoginLabel;

@property(strong,nonatomic)NSMutableDictionary * userDic;

@property(strong,nonatomic)UITableView * companyTableView;

@property(strong,nonatomic)NSArray * companyArray;

@end

@implementation zhuCeCard

-(NSArray *)companyArray
{
    if (!_companyArray) {
        _companyArray = [NSArray array];
    }
    return _companyArray;
}


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
        _labelTitleArray = @[@"手机号：",@"验证码：",@"公司名称："];
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
        _nameField.keyboardType = UIKeyboardTypeDefault;
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

-(LoginTextField*)passwordField
{
    if (!_passwordField) {
        _passwordField = [[LoginTextField alloc]init];
        _passwordField.delegate = self;
        _passwordField.icon = [UIImage imageNamed:@"blank"];
        _passwordField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordField.maxLength = 12;
        [_passwordField setSecureTextEntry:YES];
        _passwordField.myPlaceHolder = @"请输入密码";
    }
    return _passwordField;
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


-(LoginTextField*)companyField
{
    if (!_companyField) {
        _companyField = [[LoginTextField alloc]init];
        _companyField.icon = [UIImage imageNamed:@"blank"];
        _companyField.keyboardType = UIKeyboardTypeDefault;
        _companyField.myPlaceHolder = @"请输入所属公司";
        @weakify(self);
        [[RACSignal merge:@[self.companyField.rac_textSignal, RACObserve(self.companyField, text)]] subscribeNext:^(NSString* text){
            @strongify(self);
            [self loadCompanySearchWithStr:text];
        }];
        
        
//        [RACObserve(self.companyField, isEditing) subscribeNext:^(id x) {
//            @strongify(self);
//            if ([x boolValue]) {
//                NSLog(@"停止编辑");
//            }
//        }];
    }
    return _companyField;
}
-(LoginTextField*)inviteField
{
    if (!_inviteField) {
        _inviteField = [[LoginTextField alloc]init];
        _inviteField.icon = [UIImage imageNamed:@"blank"];
        _inviteField.keyboardType = UIKeyboardTypeASCIICapable;
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
        _getCheckNumButton.tag = 2;
        [_getCheckNumButton setTitle:@"获取" forState:UIControlStateNormal];
        [_getCheckNumButton setBackgroundColor:[kMainSingleton colorWithHexString:@"#3F50B5" alpha:1]];
        [_getCheckNumButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getCheckNumButton;
}

-(UIButton*)aggreBtn
{
    if (!_aggreBtn) {
        _aggreBtn = [[UIButton alloc]init];
        _aggreBtn.titleLabel.font = kFont(14);
        [_aggreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_aggreBtn setImage:[UIImage imageNamed:@"chose_normal"] forState:UIControlStateNormal];
        [_aggreBtn setImage:[UIImage imageNamed:@"chose_select"] forState:UIControlStateSelected];
        _aggreBtn.tag = 3;
        [_aggreBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aggreBtn;
}

-(UIButton*)changjia
{
    if (!_changjia) {
        _changjia = [[UIButton alloc]init];
        _changjia.titleLabel.font = kFont(14);
        [_changjia setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_changjia setImage:[UIImage imageNamed:@"zb_unselect"] forState:UIControlStateNormal];
        [_changjia setImage:[UIImage imageNamed:@"zb_select"] forState:UIControlStateSelected];
        _changjia.tag = 5;
        [_changjia setTitle:@"生产厂家" forState:UIControlStateNormal];
        [_changjia addTarget:self action:@selector(choseType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changjia;
}

-(UIButton*)jixiangshang
{
    if (!_jixiangshang) {
        _jixiangshang = [[UIButton alloc]init];
        _jixiangshang.titleLabel.font = kFont(14);
        [_jixiangshang setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_jixiangshang setImage:[UIImage imageNamed:@"zb_unselect"] forState:UIControlStateNormal];
        [_jixiangshang setImage:[UIImage imageNamed:@"zb_select"] forState:UIControlStateSelected];
        _jixiangshang.tag = 6;
        [_jixiangshang setTitle:@"渠道经销商" forState:UIControlStateNormal];
        [_jixiangshang addTarget:self action:@selector(choseType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jixiangshang;
}

-(UIButton*)zongdaili
{
    if (!_zongdaili) {
        _zongdaili = [[UIButton alloc]init];
        _zongdaili.titleLabel.font = kFont(14);
        [_zongdaili setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_zongdaili setImage:[UIImage imageNamed:@"zb_unselect"] forState:UIControlStateNormal];
        [_zongdaili setImage:[UIImage imageNamed:@"zb_select"] forState:UIControlStateSelected];
        _zongdaili.tag = 7;
        [_zongdaili setTitle:@"全国总代理" forState:UIControlStateNormal];
        [_zongdaili addTarget:self action:@selector(choseType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zongdaili;
}

-(UIVisualEffectView *)blurEffectView
{
    if (!_blurEffectView) {
        UIBlurEffect  * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _blurEffectView =[[UIVisualEffectView alloc]initWithEffect:blurEffect];
    }
    return  _blurEffectView;
}

-(UILabel *)changjiaTypeDesc
{
    if (!_changjiaTypeDesc) {
        _changjiaTypeDesc = [[UILabel alloc]init];
        _changjiaTypeDesc.font = [UIFont systemFontOfSize:kWidthFlot(12)];
        _changjiaTypeDesc.textColor = [UIColor blackColor];
        _changjiaTypeDesc.text = @"说明：\n 1.生产厂家：可上传货源，平台将予以真实性考核；同时可按省份收藏经销商的权限；\n2.全国总代理：具有上传货源的权限，需提供授权函原件备查；同时可按省份收藏经销商的权限；3.经销商：没有上传货源的权限，有按类收藏货源的权限；\n进入平台后如有更改，可在 （企业大厅-企业认证）模块进行更改";
        _changjiaTypeDesc.numberOfLines = 0;
    }
    return _changjiaTypeDesc;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = kFont(18);
        _nameLabel.text = @"姓名：";
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

-(UILabel *)passwordLabel
{
    if (!_passwordLabel) {
        _passwordLabel = [[UILabel alloc]init];
        _passwordLabel.textColor = [UIColor blackColor];
        _passwordLabel.font = kFont(18);
        _passwordLabel.text = @"密码：";
        _passwordLabel.numberOfLines = 0;
    }
    return _passwordLabel;
}

-(UILabel *)yaoqingmaLabel
{
    if (!_yaoqingmaLabel) {
        _yaoqingmaLabel = [[UILabel alloc]init];
        _yaoqingmaLabel.textColor = [UIColor blackColor];
        _yaoqingmaLabel.font = kFont(18);
        _yaoqingmaLabel.text = @"邀请码：";
        _yaoqingmaLabel.numberOfLines = 0;
    }
    return _yaoqingmaLabel;
}

-(UIButton*)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        _loginBtn.titleLabel.font = kFont(20);
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        _loginBtn.layer.cornerRadius = 20;
        _loginBtn.clipsToBounds = YES;
        _loginBtn.tag = 4;
        [_loginBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}


-(UILabel*)userKnow
{
    if (!_userKnow) {
        _userKnow = [[UILabel alloc]initWithFrame:CGRectMake(0,0,kWidthFlot(100),kWidthFlot(40))];
        _userKnow.userInteractionEnabled = YES;
        _userKnow.font = kFont(12);
        NSString * labelStr = @"我同意《用户注册协议》";
        NSString * book = @"《用户注册协议》";
//        CGAffineTransform matrix =CGAffineTransformMake(1, 0, tanf(10 * (CGFloat)M_PI / 180), 1, 0, 0);//设置反射。倾斜角度。
//
//        UIFontDescriptor *desc = [ UIFontDescriptor fontDescriptorWithName :[UIFont systemFontOfSize:kWidthFlot(16)].fontName matrix :matrix];//取得系统字符并设置反射。
        
        NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc]initWithString:labelStr];
        //目的是想改变 ‘/’前面的字体的属性，所以找到目标的range
        NSRange range = [labelStr rangeOfString:@"《"];
        NSRange pointRange = NSMakeRange(range.location,book.length);
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[NSFontAttributeName] = kFont(12);
        dic[NSForegroundColorAttributeName] = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        //赋值
        [attribut addAttributes:dic range:pointRange];
        
        _userKnow.attributedText = attribut;
        _userKnow.numberOfLines = 0;
        
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
        [_userKnow addGestureRecognizer:labelTapGestureRecognizer];
    }
    return _userKnow;
}

-(TYAttributedLabel*)gotoLoginLabel
{
    if (!_gotoLoginLabel) {
        _gotoLoginLabel = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,kWidthFlot(40))];
        _gotoLoginLabel.userInteractionEnabled = YES;
        _gotoLoginLabel.backgroundColor = [UIColor clearColor];
        _gotoLoginLabel.numberOfLines = 1;
        NSString * labelStr = @"已有账号！立即去登录";
        NSString * num = @"去登录";
         TYTextContainer *textStorage = [self creatTextContainerWithCurrentStr:num totalStr:labelStr];
        _gotoLoginLabel.textContainer = textStorage;
        [self updateTYTLabel:_gotoLoginLabel];
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goLoginVC)];
        [_gotoLoginLabel addGestureRecognizer:labelTapGestureRecognizer];
    }
    return _gotoLoginLabel;
}

-(UITableView *)companyTableView
{
    if (!_companyTableView) {
        _companyTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _companyTableView.backgroundColor = [UIColor whiteColor];
        _companyTableView.alpha = 0;
        _companyTableView.delegate = self;
        _companyTableView.dataSource = self;
        _companyTableView.estimatedRowHeight = 100;
        _companyTableView.showsVerticalScrollIndicator = NO;
        _companyTableView.rowHeight = UITableViewAutomaticDimension;
        _companyTableView.sectionHeaderHeight =UITableViewAutomaticDimension;
        _companyTableView.estimatedSectionHeaderHeight = 2;
        _companyTableView.estimatedSectionFooterHeight = 2;
        _companyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _companyTableView;
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide)name:UIKeyboardWillHideNotification object:nil];
        
        [self addSubview:self.accountField];
        [self addSubview:self.inviteField];
        [self addSubview:self.companyField];
        
        [self addSubview:self.changjia];
        [self addSubview:self.jixiangshang];
        [self addSubview:self.zongdaili];
        [self addSubview:self.blurEffectView];
        [self addSubview:self.changjiaTypeDesc];
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.passwordLabel];
        [self addSubview:self.yaoqingmaLabel];
        [self addSubview:self.nameField];
        [self addSubview:self.passwordField];
        [self addSubview:self.checkField];
        [self addSubview:self.eyesButton];
        [self addSubview:self.getCheckNumButton];
        
        [self addSubview:self.aggreBtn];
        [self addSubview:self.userKnow];
        
        [self addSubview:self.loginBtn];
        [self addSubview:self.gotoLoginLabel];
        [self addSubview:self.companyTableView];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    
    CGFloat rowHeight = 30;
    for (int i = 0; i<self.labelArray.count; i++) {
        UILabel * nameLabel = self.labelArray[i];
        
        CGFloat top = leftMargin + (heightMargin + rowHeight)* i;
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(top);
            make.left.mas_equalTo(leftMargin);
            make.height.mas_equalTo(rowHeight);
        }];
    }
    
    CGFloat left = 80;
    //手机号
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + (heightMargin + rowHeight) * 0);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(rowHeight);
    }];
    //验证码
    [self.checkField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + (heightMargin + rowHeight) * 1);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-(leftMargin + 80));
        make.height.mas_equalTo(rowHeight);
    }];
    
    [self.getCheckNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.checkField.mas_bottom);
        make.right.mas_equalTo(-leftMargin);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    //公司名称
    [self.companyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftMargin + (heightMargin + rowHeight) * 2);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(rowHeight);
    }];
    [self.changjia mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.companyField.mas_bottom).offset(heightMargin);
        make.left.mas_equalTo(left);
        make.width.mas_equalTo((SCREEN_WIDTH-left-leftMargin)/3);
        make.height.mas_equalTo(rowHeight);
    }];
    [self.jixiangshang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.companyField.mas_bottom).offset(heightMargin);
        make.left.mas_equalTo(self.changjia.mas_right);
        make.width.mas_equalTo((SCREEN_WIDTH-left-leftMargin)/3);
        make.height.mas_equalTo(rowHeight);
    }];
    [self.zongdaili mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.companyField.mas_bottom).offset(heightMargin);
        make.left.mas_equalTo(self.jixiangshang.mas_right);
        make.width.mas_equalTo((SCREEN_WIDTH-left-leftMargin)/3);
        make.height.mas_equalTo(rowHeight);
    }];
        
    //厂家描述
    [self.changjiaTypeDesc  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.changjia.mas_bottom).offset(10);
        make.left.mas_equalTo(leftMargin);
        make.right.mas_equalTo(-leftMargin);
        
    }];
    
    [self.blurEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.changjia.mas_bottom).offset(5);
        make.left.mas_equalTo(leftMargin-5);
        make.right.mas_equalTo(-leftMargin+5);
        make.bottom.mas_equalTo(self.changjiaTypeDesc.mas_bottom).offset(5);
    }];

    
    //姓名
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.changjiaTypeDesc.mas_bottom).offset(heightMargin);
        make.left.mas_equalTo(leftMargin);
        make.width.mas_equalTo(left);
        make.height.mas_equalTo(rowHeight);
    }];
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(rowHeight);
    }];
    //密码
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(heightMargin);
        make.left.mas_equalTo(leftMargin);
        make.width.mas_equalTo(left);
        make.height.mas_equalTo(rowHeight);
    }];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordLabel.mas_top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-(leftMargin + 40));
        make.height.mas_equalTo(rowHeight);
    }];
    
    [self.eyesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.passwordField.mas_centerY);
        make.right.mas_equalTo(-leftMargin);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
    }];
    //邀请码
   
    [self.yaoqingmaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordLabel.mas_bottom).offset(heightMargin);
        make.left.mas_equalTo(leftMargin);
        make.width.mas_equalTo(left);
        make.height.mas_equalTo(rowHeight);
    }];
    
    [self.inviteField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yaoqingmaLabel.mas_top);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(rowHeight);
    }];
    
    [self.userKnow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yaoqingmaLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(kWidthFlot(30));
    }];
    [self.aggreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userKnow.mas_top);
        make.right.mas_equalTo(self.userKnow.mas_left).offset(-1);
        make.height.mas_equalTo(kWidthFlot(30));
        make.width.mas_equalTo(kWidthFlot(30));
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.aggreBtn.mas_bottom).offset(kWidthFlot(10));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(kWidthFlot(285));
        make.height.mas_equalTo(45);
    }];
    [self.gotoLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kWidthFlot(20));
        make.left.mas_equalTo(kWidthFlot(0));
        make.right.mas_equalTo(-kWidthFlot(0));
        make.height.mas_equalTo(kWidthFlot(rowHeight));
    }];
    
    [self.companyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.companyField.mas_bottom).offset(0);
        make.left.mas_equalTo(left);
        make.right.mas_equalTo(-leftMargin);
        make.height.mas_equalTo(kWidthFlot(200));
    }];
}

-(void)loadCompanySearchWithStr:(NSString*)str
{
    if (str.length >0) {
            //获取是否有高亮
            UITextRange *selectedRange = [self.companyField markedTextRange];
            if (!selectedRange) {
                
                
                if (self.companyField.isEditing) {
//                    NSLog(@"调用接口");
                    NSDictionary * dic = @{@"name":str};
                    
                    [ServiceManager requestGetWithUrl:zFindNameListByName Parameters:dic success:^(id  _Nonnull response) {
                        NSArray * companyArr = response[@"data"];
                        self.companyArray = companyArr;
                        if (companyArr.count==0) {
                            self.companyTableView.alpha = 0;
                            return;
                        }
                        self.companyTableView.alpha = 1;
                        [self.companyTableView reloadData];
                        
                    } failure:^(NSError * _Nonnull error) {
                        
                        NSLog(@"error%ld",error.code);
                    }];
                }else
                {
                    
                }
            }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.companyArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchCompanyCell * cell = [searchCompanyCell creatTableViewCellWithTableView:tableView AndIndexPath:indexPath];
    cell.sourceDic = self.companyArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * sourceDic = self.companyArray[indexPath.row];
    [self.companyField resignFirstResponder];
    self.companyField.text = sourceDic[@"name"];
    self.companyTableView.alpha = 0;
    
}

-(void)buttonClick:(UIButton*)button
{
    if (button.tag == 1) {
        //眼睛
        self.eyesButton.selected = !button.selected;
        [self.passwordField setSecureTextEntry:!self.eyesButton.selected];
        return;
    }
    if (button.tag == 2) {
        //验证码
        BOOL rightNum = [phoneNumCheck validateMobile:self.accountField.text];
        if (rightNum) {
            if (self.getMessageCodeTapBack) {
                self.getMessageCodeTapBack(self.accountField.text);
            }
            [self daojishi];
        }else
        {
            [[zHud shareInstance]showMessage:@"请输入正确的手机号"];
        }
        return;
    }
    if (button.tag == 3) {
        self.aggreBtn.selected = !button.selected;
        return;
    }
    if (button.tag == 4) {
        //注册
        if (self.nameField.text.length==0) {
            [[zHud shareInstance]showMessage:@"姓名不可为空"];
            return;
        }
        if (self.accountField.text.length==0) {
            [[zHud shareInstance]showMessage:@"手机号不可为空"];
            return;
        }
        if (self.passwordField.text.length<6) {
            [[zHud shareInstance]showMessage:@"请输入至少6位数密码"];
            return;
        }
        if (self.checkField.text.length==0) {
            [[zHud shareInstance]showMessage:@"验证码不可为空"];
            return;
        }
        if (self.companyField.text.length==0) {
            [[zHud shareInstance]showMessage:@"公司名称不可为空"];
            return;
        }
        if (self.currentSelectBtn == nil) {
            [[zHud shareInstance]showMessage:@"请选择公司类型"];
            return;
        }
        NSString * password = self.passwordField.text;
        [self.userDic setObject:self.nameField.text forKey:@"nickName"];
        [self.userDic setObject:self.accountField.text forKey:@"username"];
        [self.userDic setObject:password forKey:@"password"];
        [self.userDic setObject:self.checkField.text forKey:@"verificationCode"];
        [self.userDic setObject:self.inviteField.text forKey:@"invatationCode"];
        [self.userDic setObject:self.companyField.text forKey:@"companyName"];
        
        if (self.aggreBtn.selected) {
            if (self.zhuceBack) {
                self.zhuceBack(self.userDic);
            }
        }else
        {
            [[zHud shareInstance]showMessage:@"需同意用户注册协议"];
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


-(void)labelClick
{
    if (self.xieyiBack) {
        self.xieyiBack(1);
    }
}

-(void)goLoginVC
{
    if (self.backLogin) {
        self.backLogin();
    }
}

-(void)choseType:(UIButton*)button
{
    self.currentSelectBtn = button;
    if (button.selected == NO) {
        button.selected = !button.selected;
    }
    if ([button isEqual:self.changjia]) {
        self.jixiangshang.selected = NO;
        self.zongdaili.selected = NO;
        [self.userDic setObject:@(0) forKey:@"companyType"];
    }
    
    if ([button isEqual:self.jixiangshang]) {
        self.changjia.selected = NO;
        self.zongdaili.selected = NO;
        [self.userDic setObject:@(1) forKey:@"companyType"];
    }
    
    if ([button isEqual:self.zongdaili]) {
        self.changjia.selected = NO;
        self.jixiangshang.selected = NO;
        [self.userDic setObject:@(2) forKey:@"companyType"];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

-(void)keyboardWillHide
{
    self.companyTableView.alpha = 0;
}

@end
