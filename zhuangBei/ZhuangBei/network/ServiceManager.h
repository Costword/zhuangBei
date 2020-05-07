//
//  ServiceManager.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/6.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



/**
 请求成功的block
 @param response 响应体数据
 */

typedef void(^RequestSuccess)(id response);
/**
 请求失败的block
 */
typedef void(^RequestFailure)(NSError *error);


@interface ServiceManager : NSObject


+ (void)requestPostWithUrl:(NSString *)url Parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure;


/// POST  网络请求 内部拼接参数
/// @param url 地址
/// @param paraString 参数字典，内部转拼接参数
/// @param success 成功
/// @param failure 失败
+ (void)requestPostWithUrl:(NSString *)url paraString:(id)paraString success:(RequestSuccess)success failure:(RequestFailure)failure;


+ (void)requestGetWithUrl:(NSString *)url Parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure;


//#pragma mark - 请求的公共方法
//
//+ (void)requestWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(RequestSuccess)success failure:(RequestFailure)failure;

@end

NS_ASSUME_NONNULL_END
