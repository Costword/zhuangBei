//
//  LWUpdateVersionManager.m
//  ZhuangBei
//
//  Created by LWQ on 2020/7/21.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWUpdateVersionManager.h"
#import "LWUpdateVersionView.h"

@implementation LWUpdateVersionModel
@end

@interface LWUpdateVersionManager()
//@property (nonatomic, strong) LWUpdateVersionModel *updateModel;
@property (nonatomic, strong) LWUpdateVersionView * updateView;

@end

@implementation LWUpdateVersionManager

- (void)checkUpdate
{
    [ServiceManager requestPostWithUrl:@"app/appandroidversion/findNewOne" paraString:@{@"versionCode":@16} success:^(id  _Nonnull response) {
        NSDictionary *appAndroidVersion = response[@"appAndroidVersion"];
        if (appAndroidVersion && [appAndroidVersion isKindOfClass:[NSDictionary class]]) {
            LWUpdateVersionModel *updateModel = [LWUpdateVersionModel modelWithDictionary:appAndroidVersion];
//            self.updateView = [LWUpdateVersionView showWithModel:updateModel];
        }
        NSLog(@"response:%@",response);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
@end
/**
 
  {
     msg = "success",
     appAndroidVersion =     {
         versionCode = 16,
         updateUserName = <null>,
         updateDetails = "【合作伙伴】新增在线咨询功能
 【交流大厅】系统群组和当前用户所在群组接口重构
 【个人中心】用户基本信息代码优化，减少字典查询次数
 【个人中心】用户资料功能开发，点击邀请人信息进入详情
 App IM通讯服务端地址动态获取
 App release版本调试配置buildTypes
 App 配置新版域名
 App 调试模式开发，新增彩蛋功能 ",
         id = 35,
         updateTime = "2020-04-26 11:46:48",
         downloadLocation = "/app/appfujian/download?attID=6221",
         packageMd5 = <null>,
         isForceUpdate = 2,
         updateUser = 435,
         versionNumber = "1.1.7.1",
     },
     code = 2,
 }
 */
