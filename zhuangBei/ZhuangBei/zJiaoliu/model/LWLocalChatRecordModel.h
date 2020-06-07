//
//  LWLocalChatRecordModel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/21.
//  Copyright © 2020 aa. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWLocalChatRecordModel : BaseModel<NSCoding>
@property (nonatomic, strong) NSString * roomName;
@property (nonatomic, strong) NSString * roomId;
// 1:group; 2:oto
@property (nonatomic, assign) NSInteger  chatType;
//当前未读数量
@property (nonatomic, assign) NSInteger  unreadNum;
// 好友头像
@property (nonatomic, strong) NSString * avatar;

@end

NS_ASSUME_NONNULL_END
