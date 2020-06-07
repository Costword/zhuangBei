//
//  LWLocalChatRecordModel.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/21.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWLocalChatRecordModel.h"

@implementation LWLocalChatRecordModel

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_roomId forKey:@"roomId"];
    [coder encodeObject:_roomName forKey:@"roomName"];
    [coder encodeInteger:_chatType forKey:@"chatType"];
    [coder encodeInteger:_unreadNum forKey:@"unreadNum"];
    [coder encodeObject:_avatar forKey:@"avatar"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        self.roomId = [coder decodeObjectForKey:@"roomId"];
        self.roomName = [coder decodeObjectForKey:@"roomName"];
        self.chatType = [coder decodeIntegerForKey:@"chatType"];
        self.unreadNum = [coder decodeIntegerForKey:@"unreadNum"];
        self.avatar = [coder decodeObjectForKey:@"avatar"];
    }
    return self;
}
@end
