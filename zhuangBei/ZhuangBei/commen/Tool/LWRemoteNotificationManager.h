//
//  LWRemoteNotificationManager.h
//  ZhuangBei
//
//  Created by lwq on 2020/10/17.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWRemoteNotificationManager : NSObject

+ (void)setAlias:(NSString *)name response:(nullable void (^)(id __nonnull responseObject,NSError *__nonnull error))handle;

+ (void)removeAlias:(NSString *)name response:(nullable void (^)(id __nonnull responseObject,NSError *__nonnull error))handle;

@end

NS_ASSUME_NONNULL_END
