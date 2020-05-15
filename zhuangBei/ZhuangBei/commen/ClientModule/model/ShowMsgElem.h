//
//  ShowMsgElem.h
//  IMDemo
//
//  Created by  Admin on 2018/1/9.
//  Copyright © 2018年  Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowMsgElem : NSObject
@property (nonatomic, strong) NSString * username;
//@property (nonatomic, assign) NSInteger  uid;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) NSString * groupId;
@property (nonatomic, strong) NSString * groupName;
@property (nonatomic, strong) NSString * uavatar;

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL isMySelf; //是否是自己消息

@property (nonatomic, assign) CGFloat rowHeight;

//- (instancetype)initWithDict:(NSDictionary *)dict;


@end
