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
#import <AFNetworking.h>

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
            [weakSelf postDataWithUrl:url WithParam:@{@"phone":phoneNum}];
        };
        _zhuceView.zhuceBack = ^(NSMutableDictionary * _Nonnull userDic) {
            NSLog(@"注册信息:%@",userDic);
            NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kRegister];
//            NSString * josn = [userDic jsonString];
            [weakSelf postDataWithUrl:url WithParam:userDic];
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
        NSString * type = dic[@"type"];
        if ([type integerValue] == 0) {
            //注册成功 进入首页
            [[zHud shareInstance]showMessage:@"注册成功"];
            return;
        }
        if ([type integerValue] == 1) {
            //注册失败
            return;
        }
        if ([type integerValue] == 2) {
            //需要答题
            [LEEAlert actionsheet].config
            .LeeTitle(@"温馨提示")
            .LeeContent(@"您没有邀请码\n即将进入答题环节")
            .LeeAction(@"确认", ^{
                
                // 点击事件Block
            })
            .LeeCancelAction(@"取消", ^{
                
                // 点击事件Block
            })
            .LeeShow();
            return;
        }
        if ([type integerValue] == 3) {
            //需要确定邀请人是否为xxx
            return;
        }
        
        
//        zQuestionController * quesionVC = [[zQuestionController alloc]init];
//        [self.navigationController pushViewController:quesionVC animated:YES];
        return;
    }
}


@end
