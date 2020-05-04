//
//  zShouyeController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zShouyeController.h"
#import "zDengluRequst.h"
#import "zInterfacedConst.h"
#import "zDengluController.h"
#import "zQuestionController.h"
#import "zZhuCeController.h"
#import "zUserModel.h"

@interface zShouyeController ()

@property(strong,nonatomic)UIButton * button;

@end

@implementation zShouyeController


-(UIButton*)button
{
    if (!_button) {
        _button = [[UIButton alloc]init];
        _button.titleLabel.font = kFont(16);
        [_button setBackgroundColor:[UIColor blackColor]];
        [_button setTitle:@"个人信息" forState:UIControlStateNormal];
        [_button setTitleColor: [kMainSingleton colorWithHexString:@"#FFFFFF" alpha:1] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(gotoLogInVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.button];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(100), kWidthFlot(30)));
    }];
}


-(void)gotoLogInVC
{
    zUserModel * model = [zUserInfo shareInstance].userInfo;
    NSDictionary * userInfo = [model mj_keyValues];
    
    NSString * userInfojson = [userInfo jsonString];
    
    NSString * content = [NSString stringWithFormat:@"您的信息\n%@",userInfojson];
    [LEEAlert alert].config
    .LeeTitle(@"温馨提示")
    .LeeContent(content)
    .LeeCancelAction(@"取消", ^{
        // 点击事件Block
    })
    .LeeAction(@"确认", ^{
        // 点击事件Block
    })
    .LeeShow();
    
//    zDengluController * dlVC = [[zDengluController alloc]init];
//    dlVC.title = @"登陆";
//    [self.navigationController pushViewController:dlVC animated:YES];
}

@end
