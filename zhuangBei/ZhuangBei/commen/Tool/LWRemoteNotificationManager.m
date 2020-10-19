//
//  LWRemoteNotificationManager.m
//  ZhuangBei
//
//  Created by lwq on 2020/10/17.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWRemoteNotificationManager.h"
#import <UMPush/UMessage.h>

@implementation LWRemoteNotificationManager

+ (void)setAlias:(NSString *)name response:(nullable void (^)(id __nonnull responseObject,NSError *__nonnull error))handle {
    [UMessage addAlias:name type:@"iOS" response:handle];
}

+ (void)removeAlias:(NSString *)name response:(nullable void (^)(id __nonnull responseObject,NSError *__nonnull error))handle {
    [UMessage removeAlias:name type:@"iOS" response:handle];
}

@end
