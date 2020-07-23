//
//  zFogetController.m
//  ZhuangBei
//
//  Created by aa on 2020/7/23.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zFogetController.h"
#import "zFogetCard.h"
@interface zFogetController ()

@property(strong,nonatomic)zFogetCard * fogetCard;

@end

@implementation zFogetController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"修改密码";
}

-(zFogetCard*)fogetCard
{
    if (!_fogetCard) {
        __weak typeof(self)weakSelf = self;
        _fogetCard = [[zFogetCard alloc]init];
        _fogetCard.getMessageCodeTapBack = ^(NSString * _Nonnull phoneNum) {
            NSString *url = [NSString stringWithFormat:@"%@%@?phone=%@",kApiPrefix,kSendVerificationCode,phoneNum];
//            @{@"phone":phoneNum}
            [weakSelf postDataWithUrl:url WithParam:nil];
        };
        _fogetCard.zhuceBack = ^(NSMutableDictionary * _Nonnull userDic) {
            NSLog(@"修改信息:%@",userDic);
//            weakSelf.userDic = userDic;
            NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kfogetPassword];
            [weakSelf postDataWithUrl:url WithParam:userDic];
        };
//        _zhuceView.backLogin = ^{
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//        };
        
//        _zhuceView.xieyiBack = ^(NSInteger type) {
//            zXieYiController * xyVC = [[zXieYiController alloc]init];
//            xyVC.type = type;
//            xyVC.title = @"注册协议";
//            [weakSelf.navigationController pushViewController:xyVC animated:YES];
//        };
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
    if ([url containsString:kfogetPassword]) {
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
    if ([url containsString:kfogetPassword]) {
        NSDictionary * dic = data;
        NSLog(@"注册成功%@",dic);
        NSString * type = dic[@"data"][@"type"];
        NSString * msg =dic[@"msg"];
        if ([type integerValue] == 0) {
            //注册成功 进入首页
            [[zHud shareInstance]showMessage:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        if ([type integerValue] == 1) {
            //注册失败
            [[zHud shareInstance]showMessage:msg];
            return;
        }
    }
}

@end
