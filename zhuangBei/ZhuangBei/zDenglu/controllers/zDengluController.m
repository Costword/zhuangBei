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
            
            if (btnTag == 3) {
                //登陆成功进入答题页面
                zQuestionController * zQueVC = [[zQuestionController alloc]init];
                zQueVC.title = @"检测";
                [weakSelf.navigationController pushViewController:zQueVC animated:YES];
                return;
            }
            
            if (btnTag ==4) {
                //忘记密码
                zZhaoHuiController * zhaoHuiVC = [[zZhaoHuiController alloc]init];
                zhaoHuiVC.title = @"找回密码";
                [weakSelf.navigationController pushViewController:zhaoHuiVC animated:YES];
                return;
            }
            if (btnTag ==5) {
                //注册
                zZhuCeController * zhuceVC = [[zZhuCeController alloc]init];
                zhuceVC.title = @"用户注册";
                [weakSelf.navigationController pushViewController:zhuceVC animated:YES];
                return;
            }
        };
    }
    return _loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.loginView];
    
    
//    [zDengluRequst getLoginWithParameters:@{} success:^(id  _Nonnull response) {
//        
//    } failure:^(NSError * _Nonnull error) {
//        
//    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


@end
