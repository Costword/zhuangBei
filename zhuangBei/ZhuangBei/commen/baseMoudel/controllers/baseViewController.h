//
//  baseViewController.h
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zInterfacedConst.h"
#import "zNoContentView.h"
#import "zNothingView.h"
#import "zNetWorkManger.h"
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

@interface baseViewController : UIViewController

@property (nonatomic, assign) NSInteger  currPage;
@property (nonatomic, assign) NSInteger  totalPage;

@property(strong,nonatomic)zNothingView * nothingView;
@property(strong,nonatomic)zNoContentView * noContentView;
- (void)getDataurl:(NSString *)url withParam:(id)para;

-(void)postDataWithUrl:(NSString*)url WithParam:(id)param;

//-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url;
//
//-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err;

- (void)requestPostWithUrl:(NSString *)url Parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure;

/// POST  网络请求 内部拼接参数
/// @param url 地址
/// @param paraString 参数字典，内部转拼接参数
/// @param success 成功
/// @param failure 失败
- (void)requestPostWithUrl:(NSString *)url paraString:(id)paraString success:(RequestSuccess)success failure:(RequestFailure)failure;

- (void)requestDatas;

@end

NS_ASSUME_NONNULL_END
