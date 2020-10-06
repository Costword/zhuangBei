//
//  AppDelegate+LWRemoveNotification.h
//  ZhuangBei
//
//  Created by lwq on 2020/10/7.
//  Copyright © 2020 aa. All rights reserved.
//

#import "AppDelegate.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (LWRemoveNotification)<JPUSHRegisterDelegate>
// 配置Jpush
- (void)configureJpushWithapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
@end

NS_ASSUME_NONNULL_END
