//
//  zChangePasswordController.m
//  ZhuangBei
//
//  Created by aa on 2020/7/23.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zChangePasswordController.h"
#import "zChangePasswordCard.h"
#import "zDengluController.h"
#import "MainNavController.h"

@interface zChangePasswordController ()

@property(strong,nonatomic)zChangePasswordCard * fogetCard;

@end

@implementation zChangePasswordController

-(zChangePasswordCard*)fogetCard
{
    if (!_fogetCard) {
        __weak typeof(self)weakSelf = self;
        _fogetCard = [[zChangePasswordCard alloc]init];
        _fogetCard.zhuceBack = ^(NSMutableDictionary * _Nonnull userDic) {
            NSLog(@"修改信息:%@",userDic);
            NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kchangePassword];
            
            [weakSelf requestPostWithUrl:kchangePassword paraString:userDic success:^(id  _Nonnull response) {
                NSDictionary * dic = response;
                NSLog(@"修改成功%@",dic);
                NSString * type = dic[@"code"];
                NSString * msg =dic[@"msg"];
                if ([type integerValue] == 0) {
                           //注册成功 进入首
                    [[zHud shareInstance]showMessage:@"修改成功"];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    [weakSelf changeRootVC];
                    return;
                }
                if ([type integerValue] == 500) {
                    //修改失败
                    [[zHud shareInstance]showMessage:msg];
                    return;
                }
            } failure:^(NSError * _Nonnull error) {
                
            }];
        };
    }
    return _fogetCard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.fogetCard];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.fogetCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}


-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:kSendVerificationCode]) {
        [[zHud shareInstance]showMessage:@"获取验证码失败"];
        return;
    }
    if ([url containsString:kchangePassword]) {
        [[zHud shareInstance]showMessage:@"修改失败，请检查网络"];
        return;
    }
}

-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:kSendVerificationCode]) {
        NSDictionary * dic = data;
        NSString * code = dic[@"code"];
        NSString * msg = dic[@"msg"];
        NSLog(@"验证码成功%@",dic);
        if ([code integerValue]==500) {
            [[zHud shareInstance]showMessage:msg];
        }else
        {
            [[zHud shareInstance]showMessage:@"获取验证码成功"];
        }
        
    }
    if ([url containsString:kchangePassword]) {
       
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
