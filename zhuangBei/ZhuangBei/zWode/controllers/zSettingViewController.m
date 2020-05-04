//
//  zSettingViewController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/1.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zSettingViewController.h"
#import "zSettingCellView.h"
#import "zDengluController.h"
#import "MainNavController.h"

@interface zSettingViewController ()

@property(strong,nonatomic)zSettingCellView * AccountCell;

@property(strong,nonatomic)zSettingCellView * clearnCell;

@property(strong,nonatomic)zSettingCellView * versionCell;

@property(strong,nonatomic)UIButton * loginBtn;

@property(strong,nonatomic)UIButton * fuwuButton;

@property(strong,nonatomic)UIView * centerView;

@property(strong,nonatomic)UIButton * yinsiButton;

@property(strong,nonatomic)UILabel* titleLabel;


@end

@implementation zSettingViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(zSettingCellView*)AccountCell
{
    if (!_AccountCell) {
        _AccountCell = [[zSettingCellView alloc]init];
        _AccountCell.name = @"登录账号";
        _AccountCell.content = [zUserInfo shareInstance].userAccount;
        _AccountCell.isPhoneNum = YES;
    }
    return _AccountCell;
}

-(zSettingCellView*)clearnCell
{
    if (!_clearnCell) {
        _clearnCell = [[zSettingCellView alloc]init];
        _clearnCell.name = @"清除缓存";
        NSString * huancun = @"12.5MB";
        _clearnCell.content = huancun;
        _clearnCell.settingBack = ^{
          
            [LEEAlert alert].config
            .LeeTitle(@"温馨提示")
            .LeeContent(@"当前缓存约有：12.5MB\n离线缓存可以帮你在没有网络的情况下也能进行浏览.")
            .LeeCancelAction(@"取消", ^{
                
            })
            .LeeAction(@"确定", ^{
                
            })
            .LeeShow();
            ;
        };
    }
    return _clearnCell;
}

-(zSettingCellView*)versionCell
{
    if (!_versionCell) {
        _versionCell = [[zSettingCellView alloc]init];
        _versionCell.name = @"当前版本";
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        _versionCell.content = [NSString stringWithFormat:@"V%@",app_Version];
    }
    return _versionCell;
}

-(UIButton*)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        _loginBtn.titleLabel.font = kFont(20);
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        _loginBtn.layer.cornerRadius = kWidthFlot(20);
        _loginBtn.clipsToBounds = YES;
        _loginBtn.tag = 1;
        [_loginBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
-(UIButton*)fuwuButton
{
    if (!_fuwuButton) {
        _fuwuButton = [[UIButton alloc]init];
        _fuwuButton.titleLabel.font = kFont(14);
        [_fuwuButton setTitleColor:[UIColor colorWithHexString:@"#3F50B5"] forState:UIControlStateNormal];
        [_fuwuButton setTitle:@"《服务协议》" forState:UIControlStateNormal];
        _fuwuButton.clipsToBounds = YES;
        _fuwuButton.tag = 2;
        [_fuwuButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fuwuButton;
}
-(UIButton*)yinsiButton
{
    if (!_yinsiButton) {
        _yinsiButton = [[UIButton alloc]init];
        _yinsiButton.titleLabel.font = kFont(14);
        [_yinsiButton setTitleColor:[UIColor colorWithHexString:@"#3F50B5"] forState:UIControlStateNormal];
        [_yinsiButton setTitle:@"《隐私政策》" forState:UIControlStateNormal];
        _yinsiButton.clipsToBounds = YES;
        _yinsiButton.tag = 3;
        [_yinsiButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yinsiButton;
}

-(UIView*)centerView
{
    if (!_centerView) {
        _centerView = [[UIView alloc]init];
        _centerView.backgroundColor = [UIColor colorWithHexString:@"#3F50B5"];
    }
    return _centerView;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = kFont(12);
        _titleLabel.textColor = [kMainSingleton colorWithHexString:@"#9B9B9B" alpha:1];
        _titleLabel.text = @"Copyright @2015-2020.All Rights Reserved";
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.AccountCell];
    [self.view addSubview:self.clearnCell];
    [self.view addSubview:self.versionCell];
    [self.view addSubview:self.loginBtn];
    
    [self.view addSubview:self.fuwuButton];
    [self.view addSubview:self.centerView];
    [self.view addSubview:self.yinsiButton];
    
    [self.view addSubview:self.titleLabel];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.AccountCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(kWidthFlot(1));
        make.height.mas_equalTo(kWidthFlot(50));
    }];
    
    [self.clearnCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.AccountCell.mas_bottom).offset(kWidthFlot(1));
        make.height.mas_equalTo(kWidthFlot(50));
    }];
    
    [self.versionCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.clearnCell.mas_bottom).offset(kWidthFlot(1));
        make.height.mas_equalTo(kWidthFlot(50));
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.versionCell.mas_bottom).offset(kWidthFlot(20));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(298), kWidthFlot(46)));
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(kWidthFlot(20));
        make.bottom.mas_equalTo(-kWidthFlot(54));
    }];
    [self.fuwuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kWidthFlot(55));
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(100),kWidthFlot(20)));
        make.right.mas_equalTo(self.centerView.mas_left).offset(-kWidthFlot(15));
    }];
    
    [self.yinsiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kWidthFlot(55));
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(100),kWidthFlot(20)));
        make.left.mas_equalTo(self.centerView.mas_right).offset(kWidthFlot(15));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(kWidthFlot(20));
        make.bottom.mas_equalTo(-kWidthFlot(30));
    }];
}

-(void)buttonClick:(UIButton*)button
{
    //退出登录
    if (button.tag==1) {
        [[zHud shareInstance]showMessage:@"退出登录"];
        [[zUserInfo shareInstance]deleate];
        [self changeRootVC];
    }
    
    if (button.tag ==2) {
        [[zHud shareInstance]showMessage:@"服务协议"];
    }
    
    if (button.tag==3) {
        [[zHud shareInstance]showMessage:@"隐私政策"];
    }
}

-(void)changeRootVC
{
    zDengluController * rootVC  = [[zDengluController alloc]init];
    MainNavController * rootNav = [[MainNavController alloc]initWithRootViewController:rootVC];
    rootNav.navigationBar.hidden = YES;
     UIApplication *app = [UIApplication sharedApplication];
    [app keyWindow].rootViewController = rootNav;
}

@end
