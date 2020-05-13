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

/**pass注册 (注册通过后调用此接口)
 > **username**  (String)    *用户名*    |   必填

 > **password**  (String)    *密码*  |   必填

 > **verificationCode**  (String)    *验证码*    |   必填

 > **invatationCode**    (String)    *邀请码*

 > **refreeId**  (int)   *邀请人ID*

 > **nickName**  (String)    *真实姓名*  |   必填
 */

NSString *const kPassRegister = @"sys/user/userRegister?isPassed=1";
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
 合作伙伴
 *经销商管理
 *code = 2
 *typeIds = 2  未知
 *limit = 20 分页
 *page = 1 第一页
 *searchData= HTTP/1.1
 Authorization: login_token_f86c7994-376b-4dce-b1b0-eba703108356     ?token?
 */
NSString *const kbusinessMan = @"app/appgongys/followGsList";

/**
 个人中心
 *GET
 *返回
 {
     "code": 0,
     "msg": "success",
     "data": {
         "inviteNumber": 0, //我的邀请人
         "productNumber": 0,//我关注的货源
         "providerNumber": 0//我的经销商
     }
 }
 */
NSString *const kpersonal = @"sys/user/findInviteProductProviderOfNumber";

/**
 个人中心 - 查询学历
 *GET
 *返回
 {
     "code": 0,
     "msg": "success",
     "data": {
         "inviteNumber": 0, //我的邀请人
         "productNumber": 0,//我关注的货源
         "providerNumber": 0//我的经销商
     }
 }
 */
NSString *const kgetStudyRank = @"sys/user/findInviteProductProviderOfNumber";
 
/**
 个人中心 - 查询学历
 *POST
 *返回
 {
     "code": 0,
     "msg": "success",
     "list": {
         "userId": 744,
         "userBh": null,
         "userDm": 685,
         "userName": "Wa",
         "minsummary": null,
         "birth": null,
         "isShowBirth": 0,
         "jobYear": null,
         "isShowJobYear": 0,
         "nativePlace": null,
         "headSet": null,
         "mobile": "15516562513",
         "isShowMobile": 0,
         "email": null,
         "jobName": null,
         "wordShow": null,
         "sex": null,
         "education": null,
         "isShowEducation": 0,
         "nation": null,
         "provinceId": null,
         "provinceName": null,
         "cityId": null,
         "cityName": null,
         "marriagestatus": null,
         "politicalstatus": null,
         "height": null,
         "weight": null,
         "portrait": 3379,
         "chaungJianRq": "2020-04-30 08:00:00",
         "chuangJianR": null,
         "xiuGaiRq": null,
         "xiuGaiR": null,
         "suoShuGs": null,
         "suoShuGsName": null,
         "suoShuGsCompanyType": null,
         "suoShuGsCreditCodeState": null,
         "status": null,
         "post": null,
         "jobId": null,
         "rankDm": null,
         "buMen": null,
         "quanXianDm": null,
         "quanXianMc": null,
         "shiFouGly": 0,
         "followStatus": null,
         "district": null,
         "districtIdList": null,
         "quJson": null,
         "xmJson": null,
         "jyJson": null,
         "gzJson": null,
         "userName2": null,
         "email2": null,
         "mobile2": null,
         "jobName2": null,
         "companyType": null,
         "companyNameFirst": null,
         "companyNameSecond": null,
         "companyNameThird": null,
         "regLocation": null
     },
     "provinceList": [{
         "id": 10000,
         "name": "全国",
         "parentId": 1,
         "createDate": "2020-03-23 14:42:21",
         "checked": false
     }]
 }
 */
NSString *const kgetUserInfo = @"app/appqyuser/qyinfo";


    

/**
 登录
 > **username**  (String)    *用户名*    |   必填
 > **password**  (String)    *密码*      |   必填
 */
NSString *const kLogin = @"sys/login";


/** 平台会员退出*/
NSString *const kExit = @"/exit";

