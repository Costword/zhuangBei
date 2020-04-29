//
//  zDengluController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zDengluController.h"
#import "zLoginCard.h"
#import "zZhuCeController.h"
#import "zZhaoHuiController.h"
#import "zQuestionController.h"
#import "zUserInfo.h"
@interface zDengluController ()

@property(strong,nonatomic)zLoginCard * loginView;

@end

@implementation zDengluController

-(zLoginCard*)loginView
{
    if (!_loginView) {
        __weak typeof(self)weakSelf = self;
        _loginView = [[zLoginCard alloc]init];
        _loginView.eventBack = ^(NSInteger btnTag) {
            if (btnTag ==5) {
                //注册
                zZhuCeController * zhuceVC = [[zZhuCeController alloc]init];
                zhuceVC.title = @"用户注册";
                [weakSelf.navigationController pushViewController:zhuceVC animated:YES];
                return;
            }
        };
        _loginView.logInBack = ^(NSString * _Nonnull phone, NSString * _Nonnull passWord, BOOL remmber) {
            if (remmber) {
                //是否记住密码
                [zUserInfo shareInstance].userAccount = phone;
                [zUserInfo shareInstance].userPassWord = passWord;
                [[zUserInfo shareInstance]saveUserInfo];
            }else
            {
                [[zUserInfo shareInstance]deleate];
            }
          //登陆
            NSDictionary * loginParam =@{@"username":phone,@"password":passWord};
            NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kLogin];
            [weakSelf postDataWithUrl:url WithParam:loginParam];
        };
    }
    return _loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.loginView];
    
   
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:kLogin]) {
        [[zHud shareInstance]showMessage:@"登陆失败"];
    }
}

-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:kLogin]) {
        NSDictionary * dic = data;
        NSLog(@"登陆成功:%@",dic);
        [[zHud shareInstance]showMessage:@"登陆成功"];
    }
}


@end
