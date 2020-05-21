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
#import "LWClientHeader.h"

static NSString * const VOIP_SERVER_URL = @"testrtc.bdmgxq.cn:10086";
static NSString * const IM_SERVER_URL = @"testrtc.bdmgxq.cn:19903";
static NSString * const CHATROOM_SERVER_URL = @"testrtc.bdmgxq.cn:19906";
static NSString * const LIVE_VDN_SERVER_URL = @"testrtc.bdmgxq.cn:19928";
static NSString * const LIVE_SRC_SERVER_URL = @"testrtc.bdmgxq.cn:19931";
static NSString * const LIVE_PROXY_SERVER_URL = @"testrtc.bdmgxq.cn:19932";
static NSString *const sendmsg_oto_url =  @"app/appfriendmessage/save";
static NSString *const sendmsg_group_url  = @"app/appgroupmessage/save";

@interface LWClientManager()<XHLoginManagerDelegate,XHChatManagerDelegate, XHGroupManagerDelegate>
@property (nonatomic, strong) XHCustomConfig *config;
//@property (nonatomic, assign) NSInteger  maxNum;
@end

@implementation LWClientManager

+ (instancetype)share
{
    static LWClientManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LWClientManager alloc] init];
        manager.config = [[XHCustomConfig alloc] init];
        [[XHClient sharedClient].groupManager addDelegate:manager];
        [[XHClient sharedClient].chatManager addDelegate:manager];
        [[XHClient sharedClient].loginManager addDelegate:manager];
    });
    return manager;
}

- (void)installConfigure
{
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
    }
}


#pragma mark ----------- XHGroupManagerDelegate -----------

- (void)group:(NSString*)groupID didMembersNumberUpdeted:(NSInteger)membersNumber {
//    self.title = [NSString stringWithFormat:@"%@(%d人在线)", self.roomName, (int)membersNumber];
}

- (void)groupUserKicked:(NSString*)groupID {
    POST_NOTI(DELE_USER_GROPU_CHAT_NOTI_KEY, nil);
}

- (void)groupDidDeleted:(NSString*)groupID {
    POST_NOTI(DELE_GROPU_CHAT_NOTI_KEY, nil);
}

- (void)groupMessagesDidReceive:(NSString *)aMessage fromID:(NSString *)fromID groupID:(NSString *)groupID{
    
    POST_NOTI(NEW_MSG_GROPU_NOTI_KEY, (@{@"msg":aMessage,@"fromid":fromID,@"groupID":groupID}));
}



#pragma mark ----------- XHChatManagerDelegate -------------

- (void)chatMessageDidReceived:(NSString *)message fromID:(NSString *)uid;
{
    POST_NOTI(NEW_MSG_CHAT_NOTI_KEY, (@{@"msg":message,@"fromid":uid}));
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
    [ServiceManager requestPostWithUrl:sendmsg_group_url body:[self getGroupParamString:@{@"content":LWDATA(msg),@"groupId":LWDATA(groupId),@"userId":LWDATA(userid),@"sendTime":LWDATA(nowtime)}] success:^(id  _Nonnull response) {
        success(response);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}


/// 向后台发送一对一聊天消息
/// @param msg 消息内容
/// @param roomId  id
/// @param success
/// @param failure
- (void)sendMsgOneToOne:(NSString *)msg roomId:(NSString *)roomId success:(RequestSuccess)success failure:(RequestFailure)failure
{
    NSString *userid = [zUserInfo shareInstance].userInfo.userId;
    if (!userid) {
        [[zHud shareInstance] showMessage:@"未获取到userId"];
        return;
    }
    NSString *nowtime = [self currentdateInterval];
    [ServiceManager requestPostWithUrl:sendmsg_oto_url body:[self gettotoParamString:@{@"content":LWDATA(msg),@"toUserId":LWDATA(roomId)}] success:^(id  _Nonnull response) {
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

/// 处理i一对一里消息的参数格式
/// @param param 参数字典
- (NSString *)gettotoParamString:(NSDictionary *)param
{
    NSString *string = [NSString stringWithFormat:@"{\"toUserId\":\"%@\",\"content\":\"%@\"}",param[@"toUserId"],param[@"content"]];
    return string;
}



#pragma mark --------------------- 聊天室记录本地化 ---------------------

/// 保存聊天记录
/// @param roomName 聊天室名字
/// @param roomId 聊天室id
/// @param type 聊天类型
/// @param extend 扩展字段
+ (void)saveLocalChatRecordWithRoomName:(NSString *)roomName roomId:(NSString *)roomId chatType:(NSInteger)type extend:(id)extend
{
    NSMutableArray *chatrecord = [LWClientManager getLocalChatRecord];
    __block BOOL ishave = NO;
    [chatrecord enumerateObjectsUsingBlock:^(LWLocalChatRecordModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.roomId isEqualToString:roomId]) {
            ishave = YES;
            *stop = YES;
        }
    }];
    if (!ishave) {
        LWLocalChatRecordModel *model = [LWLocalChatRecordModel new];
        model.roomId = roomId;
        model.roomName = roomName;
        model.chatType = type;
        NSData *modeldata = [NSKeyedArchiver archivedDataWithRootObject:model];
        NSMutableArray *recoddata = [[NSMutableArray alloc] initWithArray:[SYSTEM_USERDEFAULTS objectForKey:LOCAL_CHATRECORD_LIST_KEY]];
        [recoddata addObject:modeldata];
        [SYSTEM_USERDEFAULTS setObject:recoddata forKey:LOCAL_CHATRECORD_LIST_KEY];
        [SYSTEM_USERDEFAULTS synchronize];
        POST_NOTI(@"refreshChatRecordList", nil);
    }
}

/// 获取本地聊天记录
+ (NSMutableArray *)getLocalChatRecord
{
    NSArray *chatrecord = [SYSTEM_USERDEFAULTS objectForKey:LOCAL_CHATRECORD_LIST_KEY];
    NSMutableArray *tem = [[NSMutableArray alloc] initWithCapacity:chatrecord.count];
    for (NSData *data in chatrecord) {
        LWLocalChatRecordModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [tem addObject:model];
    }
    return tem;
}

/// 删除本地聊天记录
+ (void)removeLocalChatRecord
{
    [SYSTEM_USERDEFAULTS removeObjectForKey:LOCAL_CHATRECORD_LIST_KEY];
    [SYSTEM_USERDEFAULTS synchronize];
}

@end


/*
 群聊上传接口：app/appgroupmessage/save
 一对一聊天接口：app/appfriendmessage/save
 */
