//
//  zNetWorkManger.m
//  ZhuangBei
//
//  Created by aa on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zNetWorkManger.h"
#import <AFNetworking.h>
@implementation zNetWorkManger

+(void)GETworkWithUrl:(NSString*)url WithParamer:(id)param Success:(HttpRequestSuccess)loadSuccess Failure:(HttpRequestFailed)loadFailure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求体，参数（NSDictionary 类型）
    //    NSDictionary *parameters = param;
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        loadSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        loadFailure(error);
    }];
}

+(void)POSTworkWithUrl:(NSString*)url WithParamer:(id)param Success:(HttpRequestSuccess)loadSuccess Failure:(HttpRequestFailed)loadFailure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求体数据为json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置响应体数据为json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求体，参数（NSDictionary 类型）
//    NSDictionary *parameters = param;
    [manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        loadSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        loadFailure(error);
    }];
}

@end
