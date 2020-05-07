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
//    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
//       response.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-javascript", nil];
//    manager.responseSerializer = response;
    
    //请求体，参数（NSDictionary 类型）
//    NSDictionary *parameters = param;
    [manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"\n*************url:%@,\n para:%@ \n*********responseObject:%@",url,param,responseObject);
        loadSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LWLog(@"\n***********请求失败**url:%@,\n para:%@ \n*********error:%@********",url,param,error);
        loadFailure(error);
    }];
}

@end
