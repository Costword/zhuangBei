//
//  zInterfacedConst.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zInterfacedConst.h"

#if DevelopSever
/** 接口前缀-开发服务器*/
NSString *const kApiPrefix = @"http://47.100.246.18:8081/";
#elif TestSever
/** 接口前缀-测试服务器*/
NSString *const kApiPrefix = @"http://dev.guoziyun.com/";
#elif ProductSever
/** 接口前缀-生产服务器*/
NSString *const kApiPrefix = @"https://www.guoziyun.com/";
#endif

/** 登录*/
NSString *const kLogin = @"api/user/newloginCode";
/** 平台会员退出*/
NSString *const kExit = @"/exit";

