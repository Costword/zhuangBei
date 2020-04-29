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
NSString *const kApiPrefix = @"http://39.101.166.209/app/";
#elif TestSever
/** 接口前缀-测试服务器*/
NSString *const kApiPrefix = @"http://test.110zhuangbei.com:8105/app/";
#elif ProductSever
/** 接口前缀-生产服务器*/
NSString *const kApiPrefix = @"https://www.guoziyun.com/";
#endif

/**获取验证码
 > **phone** (String)    *手机号*    |   必填
 */
NSString *const kSendVerificationCode = @"sys/user/sendVerificationCode";
/**注册
 > **username**  (String)    *用户名*    |   必填

 > **password**  (String)    *密码*  |   必填

 > **verificationCode**  (String)    *验证码*    |   必填

 > **invatationCode**    (String)    *邀请码*

 > **refreeId**  (int)   *邀请人ID*

 > **nickName**  (String)    *真实姓名*  |   必填
 */

NSString *const kRegister = @"sys/user/userRegister";

/**
 注册答题
 无
 */
NSString *const kQuestion = @"app/questionnaireexamrecord/loadRegisterQuestion";

/**
判断试卷
 questionList: [{     //试题对象数组
     questionId: 试题ID,
     recordId: 考试记录ID,
     optionList: [{      //用户选择的答案
         optionId: 选项ID
     }],
 }]
*/
NSString *const kAnswer = @"app/questionnaireexamrecord/submitExamForRegister";



/**
 登录
 > **username**  (String)    *用户名*    |   必填
 > **password**  (String)    *密码*      |   必填
 */
NSString *const kLogin = @"sys/login";


/** 平台会员退出*/
NSString *const kExit = @"/exit";

