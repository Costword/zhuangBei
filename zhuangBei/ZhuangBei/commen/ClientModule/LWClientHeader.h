
//
//  LWClientHeader.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/12.
//  Copyright © 2020 aa. All rights reserved.
//

#ifndef LWClientHeader_h
#define LWClientHeader_h

#import "UIView+ILGKit.h"
#import "IMUserInfo.h"
#import "AppConfig.h"
#import "UIView+ILGKit.h"
#import "LWClientManager.h"
#import "ShowMsgElem.h"
#import "IFChatCell.h"
#import "XHClient.h"
#import "LWTool.h"
#import "ChatKeyBoard.h"

//接收到新的一对一消息
static NSString *const NEW_MSG_CHAT_NOTI_KEY = @"NEW_MSG_CHAT_NOTI_KEY";
//接收到新的群组消息
static NSString *const NEW_MSG_GROPU_NOTI_KEY = @"NEW_MSG_GROPU_NOTI_KEY";
// 删除群组
static NSString *const DELE_GROPU_CHAT_NOTI_KEY = @"NEW_MSG_GROPU_NOTI_KEY";
//被踢出群组
static NSString *const DELE_USER_GROPU_CHAT_NOTI_KEY = @"NEW_MSG_GROPU_NOTI_KEY";

#endif /* LWClientHeader_h */
