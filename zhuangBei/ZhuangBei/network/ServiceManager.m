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
#import "AFNetworking.h"
#import "LWTool.h"
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
    [zNetWorkManger POSTworkWithUrl:[urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] WithParamer:@{} Success:success Failure:failure];
}



+ (void)requestGetWithUrl:(NSString *)url Parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure{
    NSString *urlstring = [NSString stringWithFormat:@"%@%@",kApiPrefix,url];
    //    [self requestWithURL:urlstring parameters:parameters success:success failure:failure];
    [zNetWorkManger  GETworkWithUrl:urlstring WithParamer:parameters Success:success Failure:failure];
}


/**
 *  异步POST请求:以body方式,字符串、字典
 *
 *  @param url     请求的url
 *  @param body    body数据 字符串、字典
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)requestPostWithUrl:(NSString *)url
                      body:(id)body
                   success:(RequestSuccess)success
                   failure:(RequestFailure)failure
{
    
    //    if (show) {
    [[zHud shareInstance] show];
    //    }
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", kApiPrefix, url];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:nil error:nil];
    request.timeoutInterval= 20;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsCookie];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
    
    // 设置body
    if ([body isKindOfClass:[NSString class]]) {
        LWLog(@"-----------body字符串:%@",body);
        NSData *bodydata = [body dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodydata];
        [request setValue:[NSString stringWithFormat:@"%lu",bodydata.length] forHTTPHeaderField:@"Content-Length"];
    }else if([body isKindOfClass:[NSDictionary class]]){
        NSString *bodystr = [LWTool dictoryToJsonString:body];
        LWLog(@"-----------body字符串:%@",body);
        NSData *bodydata = [bodystr dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodydata];
//        [request setValue:[NSString stringWithFormat:@"%lu",bodydata.length] forHTTPHeaderField:@"Content-Length"];
    }
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            //            if (show) {
            [[zHud shareInstance] hild];
            //            }
            
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
            LWLog(@"***************success:%@",dic);
            success(dic);
        } else {
            [[zHud shareInstance] hild];
            failure(error);
            LWLog(@"request error = %@",error);
        }
    }] resume];
}




@end