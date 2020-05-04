//
//  zInterfacedConst.h
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define DevelopSever 0
#define TestSever    1
#define ProductSever 0

/** 接口前缀-开发服务器*/
UIKIT_EXTERN NSString *const kApiPrefix;

#pragma mark - 详细接口地址
/** 验证码*/
UIKIT_EXTERN NSString *const kSendVerificationCode;

/** 注册*/
UIKIT_EXTERN NSString *const kRegister;

/** 通过答题后注册*/
UIKIT_EXTERN NSString *const kPassRegister;

/** 注册答题*/
UIKIT_EXTERN NSString *const kQuestion;

/** 校验答案*/
UIKIT_EXTERN NSString *const kAnswer;

/** 登录*/
UIKIT_EXTERN NSString *const kLogin;
/** 平台会员退出*/
UIKIT_EXTERN NSString *const kExit;

NS_ASSUME_NONNULL_END
