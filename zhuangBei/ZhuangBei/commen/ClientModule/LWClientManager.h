//
//  LWClientManager.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/11.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWLocalChatRecordModel.h"
//系统消息的类型
typedef NS_ENUM(NSUInteger, LWSystemMsgType) {
    /**
     * 添加好友通知 --- 通知被添加人
     */
    LWSystemMsgTypeAddFriend = 10020,
    /**
     * 对方同意添加好友 --- 通知添加人
     */
    LWSystemMsgTypeAddFriendSuccess = 10021,
    /**
     * 对方拒绝添加好友 --- 通知添加人
     */
    LWSystemMsgTypeAddFriedFail = 10022,
    /**
     * 群邀请通知 --- 通知被邀请人
     */
    LWSystemMsgTypeGroupInvite = 10023,
    /**
     * 拒绝加群 --- 通知邀请人
     */
    LWSystemMsgTypeGroupJoinRefuse = 10024,
    /**
     * 同意加群 --- 通知邀请人
     */
    LWSystemMsgTypeGroupJoinSuccess = 20020,
    /**
     * 退出群通知 --- 你退出这个群，只有管理员看得到
     */
    LWSystemMsgTypeGroupExitSucess = 20021,
    /**
     * 禁言通知
     */
    LWSystemMsgTypeGroupBanned = 20022,
    /**
     * 撤回通知
     */
    LWSystemMsgTypeGroupWithdraw = 20023,
    /**
    * 其他状态
    */
    LWSystemMsgTypeOther,
};

//当前登录的个人信息
@interface LWUserinforIMModel : BaseModel
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * sign;
@property (nonatomic, strong) NSString * corporateName;
@property (nonatomic, strong) NSString * mainProducts;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * avatarID;
@end

/**
 请求成功的block
 @param response 响应体数据
 */

typedef void(^RequestSuccess)(id response);
/**
 请求失败的block
 */
typedef void(^RequestFailure)(NSError *error);

@interface LWClientManager : NSObject

@property (nonatomic, strong) LWUserinforIMModel * userinforIM;

//该用户的群组<groupid:@{name:@"",avatar:@""}> 该用户的好友和群组 消息里取不到对方的头像，本地遍历解决，呵呵
@property (nonatomic, strong) NSMutableDictionary * allGroupDatas;

+ (instancetype)share;

- (void)installConfigure;

//配置userID
- (void)configureUserId;

//退出SDK
- (void)userLogout;

//登录SDK
- (void)userLogin;


/// 向后台发送群聊消息
/// @param msg 消息
/// @param groupId 群里id
/// @param success 成功
/// @param failure 失败
- (void)sendGroupMsg:(NSString *)msg groupId:(NSString *)groupId success:(RequestSuccess)success failure:(RequestFailure)failure;

/// 向后台发送一对一聊天消息
/// @param msg 消息内容
/// @param roomId  id
/// @param success
/// @param failure
- (void)sendMsgOneToOne:(NSString *)msg roomId:(NSString *)roomId success:(RequestSuccess)success failure:(RequestFailure)failure;

/// 上传图片
/// @param pic image
- (void)requestUploadPicFile:(UIImage *)pic success:(RequestSuccess)success failure:(RequestFailure)failure;


#pragma mark --------------------- 聊天室记录本地化 ---------------------
/// 保存聊天记录
/// @param roomName 聊天室名字
/// @param roomId 聊天室id
/// @param type 聊天类型
/// @param extend 扩展字段
+ (void)saveLocalChatRecordWithRoomName:(NSString *)roomName roomId:(NSString *)roomId chatType:(NSInteger)type extend:(id)extend;

/// 获取本地聊天记录
+ (NSArray *)getLocalChatRecord;

/// 删除本地聊天记录
+ (void)removeLocalChatRecord;

#pragma mark ------------------- 获取系统消息的未读数 ---------------------

/// 获取系统消息未读数
- (void)requestUnReadSystemMsgNumber;

/// 已读系统消息
/// @param type 已读消息类型* type类型：* 0：管理员收到入群申请* 1：收到好友请求
- (void)requestReadSystemMsg:(NSString *)type;

/// 删除该条聊天室的未读消息
/// @param roomId 聊天室的id
- (void)deleteUnReadMsgWithroomId:(NSString *)roomId;


/// 聊天消息的未读数量
@property (nonatomic, assign,readonly) NSInteger  unreadMsgNum;

// 系统未读消息数量
@property (nonatomic, assign,readonly) NSInteger  unreadSysMsgNum;


// 获取该用户的所有群组信息，用于群组未读消息的 反查群组名称
- (void)requestAllGroupInforDatas;

/// 播放消息声音
+ (void)soundBell;

/// 根据roomid 过滤未读数
/// @param roomId 聊天是id
- (NSArray *)getUnReadMessageDataWithRoomId:(NSInteger)roomId;

@end

