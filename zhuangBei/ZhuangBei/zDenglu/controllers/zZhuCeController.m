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
//            [weakSelf postDataWithUrl:url WithParam:@{@"phone":phoneNum}];
            
                //初始化一个AFHTTPSessionManager
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                //设置请求体数据为json类型
                manager.requestSerializer = [AFJSONRequestSerializer serializer];
                //设置响应体数据为json类型
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                //请求体，参数（NSDictionary 类型）
                NSDictionary *parameters = @{@"phone":phoneNum};
                [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"%@",responseObject);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    
                }];
        };
        _zhuceView.zhuceBack = ^(NSMutableDictionary * _Nonnull userDic) {
            
            NSLog(@"注册信息:%@",userDic);
            NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kRegister];
            NSString * josn = [userDic jsonString];
//            [weakSelf postDataWithUrl:url WithParam:josn];
            //初始化一个AFHTTPSessionManager
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            //设置请求体数据为json类型
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            //设置响应体数据为json类型
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            //请求体，参数（NSDictionary 类型）
            NSDictionary *parameters = userDic;
            [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                
            }];

            
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
        
//        zQuestionController * quesionVC = [[zQuestionController alloc]init];
//        [self.navigationController pushViewController:quesionVC animated:YES];
        return;
    }
}


@end
