//
//  LWClientManager.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/11.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWClientManager.h"
#import "XHCustomConfig.h"
#import "XHLoginManager.h"
#import "XHGroupManager.h"
#import "AppConfig.h"

static NSString * const VOIP_SERVER_URL = @"testrtc.bdmgxq.cn:10086";
static NSString * const IM_SERVER_URL = @"testrtc.bdmgxq.cn:19903";
static NSString * const CHATROOM_SERVER_URL = @"testrtc.bdmgxq.cn:19906";
static NSString * const LIVE_VDN_SERVER_URL = @"testrtc.bdmgxq.cn:19928";
static NSString * const LIVE_SRC_SERVER_URL = @"testrtc.bdmgxq.cn:19931";
static NSString * const LIVE_PROXY_SERVER_URL = @"testrtc.bdmgxq.cn:19932";

@interface LWClientManager()<XHLoginManagerDelegate>
@property (nonatomic, strong) XHCustomConfig *config;

@end

@implementation LWClientManager

+ (instancetype)share
{
    static LWClientManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LWClientManager alloc] init];
        manager.config = [[XHCustomConfig alloc] init];
    });
    return manager;
}

- (void)installConfigure
{
    AppConfig *appConfig = [AppConfig appConfigForLocal:IFServiceTypePrivate];
    self.config.serverType =  SERVER_TYPE_CUSTOM;;
    self.config.imServerURL = IM_SERVER_URL;
    self.config.chatRoomServerURL = CHATROOM_SERVER_URL;
    self.config.liveSrcServerURL = LIVE_SRC_SERVER_URL;
    self.config.liveVdnServerURL = LIVE_VDN_SERVER_URL;
    self.config.voipServerURL = VOIP_SERVER_URL;
    zUserModel * model = [zUserInfo shareInstance].userInfo;
    if (model) {
        [self.config sdkInitForFree:LWDATA(model.userId)];
    }
    [self userLogin];
}

//配置userID
- (void)configureUserId
{
    zUserModel * model = [zUserInfo shareInstance].userInfo;
    [self.config sdkInitForFree:LWDATA(model.userId)];
    [self userLogin];
}

//退出SDK
- (void)userLogout
{
    XHLoginManager *loginmanager = [[XHLoginManager alloc] init];
    [loginmanager logout];
}

//登录SDK
- (void)userLogin
{
    zUserModel * model = [zUserInfo shareInstance].userInfo;
    if (model.userId) {
        XHLoginManager *loginmanager = [[XHLoginManager alloc] init];
        [loginmanager loginFree:^(NSError *error) {
            LWLog(@"——————————XHLoginManager登录error：%@",error);
        }];
        [loginmanager addDelegate:self];
    }
}



#pragma mark -------------------XHLoginManagerDelegate--------------
/**
 连接状态发生变化
 
 @param state 状态
 */
- (void)connectionStateDidChange:(XHSDKConnectionState)state;
{
    [[zHud shareInstance] showMessage:state == 1 ? @"已断开连接":@"重新连接成功"];
}

/**
 账户从其他设备登录
 */
- (void)userAccountDidLoginFromOtherDevice;
{
    [[zHud shareInstance] showMessage:@"该用户已从其他设备登录"];
}
/**
 关闭啦，需要重新登录
 */
- (void)userAccountDidLogout;
{
    [[zHud shareInstance] showMessage:@"关闭啦，需要重新登录"];
}


/// 向后台发送群聊消息
/// @param msg 消息
/// @param groupId 群里id
/// @param success 成功
/// @param failure 失败
- (void)sendGroupMsg:(NSString *)msg groupId:(NSString *)groupId success:(RequestSuccess)success failure:(RequestFailure)failure
{
    NSString *userid = [zUserInfo shareInstance].userInfo.userId;
    if (!userid) {
        [[zHud shareInstance] showMessage:@"未获取到userId"];
        return;
    }
    NSString *nowtime = [self currentdateInterval];
    [ServiceManager requestPostWithUrl:@"app/appgroupmessage/save" body:[self getGroupParamString:@{@"content":LWDATA(msg),@"groupId":LWDATA(groupId),@"userId":LWDATA(userid),@"sendTime":LWDATA(nowtime)}] success:^(id  _Nonnull response) {
        success(response);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}


/// 向后台发送一对一聊天消息
/// @param msg 消息内容
/// @param groupId <#groupId description#>
/// @param success <#success description#>
/// @param failure <#failure description#>
- (void)sendMsgOneToOne:(NSString *)msg groupId:(NSString *)groupId success:(RequestSuccess)success failure:(RequestFailure)failure
{
    NSString *userid = [zUserInfo shareInstance].userInfo.userId;
    if (!userid) {
        [[zHud shareInstance] showMessage:@"未获取到userId"];
        return;
    }
    NSString *nowtime = [self currentdateInterval];
    [ServiceManager requestPostWithUrl:@"app/appgroupmessage/save" Parameters:[self getGroupParamString:@{@"content":LWDATA(msg),@"groupId":LWDATA(groupId),@"userId":LWDATA(userid),@"sendTime":LWDATA(nowtime)}] success:^(id  _Nonnull response) {
        success(response);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}


/// 获取当前时间戳
- (NSString *)currentdateInterval
{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    return timeSp;
}


/// 处理群里消息的参数格式
/// @param param 参数字典
- (NSString *)getGroupParamString:(NSDictionary *)param
{
    NSString *string = [NSString stringWithFormat:@"{\"groupId\":\"%@\",\"content\":\"%@\",\"sendTime\":%.0f,\"userId\":%.0f}",param[@"groupId"],param[@"content"],[param[@"sendTime"] floatValue],[param[@"userId"] floatValue]];
    return string;
}

@end
/*
 群聊上传接口：app/appgroupmessage/save
 一对一聊天接口：app/appfriendmessage/save
 */
