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
NSString *const kApiPrefix_PIC = @"http://39.101.166.209/";
#elif TestSever
/** 接口前缀-测试服务器*/
NSString *const kApiPrefix = @"http://test.110zhuangbei.com:8105/app/";
NSString *const kApiPrefix_PIC = @"http://test.110zhuangbei.com:8105/";
#elif ProductSever
/** 接口前缀-生产服务器*/
NSString *const kApiPrefix = @"http://110zhuangbei.com/app/";
NSString *const kApiPrefix_PIC = @"http://110zhuangbei.com/";
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
NSString *const kpersonalBusiness = @"sys/user/findInviteProductProviderOfNumber";

/**
 * 获取我的邀请人列表
 */
NSString * const kuserGetInvitelList = @"app/appqyuser/inviteMemberList?limit=999&page=1";

/**
 个人中心 - 查询学历，职位，部门，企业类型，工作年限等
 *GET
 *type = [@"sex",@"rank"]
 const val mIsNo = "isNo"           //是否
 const val mIsAgree = "shiFouTy"    //是否同意
 const val mIsDefault = "isDefault" //是否为默认分组
 const val mParamsType = "canShuLx" //参数类型
 const val mAgreement = "agreement" //协议

 const val mExamType = "examType"         //试卷类型
 const val mQuestionType = "questionType" //试题类型
 const val mOptionType = "select_option"  //单选题选项

 const val mSex = "sex"               //性别
 const val mDuty = "rank"             //职务：总经理、财务、商务
 const val mPost = "post"             //岗位
 const val mDepartment = "section"    //部门
 const val mRank = "zhiji"            //职级：一级、二级
 const val mNation = "nation"         //民族
 const val mProvince = "province"     //省份
 const val mEducation = "education"   //学历
 const val mYearOfWork = "jobYear"    //工作年限
 const val mMarriageStatus = "marriagestatus" //婚姻状态
 const val mPoliticsStatus = "politicalstatus"//政治面貌

 const val mLevel = "level"       //会员等级
 const val mLevelNum = "levelNum" //Vip人数

 const val mActivityType = "huoDongZt"    //活动状态
 const val mNoticeWayType = "tongZhiFs"   //通知方式
 const val mProductSource = "productSource"//产品来源
 const val mGroupType = "groupTypeId"     //群组分组类型
 const val mTaskType = "taskType"         //任务类型
 const val mTaskStateType = "taskState"   //任务状态
 const val mCompanyType = "companyType"   //企业类型
 const val mNoticeType = "gongGaoLx"      //公告类型
 const val mPoliceType = "policeClassification" //警钟
 *返回
 {"code":0,"msg":"success","data":{"sex":[{"id":1,"name":"性别","type":"sex","code":"0","value":"女","orderNum":0,"remark":null,"delFlag":0,"gysList":null},{"id":2,"name":"性别","type":"sex","code":"1","value":"男","orderNum":1,"remark":null,"delFlag":0,"gysList":null}]}
 }
  */
NSString *const kgetStudyRank = @"sys/dict/findDictMapByType";
 
/**
 个人中心 - 查询城市列表
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
 *提交用户资料
 *参数
 *{
     "birth": "",
     "buMen": "1",
     "companyNameFirst": "北京",
     "companyNameSecond": "真核",
     "companyNameThird": "科技有限公司",
     "district": "110000",  //城市邮编
     "email": "",
     "isShowBirth": 0,  //是否展示生日
     "isShowEducation": 0, //是否展示学历
     "isShowJobYear": 0,  //是否展示工作年限
     "isShowMobile": 0,  //是否展示手机
     "mobile": "15516562514",
     "portrait": "3379",
     "post": "8",
     "regLocation": "110000",// 城市
     "sex": "1", //性别男
     "shiFouGly": 0,
     "userDm": 692,
     "userId": 751,
     "userName": "哇"
 }
 * {
     "birth": "1991-05-12",1
     "buMen": "2",1
     "district": "110000,120000,130000",1
     "education": "1",1
     "email": "",1
     "isShowBirth": 0,1
     "isShowEducation": 0,1
     "isShowJobYear": 0,1
     "isShowMobile": 0,1
     "jobYear": "1",1
     "mobile": "15516562514",1
     "nativePlace": "410000",1
     "portrait": "3379",1
     "post": "7",1
     "regLocation": "110000",1
     "sex": "1",1
     "shiFouGly": 0,1
     "suoShuGs": "617",1
     "suoShuGsName": "北京真核科技有限公司",1
     "userDm": 692,1
     "userId": 751,1
     "userName": "哇"1
 }
 * {
     jobYear = 1;1
     post = 1;1
     mobile = 18526061162;1
     companyType = 0;0
     isShowBirth = 0;1
     userId = 597;1
     sex = 0;1
     regLocation = 120000;1
     suoShuGs = 0;1
     email = 11;1
     district = 120000,130000,110000;1
     userDm = 532;1
     userName = 王阿宁62;1
     birth = 2020-5-15;1
     isShowEducation = 0;1
     isShowJobYear = 0;1
     suoShuGsName = 天津1162科技有限公司;1
     buMen = 1;1
     nativePlace = 110000;1
     shiFouGly = 0;1
     isShowMobile = 0;1
     education = 6;1
     portrait = 6162;1
 }
 *  * 返回
 * {
     "code": 0,
     "msg": "success"
 }
 */

/**
 * 查询企业是否认证
 * 已认证的企业，公司名称、企业类型、所在部门、所属职务、管辖地不可修改
 * POST
 */

NSString *const kupUserInfo = @"app/appqyuser/update";

/**
 *上传图片
 *
 */
NSString *const kupLoadUserImage = @"app/appfujian/upload";

/**
 *上传公司名称获取公司id
 *POST
 *参数
 *name =  "公司名"
 */
NSString *const kgetCompanyID = @"app/appgongys/findOneByName";

/**
 *修改个人简介
 *POST
 *参数
 *{
     "userId": 751,
     "userDm": 692,
     "minsummary": "语句号"
 }
 */
NSString *const changePersonalMin = @"app/appqyuser/update";


/**
 *邀请人详情
 *URL    http://test.110zhuangbei.com:8105/app/app/appqyuser/findOne
 *userId    768
 */

NSString *const getFriendDetail = @"app/appqyuser/findOne";


/**
 *获取分享二维码
 *Url app/appandroidversion/generateApplicationMarketLinkQrCode
 */
NSString *const getShareImage = @"app/appandroidversion/generateInstallationPackageQrCode";
/**
 *货源管理
 *POST
 *无参数
 */
NSString *const kGoodsMangerMenu = @"app/appzhuangbeitype/getTreeToMyAttentionCompanyNew";

/**
 *货源管理
 *code=3&lastNode=&limit=20&zbid=21&page=1
 */
NSString *const kGoodsMangerList = @"app/appgyszblink/listzbGys";

/**
 *获取公司负责人
 *app/appqyuser/findCompanyAdmin
 *参数 gysId
 */
NSString *const kgetAdminData = @"app/appqyuser/findCompanyAdmin";
/**
 *查询公司产品
 *POST
 *URL    http://test.110zhuangbei.com:8105/app/app/appgyszblink/listAndroid
 *gysId    418
 limit    20
 page    1
 */
NSString *const kGetCompanyGoodsList = @"app/appgyszblink/listAndroid";

/**
 *经销商管理
 *URL    http://test.110zhuangbei.com:8105/app/app/appzhuangbeitype/getTreeToMyAttentionCompanyNew
 */
NSString *const kGetBusinessManLocationList = @"app/appzhuangbeitype/getTreeToMyAttentionCompanyNew";

/**
 *获取经销商列表
 *URL    http://test.110zhuangbei.com:8105/app/app/appgongys/followGsList?code=2&typeIds=&limit=20&page=1&searchData=
 *typeIds 城市地址 用编号代替
 */
NSString *const kGetMyBusinessManList = @"app/appgongys/followGsList";
/**
 登录
 > **username**  (String)    *用户名*    |   必填
 > **password**  (String)    *密码*      |   必填
 */
NSString *const kLogin = @"sys/login";


/** 平台会员退出*/
NSString *const kExit = @"/exit";

/**
 *获取控制台快捷入口分类
 *URL    http://test.110zhuangbei.com:8105/app/app/imgroupclassify/findListByTypeId
 *typeId    1
 *{
     "code": 0,
     "msg": "success",
     "data": [{
         "id": 2,
         "name": "联盟总群",
         "createDate": "2019-12-04 11:24:35",
         "userId": 179,
         "userName": null,
         "typeId": 1,
         "typeIdStr": null,
         "sort": 1,
         "imGroupList": [{
             "id": 36,
             "groupNum": null,
             "groupName": "联盟总群",
             "avatar": "6166",
             "appBackgroundImage": 6195,
             "userId": 1,
             "userName": null,
             "buildTime": "2019-09-03 10:21:57",
             "description": "群主很懒，暂无描述！",
             "status": 1,
             "classifyId": 2
         }, {
             "id": 61,
             "groupNum": null,
             "groupName": "新品申报",
             "avatar": "3379",
             "appBackgroundImage": null,
             "userId": 1,
             "userName": null,
             "buildTime": "2019-12-27 15:21:38",
             "description": "群主很懒，暂无描述！",
             "status": 1,
             "classifyId": 2
         }, {
             "id": 62,
             "groupNum": null,
             "groupName": "爆款申请",
             "avatar": "3379",
             "appBackgroundImage": null,
             "userId": 1,
             "userName": null,
             "buildTime": "2019-12-27 15:22:10",
             "description": "群主很懒，暂无描述！",
             "status": 1,
             "classifyId": 2
         }, {
             "id": 63,
             "groupNum": null,
             "groupName": "管理员招聘",
             "avatar": "3379",
             "appBackgroundImage": null,
             "userId": 1,
             "userName": null,
             "buildTime": "2019-12-27 15:22:23",
             "description": "群主很懒，暂无描述！",
             "status": 1,
             "classifyId": 2
         }]
     }]
 }
 */
NSString *const kFindListByID = @"app/appfriendtype/getFriendTypeAndFriendListV2";

/**
 *通知列表
 *URL    http://test.110zhuangbei.com:8105/app/app/appnotice/listByUser
 *{
     "code": 0,
     "msg": "success",
     "data": [{
         "gongGaoDm": 76,
         "gongGaoBt": "邀请推荐好友",
         "gongGaoLx": 0,
         "gongGaoLxName": null,
         "gongGaoNr": "欢迎大家邀请推荐好友入驻平台。平台会根据您邀请的用户人数进行相应的奖励。",
         "shiFouHz": 0,
         "shiFouHzName": null,
         "huoDongZt": 0,
         "tongZhiFs": 0,
         "tongZhiFsName": null,
         "chuangJianR": 179,
         "chuangJianSj": "2020-02-04 14:54:48",
         "xiuGaiSj": "2020-02-04 14:56:13",
         "xiuGaiR": 179,
         "fsIds": "1",
         "fsMcs": "admin",
         "nameIds": null,
         "nameIdss": null,
         "huiZhiNr": null
     }]
 }
 */
NSString *const kAppnotice = @"app/appnotice/listByUser";


/**
 *通知列表
 *URL    http://test.110zhuangbei.com:8105/app/app/appnoticeuserlink/listByUser
 *limit    20；page    1
 *{
     "code": 0,
     "msg": "success",
     "page": {
         "totalCount": 1,
         "pageSize": 20,
         "totalPage": 1,
         "currPage": 1,
         "list": [{
             "guanLianDm": 769,
             "gongGaoDm": 76,
             "gongGaoDmName": "邀请推荐好友",
             "shiFouYd": 1,
             "shiFouYdName": "是",
             "duQuSj": null,
             "shiFouHz": 0,
             "shiFouHzName": "否",
             "chuangJianSj": "2020-02-04 16:49:53",
             "yongHuDm": 1,
             "yongHuName": "admin",
             "huiZhiNr": null,
             "huoDongZt": 0,
             "tongZhiR": 179,
             "tongZhiRName": null
         }]
     }
 }
 */
NSString *const kAppnoticeList = @"app/appnoticeuserlink/listByUser";

/**
 *公告详情
 *URL    http://test.110zhuangbei.com:8105/app/app/appnotice/listAndUpdate
 *gongGaoDm    76
 *{
     "code": 0,
     "msg": "success",
     "appNotice": {
         "gongGaoDm": 76,
         "gongGaoBt": "邀请推荐好友",
         "gongGaoLx": 0,
         "gongGaoLxName": null,
         "gongGaoNr": "欢迎大家邀请推荐好友入驻平台。平台会根据您邀请的用户人数进行相应的奖励。",
         "shiFouHz": 0,
         "shiFouHzName": null,
         "huoDongZt": 0,
         "tongZhiFs": 0,
         "tongZhiFsName": null,
         "chuangJianR": 179,
         "chuangJianSj": "2020-02-04 14:54:48",
         "xiuGaiSj": "2020-02-04 14:56:13",
         "xiuGaiR": 179,
         "fsIds": "1",
         "fsMcs": "admin",
         "nameIds": null,
         "nameIdss": null,
         "huiZhiNr": null
     }
 }
 */
NSString *const klistAndUpdate = @"app/appnotice/listAndUpdate";


/**
 *忘记密码
 *URL    http://test.110zhuangbei.com:8105/app/sys/user/forgetPassword
 *{
     "username": "15516562513",
     "password": "111111",
     "verificationCode": "123456"
 }
 * {
     "code": 0,
     "msg": "修改成功！"
 }
 */
NSString *const kfogetPassword = @"sys/user/forgetPassword";


/**
 *修改密码
 *URL    http://test.110zhuangbei.com:8105/app/sys/user/password
 *password    123456 newPassword    111111
 *{
     "code": 500,
     "msg": "原密码不正确"
 }
 */
NSString *const kchangePassword = @"sys/user/password";


/**
 *培训大厅获取课程列表
 *URL    http://test.110zhuangbei.com:8105/app/kc/kckecheng/getByKcToAll
 *wentiId    0 keChengDm    26 chuangjianId    1
 *{
     "code": 0,
     "msg": "success",
     "page": {
         "keChengList": {
             "totalCount": 0,
             "pageSize": 10,
             "totalPage": 0,
             "currPage": 1,
             "list": []
         },
         "wenDaList": {
             "totalCount": 0,
             "pageSize": 10,
             "totalPage": 0,
             "currPage": 1,
             "list": []
         },
         "keChengs": {
             "totalCount": 1,
             "pageSize": 10,
             "totalPage": 1,
             "currPage": 1,
             "list": [{
                 "keChengDm": 26,
                 "keChengBh": null,
                 "keChengJj": "《警用装备联盟》的操作手册",
                 "keChengMc": "《警用装备联盟》操作手册",
                 "chuangJianR": 1,
                 "chuangJianRImg": 5292,
                 "chuangJianRnm": "admin",
                 "chuangJianSj": "2020-03-03 06:38:17",
                 "xiuGaiR": 1,
                 "xiuGaiSj": "2020-04-16 14:18:27",
                 "suoLueTu": 6100,
                 "kcNanDu": null,
                 "kcShiChang": null,
                 "kcXuexiNum": null,
                 "kcPingFen": null,
                 "fuJianList": null,
                 "file": null
             }]
         },
         "biJiList": {
             "totalCount": 0,
             "pageSize": 10,
             "totalPage": 0,
             "currPage": 1,
             "list": []
         },
         "Users": {
             "userId": 700,
             "username": "15516562515",
             "nickName": "Waaw",
             "salt": "DGhnHwJVg3kPpUQsh5Eh",
             "email": null,
             "mobile": null,
             "isDisables": 1,
             "createTime": "2020-05-14 10:38:56",
             "sex": null,
             "idCard": "",
             "address": null,
             "companyName": null,
             "companyTypeName": null,
             "creditCode": null,
             "refereeName": null,
             "refereeId": 532,
             "imagesId": 3379,
             "deptId": 1,
             "deptName": null,
             "roleIdList": [24],
             "levelCode": "1",
             "levelNickName": "小树会员",
             "levelName": "入门会员\r",
             "rankCode": null,
             "rankName": null,
             "postCode": null,
             "postName": null,
             "avatar": 3379,
             "sign": null,
             "status": null,
             "qyuserId": null,
             "verificationCode": null,
             "invatationCode": "904181",
             "companyLocation": null,
             "companyShortName": null,
             "companyType": null,
             "minsummary": null
         }
     }
 }
 */

NSString *const kShouCeList = @"kc/kckecheng/getByKcToAll";

/**
 *查询签到状态
 *data {
 "code": 0,
 "msg": "success",
 "data": {
     "id": 57,
     "userId": 751,
     "userName": "哇",
     "sumCount": 1,
     "continueCount": 1,
     "mostContinueCount": 1,
     "updateTime": "2020-10-10 03:02:21",
     "isSign": 1,
     "isContinuousSign": 1
 }
}
 */
NSString *const kQiandaoFindOne = @"app/appusersign/findOne";

/**
 *签到
 *data{
 "code": 0,
 "msg": "success"
}
 */
NSString *const kQiandaoSignIn = @"app/appusersign/signIn";

/**
 *首页推广模块
 *get
 *{
 "code": 0,
 "msg": "success",
 "data": [{
     "id": 3,
     "name": "本周推荐冠军",
     "contentId": 499,
     "contentName": "JoannChen（测试）",
     "content": {
         "userId": 499,
         "userBh": null,
         "userDm": 435,
         "userName": "JoannChen（测试）",
         "minsummary": "听说 android 还不错。。。",
         "birth": "2020-03-12",
         "isShowBirth": 0,
         "jobYear": 4,
         "isShowJobYear": 0,
         "nativePlace": 110000,
         "headSet": null,
         "mobile": "13126596191",
         "isShowMobile": 0,
         "email": "q8622268@163.com",
         "jobName": null,
         "wordShow": null,
         "sex": 0,
         "education": null,
         "isShowEducation": 1,
         "nation": "",
         "provinceId": null,
         "provinceName": null,
         "cityId": null,
         "cityName": null,
         "marriagestatus": null,
         "politicalstatus": null,
         "height": null,
         "weight": null,
         "portrait": 6992,
         "chaungJianRq": "2020-03-09 08:00:00",
         "chuangJianR": null,
         "xiuGaiRq": null,
         "xiuGaiR": null,
         "suoShuGs": 486,
         "suoShuGsName": "北京阿里巴巴集团",
         "suoShuGsCompanyType": null,
         "suoShuGsCreditCodeState": null,
         "status": null,
         "post": 1,
         "jobId": null,
         "rankDm": null,
         "buMen": 1,
         "quanXianDm": null,
         "quanXianMc": null,
         "shiFouGly": 1,
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
         "companyType": 1,
         "companyNameFirst": "北京",
         "companyNameSecond": "阿里巴巴",
         "companyNameThird": "集团",
         "regLocation": 110000,
         "regLocationStr": null,
         "chatNickName": "北京阿里巴巴JoannChen（测试）",
         "operationStatus": 2,
         "mainProduct": null,
         "sexName": null,
         "sectionName": null,
         "postName": null
     },
     "contentType": 1,
     "contentTypeShow": null,
     "sort": 1,
     "updateTime": "2020-08-13 09:12:58",
     "updateUser": 692,
     "updateUserName": null,
     "details": "真的是个好员工",
     "activeState": 0
 }, {
     "id": 4,
     "name": "本月推广大使",
     "contentId": 2010,
     "contentName": "测试6549",
     "content": {
         "userId": 2010,
         "userBh": null,
         "userDm": 1951,
         "userName": "测试6549",
         "minsummary": null,
         "birth": null,
         "isShowBirth": 0,
         "jobYear": null,
         "isShowJobYear": 0,
         "nativePlace": null,
         "headSet": null,
         "mobile": "",
         "isShowMobile": 1,
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
         "chaungJianRq": "2020-08-07 08:00:00",
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
         "regLocation": null,
         "regLocationStr": null,
         "chatNickName": "【未认证用户】 -测试6549",
         "operationStatus": 1,
         "mainProduct": null,
         "sexName": null,
         "sectionName": null,
         "postName": null
     },
     "contentType": 1,
     "contentTypeShow": null,
     "sort": 2,
     "updateTime": "2020-08-13 09:21:09",
     "updateUser": 692,
     "updateUserName": null,
     "details": "",
     "activeState": 0
 }, {
     "id": 5,
     "name": "已认证公司",
     "contentId": 671,
     "contentName": "哈猴子呀真的",
     "content": {
         "id": 671,
         "name": "哈猴子呀真的有限公司",
         "faRen": null,
         "zhuceDi": null,
         "phone": null,
         "email": null,
         "kaihuYinhang": null,
         "duiGongZh": null,
         "zhengjianType": null,
         "groupId": null,
         "imagesId": null,
         "fenshu": null,
         "creditCode": null,
         "strLocation": null,
         "strLocationCity": null,
         "strLocationName": null,
         "strLocationCityName": null,
         "regLocation": 110000,
         "regLocationStr": null,
         "creditCodeState": 0,
         "creditCodeStateName": null,
         "createDate": "2020-08-08 13:15:15",
         "zhuangbeiIds": null,
         "zhuangbeiNames": null,
         "userId": 1990,
         "userName": "测群",
         "companyType": null,
         "companyTypeStr": null,
         "companyClass": 1,
         "isGuanzhu": null,
         "isHot": null,
         "chuangJianRq": "2020-08-08",
         "xiuGaiRq": null,
         "qiYeDz": null,
         "gongSiUrl": null,
         "mainProduct": null,
         "mainPoliceClassification": null,
         "gongSiJj": null,
         "jiBie": null,
         "jiBieMc": null,
         "jiBieBc": null,
         "jiBieBcMc": null,
         "shiFouZx": null,
         "zhuCeZb": null,
         "chengLiRq": null,
         "dengJiJg": null,
         "yingYeQx": null,
         "zcQyUser": null,
         "frQyUser": null,
         "zhuangbeiEntityList": null,
         "regLocationName": null,
         "gysFuJianId": null,
         "companyNameFirst": "哈猴子呀",
         "companyNameSecond": "真的",
         "companyNameThird": "有限公司",
         "approveText": null,
         "approveUser": null,
         "productOperationStatus": null,
         "historyStaffMaxNumber": null,
         "adminNumber": null
     },
     "contentType": 2,
     "contentTypeShow": null,
     "sort": 3,
     "updateTime": "2020-08-13 09:14:08",
     "updateUser": 692,
     "updateUserName": null,
     "details": "",
     "activeState": 0
 }, {
     "id": 6,
     "name": "搜索热度最高企业",
     "contentId": 665,
     "contentName": "阿杜阿杜",
     "content": {
         "id": 665,
         "name": "阿杜阿杜阿达的是",
         "faRen": null,
         "zhuceDi": null,
         "phone": null,
         "email": null,
         "kaihuYinhang": null,
         "duiGongZh": null,
         "zhengjianType": null,
         "groupId": null,
         "imagesId": null,
         "fenshu": null,
         "creditCode": null,
         "strLocation": null,
         "strLocationCity": null,
         "strLocationName": null,
         "strLocationCityName": null,
         "regLocation": 110000,
         "regLocationStr": null,
         "creditCodeState": 0,
         "creditCodeStateName": null,
         "createDate": "2020-06-24 04:16:33",
         "zhuangbeiIds": null,
         "zhuangbeiNames": null,
         "userId": 1995,
         "userName": "测试157",
         "companyType": null,
         "companyTypeStr": null,
         "companyClass": 1,
         "isGuanzhu": null,
         "isHot": null,
         "chuangJianRq": "2020-06-24",
         "xiuGaiRq": null,
         "qiYeDz": null,
         "gongSiUrl": null,
         "mainProduct": null,
         "mainPoliceClassification": null,
         "gongSiJj": null,
         "jiBie": null,
         "jiBieMc": null,
         "jiBieBc": null,
         "jiBieBcMc": null,
         "shiFouZx": null,
         "zhuCeZb": null,
         "chengLiRq": null,
         "dengJiJg": null,
         "yingYeQx": null,
         "zcQyUser": null,
         "frQyUser": null,
         "zhuangbeiEntityList": null,
         "regLocationName": null,
         "gysFuJianId": null,
         "companyNameFirst": "阿杜",
         "companyNameSecond": "阿杜",
         "companyNameThird": "阿达的是",
         "approveText": null,
         "approveUser": null,
         "productOperationStatus": null,
         "historyStaffMaxNumber": null,
         "adminNumber": null
     },
     "contentType": 2,
     "contentTypeShow": null,
     "sort": 4,
     "updateTime": "2020-08-13 09:15:14",
     "updateUser": 692,
     "updateUserName": null,
     "details": "",
     "activeState": 0
 }]
}
 */
NSString *const kTuiguang = @"app/apppromotion/findPublish";

NSString * const kGongxun =@"app/modules/app/appusermeritoriouscoin/appusermeritoriouscoinAppList.html";

//分享：iOSShare
//功勋币：iOSGXDetail

/**
 *功勋币收支情况
 *URL      GET /app/app/appusermeritoriouscoinrecord/findMyselfRecordPage?limit=20&page=1 HTTP/1.1
 *DATA  {
 "code": 0,
 "msg": "success",
 "page": {
     "totalCount": 4,
     "pageSize": 20,
     "totalPage": 1,
     "currPage": 1,
     "list": [{
         "id": 61543,
         "userMeritoriousCoinId": 21309,
         "recordContent": "连续签到 1天",
         "recordType": 1,
         "recordTypeShow": "收入",
         "meritoriousCoinNumber": 1,
         "recordTime": "2020-10-26 00:57:08"
     }, {
         "id": 61512,
         "userMeritoriousCoinId": 21309,
         "recordContent": "首次签到",
         "recordType": 1,
         "recordTypeShow": "收入",
         "meritoriousCoinNumber": 1,
         "recordTime": "2020-10-10 05:52:07"
     }, {
         "id": 53758,
         "userMeritoriousCoinId": 21309,
         "recordContent": "账号注册成功",
         "recordType": 1,
         "recordTypeShow": "收入",
         "meritoriousCoinNumber": 20,
         "recordTime": "2020-04-30 00:00:00"
     }, {
         "id": 57793,
         "userMeritoriousCoinId": 21309,
         "recordContent": "完善个人信息",
         "recordType": 1,
         "recordTypeShow": "收入",
         "meritoriousCoinNumber": 20,
         "recordTime": "2020-04-30 00:00:00"
     }]
 }
}
 */
NSString * const zGXBDetail = @"app/appusermeritoriouscoinrecord/findMyselfRecordPage";
