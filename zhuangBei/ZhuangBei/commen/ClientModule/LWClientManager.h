//
//  LWClientManager.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/11.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWLocalChatRecordModel.h"


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



#pragma mark --------------------- 聊天室记录本地化 ---------------------
/// 保存聊天记录
/// @param roomName 聊天室名字
/// @param roomId 聊天室id
/// @param type 聊天类型
/// @param extend 扩展字段
+ (void)saveLocalChatRecordWithRoomName:(NSString *)roomName roomId:(NSString *)roomId chatType:(NSInteger)type extend:(id)extend;

/// 获取本地聊天记录
+ (NSMutableArray *)getLocalChatRecord;

/// 删除本地聊天记录
+ (void)removeLocalChatRecord;

@end

