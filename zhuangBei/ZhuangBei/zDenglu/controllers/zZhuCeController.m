//
//  zZhuCeController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zZhuCeController.h"
#import "zhuCeCard.h"
#import "zQuestionController.h"

@interface zZhuCeController ()

@property(strong,nonatomic)zhuCeCard * zhuceView;

@end

@implementation zZhuCeController


-(zhuCeCard*)zhuceView
{
    if (!_zhuceView) {
        __weak typeof(self)weakSelf = self;
        _zhuceView = [[zhuCeCard alloc]init];
        _zhuceView.getMessageCodeTapBack = ^(NSString * _Nonnull phoneNum) {
            NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kSendVerificationCode];
            [weakSelf getData:NO url:url withParam:@{@"phone":phoneNum}];
        };
        _zhuceView.zhuceBack = ^(NSMutableDictionary * _Nonnull userDic) {
            
            NSLog(@"注册信息:%@",userDic);
            NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kRegister];
            [weakSelf getData:NO url:url withParam:userDic];
            
        };
        _zhuceView.backLogin = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _zhuceView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self.view addSubview:self.zhuceView];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.zhuceView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    if ([url containsString:kRegister]) {
        [[zHud shareInstance]showMessage:@"注册失败"];
        return;
    }
    
}

-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:kSendVerificationCode]) {
        NSDictionary * dic = data;
        NSLog(@"验证码成功%@",dic);
        [[zHud shareInstance]showMessage:@"获取验证码成功"];
    }
    if ([url containsString:kRegister]) {
        NSDictionary * dic = data;
        NSLog(@"注册成功%@",dic);
        [[zHud shareInstance]showMessage:@"注册成功"];
        
        zQuestionController * quesionVC = [[zQuestionController alloc]init];
        [self.navigationController pushViewController:quesionVC animated:YES];
        return;
    }
}


@end
