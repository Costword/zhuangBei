//
//  ServiceManager.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/6.
//  Copyright © 2020 aa. All rights reserved.
//

#import "ServiceManager.h"
#import "zInterfacedConst.h"
#import "PPNetworkHelper.h"

@implementation ServiceManager

+ (NSURLSessionTask *)requestPostWithUrl:(NSString *)url Parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure{
    NSString *urlstring = [NSString stringWithFormat:@"%@%@",kApiPrefix,url];
    return [self requestWithURL:urlstring parameters:parameters success:success failure:failure];
}


/*
 配置好PPNetworkHelper各项请求参数,封装成一个公共方法,给以上方法调用,
 相比在项目中单个分散的使用PPNetworkHelper/其他网络框架请求,可大大降低耦合度,方便维护
 在项目的后期, 你可以在公共请求方法内任意更换其他的网络请求工具,切换成本小
 */

#pragma mark - 请求的公共方法

+ (NSURLSessionTask *)requestWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(RequestSuccess)success failure:(RequestFailure)failure
{
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    // 设置请求头
    [PPNetworkHelper setValue:@"9" forHTTPHeaderField:@"fromType"];
 
    // 发起请求
    return [PPNetworkHelper POST:URL parameters:parameter success:^(id responseObject) {
    
        NSLog(@"请求中");
        // 在这里你可以根据项目自定义其他一些重复操作,比如加载页面时候的等待效果, 提醒弹窗....
        success(responseObject);
        LWLog(@"\n*********urlstring:%@***********parameters：%@**********responseObject:%@",URL,parameter,responseObject);
    } failure:^(NSError *error) {
        // 同上
        failure(error);
        [[zHud shareInstance] showMessage:@"网络请求失败，稍后重试"];
        LWLog(@"\n*********urlstring:%@***********parameters：%@**********error:%@",URL,parameter,error);
    }];
}

@end
