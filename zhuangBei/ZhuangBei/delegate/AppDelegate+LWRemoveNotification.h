//
//  AppDelegate+LWRemoveNotification.h
//  ZhuangBei
//
//  Created by lwq on 2020/10/7.
//  Copyright © 2020 aa. All rights reserved.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>
#import <UMPush/UMessage.h>
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (LWRemoveNotification)<UNUserNotificationCenterDelegate>

// 配置push
- (void)configureJpushWithapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
