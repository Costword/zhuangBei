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
#import "zNetWorkManger.h"
@implementation ServiceManager

+ (void)requestPostWithUrl:(NSString *)url Parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure{
    NSString *urlstring = [NSString stringWithFormat:@"%@%@",kApiPrefix,url];
//    [self requestWithURL:urlstring parameters:parameters success:success failure:failure];
    [zNetWorkManger POSTworkWithUrl:urlstring WithParamer:parameters Success:success Failure:failure];
}


/// 网络请求 内部拼接参数
/// @param url 地址
/// @param paraString 参数字典，内部转拼接参数
/// @param success 成功
/// @param failure 失败
+ (void)requestPostWithUrl:(NSString *)url paraString:(id)paraString success:(RequestSuccess)success failure:(RequestFailure)failure{
    
    NSString *urlstring = [NSString stringWithFormat:@"%@%@",kApiPrefix,url];
    if ([paraString isKindOfClass:[NSDictionary class]]) {
        NSArray *keys = ((NSDictionary *)paraString).allKeys;
        NSMutableString *tem = [[NSMutableString alloc] initWithString:@""];
        for (NSString *key in keys) {
            if ([paraString[key] isKindOfClass:[NSString class]] && [paraString[key] isEqualToString:@""]) {
                continue;
            }
            [tem appendFormat:@"%@=%@&",key,paraString[key]];
        }
        if ([tem hasSuffix:@"&"]) {
          tem = [NSMutableString stringWithString:[tem substringToIndex:tem.length - 1]];
        }
        if(keys.count > 0){
            urlstring = [NSString stringWithFormat:@"%@?%@",urlstring,tem];
        }
    }
    LWLog(@"*********urlstring:%@***********",urlstring);
    [zNetWorkManger POSTworkWithUrl:urlstring WithParamer:@{} Success:success Failure:failure];
}



+ (void)requestGetWithUrl:(NSString *)url Parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure{
    NSString *urlstring = [NSString stringWithFormat:@"%@%@",kApiPrefix,url];
//    [self requestWithURL:urlstring parameters:parameters success:success failure:failure];
    [zNetWorkManger  GETworkWithUrl:urlstring WithParamer:parameters Success:success Failure:failure];
}


/*
 配置好PPNetworkHelper各项请求参数,封装成一个公共方法,给以上方法调用,
 相比在项目中单个分散的使用PPNetworkHelper/其他网络框架请求,可大大降低耦合度,方便维护
 在项目的后期, 你可以在公共请求方法内任意更换其他的网络请求工具,切换成本小
 */

//#pragma mark - 请求的公共方法
//
//+ (void)requestWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(RequestSuccess)success failure:(RequestFailure)failure
//{
//    [zNetWorkManger POSTworkWithUrl:URL WithParamer:parameter Success:success Failure:failure];
//}

@end
