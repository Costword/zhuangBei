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
#define TestSever    0
#define ProductSever 1

/** 接口前缀-开发服务器*/
UIKIT_EXTERN NSString *const kApiPrefix;

/** 接口前缀-开发服务器*/
UIKIT_EXTERN NSString *const kApiPrefix_PIC;


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



/** 获取用户信息*/
UIKIT_EXTERN NSString *const kgetUserInfo;

/** 获取邀请人 货源 经销商人数*/
UIKIT_EXTERN NSString *const kpersonalBusiness;

/** 获取邀请人列表*/
UIKIT_EXTERN NSString * const kuserGetInvitelList;

/** 职务，性别，学历等字典表*/
UIKIT_EXTERN NSString *const kgetStudyRank;

/**提交用户资料*/
UIKIT_EXTERN NSString *const kupUserInfo;

/**验证公司是否审核*/
UIKIT_EXTERN NSString *const kgetCompanyID;

/**
 *上传头像
 */
UIKIT_EXTERN NSString *const kupLoadUserImage;

/**查看邀请人详情*/
UIKIT_EXTERN NSString *const getFriendDetail;

/**获取分享二维码*/
UIKIT_EXTERN NSString *const getShareImage;

/** 获取货源管理列表*/
UIKIT_EXTERN NSString *const kGoodsMangerMenu;

/** 获取货源管理列表*/
UIKIT_EXTERN NSString *const kGoodsMangerList;

/** 获取公司管理员信息*/
UIKIT_EXTERN NSString *const kgetAdminData;

/** 查询公司产品*/
UIKIT_EXTERN NSString *const kGetCompanyGoodsList;

/** 我的经销商地址*/
UIKIT_EXTERN NSString *const kGetBusinessManLocationList;

/** 我的经销商*/
UIKIT_EXTERN NSString *const kGetMyBusinessManList;

/**修改个人简介*/
UIKIT_EXTERN NSString *const changePersonalMin;

/** 平台会员退出*/
UIKIT_EXTERN NSString *const kExit;

/**查询首页通知列表*/
UIKIT_EXTERN NSString *const kFindListByID;

/**查询快捷入口列表*/
UIKIT_EXTERN NSString *const kAppnotice;


/**通知列表接口*/
UIKIT_EXTERN NSString *const kAppnoticeList;

/**通知列表接口*/

UIKIT_EXTERN NSString *const klistAndUpdate;

/**忘记密码*/

UIKIT_EXTERN NSString *const kfogetPassword;

/**修改密码*/

UIKIT_EXTERN NSString *const kchangePassword;

/**课程列表*/

UIKIT_EXTERN NSString *const kShouCeList;

/**查询签到状态*/
UIKIT_EXTERN NSString *const kQiandaoFindOne;

/**签到*/
UIKIT_EXTERN NSString *const kQiandaoSignIn;


/**首页推广*/
UIKIT_EXTERN NSString *const kTuiguang;

/**功勋币*/
UIKIT_EXTERN NSString *const kGongxun;

/**功勋币收支详情*/
UIKIT_EXTERN NSString *const zGXBDetail;

/**公司名称模糊搜索*/
UIKIT_EXTERN NSString *const zFindNameListByName;



NS_ASSUME_NONNULL_END
