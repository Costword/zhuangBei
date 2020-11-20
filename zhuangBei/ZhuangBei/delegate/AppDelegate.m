//
//  AppDelegate.m
//  ZhuangBei
//
//  Created by aa on 2020/4/21.
//  Copyright © 2020 aa. All rights reserved.
//

#import "AppDelegate.h"
//#import "MainTabBarController.h"
#import "MainNavController.h"
#import "zDengluController.h"
#import "LWClientManager.h"
#import "IQKeyboardManager.h"
#import "LSTabBarController.h"
#import "JSHAREService.h"
#import "JMLinkService.h"
#import "AppDelegate+LWRemoveNotification.h"
#import "launchManger.h"
#import "ALaunchController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
    
    [self setJLink];
    [self setJShare];
    
    
    sleep(2);
    NSString *version= [UIDevice currentDevice].systemVersion;
    if(version.doubleValue >=13.0) {
        // 针对13.0 以上的iOS系统进行处理
    }
    if (@available(iOS 13.0, *)) {
                
    } else
    {
//        NSHTTPCookie * cookie = [cookiesTool cookieWithName:kLoginUserInfo];
        NSString * token =  [zUserInfo shareInstance].userInfo.token;
        if (token.length>0) {
            //登录状态 进入首页
            LSTabBarController * rootVC  = [[LSTabBarController alloc]init];
            MainNavController * rootNav = [[MainNavController alloc]initWithRootViewController:rootVC];
            rootNav.navigationBar.hidden = YES;
            self.window.rootViewController = rootNav;
            [self.window makeKeyAndVisible];
            
        }else
        {
            
            BOOL tag = [[launchManger shareInstance] getLaunchKey];
            if (tag) {
                ALaunchController * luanchVC =  [[ALaunchController alloc]init];
                MainNavController * rootNav = [[MainNavController alloc]initWithRootViewController:luanchVC];
                rootNav.navigationBar.hidden = YES;
                self.window.rootViewController = rootNav;
                [self.window makeKeyAndVisible];
            }else
            {
                //未登录登录状态 登录
                zDengluController * rootVC  = [[zDengluController alloc]init];
                MainNavController * rootNav = [[MainNavController alloc]initWithRootViewController:rootVC];
                rootNav.navigationBar.hidden = YES;
                self.window.rootViewController = rootNav;
                [self.window makeKeyAndVisible];
            }
            
        }
    }
    
//    配置
    [[LWClientManager share] installConfigure];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
//    [self configureJpushWithapplication:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}


-(void)setJLink{
    JMLinkConfig *linkconfig = [[JMLinkConfig alloc] init];
    linkconfig.appKey = JGAPPK;
    [JMLinkService setupWithConfig:linkconfig];
    [JMLinkService registerHandler:^(JMLinkResponse * _Nullable respone) {
        
        NSLog(@"processParam:%@",respone.params);
    }];
//    [JMLinkService registerMLinkDefaultHandler:^(NSURL * _Nonnull url, NSDictionary * _Nullable params) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // 拿到参数，去解析自己项目的参数
//            [self processParam:params];
//        });
//    }];
}

/// 解析魔链返回的参数
- (void)processParam:(NSDictionary *)param {
    NSLog(@"processParam:%@",param);
    if (!param || param.count <= 0) {
        return;
    }
//    JMLinkParamModel * model = [JMLinkParamModel initWithParam:param];
//    if (!model) {
//        return;
//    }
}

-(void)setJShare{
    JSHARELaunchConfig *config = [[JSHARELaunchConfig alloc] init];
    config.appKey = JGAPPK;
    config.WeChatAppId = weXinAppId;
    config.WeChatAppSecret = weiXinSecret;
    config.QQAppId = qqAppId;
    config.QQAppKey = qqAppKey;
    config.universalLink = @"https://bprjvu.jglinks.cn/";
    [JSHAREService setupWithConfig:config];
    [JSHAREService setDebug:YES];
}

- (BOOL)application:(UIApplication*)application shouldAllowExtensionPointIdentifier:(NSString*)extensionPointIdentifier
{
    if ([extensionPointIdentifier isEqualToString:@"com.apple.keyboard-service"]) {
        return NO;
    }
    return YES;
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    if (@available(iOS 13.0, *)) {
        return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
    } else {
        // Fallback on earlier versions
        return nil;
    }
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first_install"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//iOS9以下，通过url scheme来唤起app
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //必写
    [JMLinkService routeMLink:url];
    [JSHAREService handleOpenUrl:url];
    return YES;
}

//iOS9+，通过url scheme来唤起app
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(nonnull NSDictionary *)options
{
    //必写
    [JMLinkService routeMLink:url];
    [JSHAREService handleOpenUrl:url];
    return YES;
}

//通过universal link来唤起app
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    //必写
    [JSHAREService handleOpenUrl:userActivity.webpageURL];
    [JMLinkService continueUserActivity:userActivity];
    return YES;
}

@end
