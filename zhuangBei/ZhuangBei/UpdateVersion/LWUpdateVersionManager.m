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

@property (nonatomic, strong) LWUpdateVersionView * updateView;

@end

@implementation LWUpdateVersionManager

/// 更新检查
- (void)checkUpdate
{
    NSDictionary *param = @{@"versionCode":LWDATA(APP_BUILD)};
    LWLog(@"版本更新参数：%@",param);
    [ServiceManager requestGetWithUrl:@"app/appiosversion/findNewOne" Parameters:param success:^(id  _Nonnull response) {
        NSDictionary *appAndroidVersion = response[@"appIosVersion"];
        if (appAndroidVersion && [appAndroidVersion isKindOfClass:[NSDictionary class]]) {
            LWUpdateVersionModel *updateModel = [LWUpdateVersionModel modelWithDictionary:appAndroidVersion];
            self.updateView = [LWUpdateVersionView showWithModel:updateModel];
        }
        NSLog(@"0---response:%@",response);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"版本更新接口error：%@",error);
    }];
}

@end

/**
 {
     msg = "success",
     appIosVersion =     {
         versionCode = 16,
         updateUser = 1,
         updateUserName = <null>,
         id = 39,
         updateTime = "2020-07-23 14:43:05",
         updateDetails = "测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据",
         isForceUpdate = 1,
         isForceUpdateShow = <null>,
         versionNumber = "16",
     },
     code = 2,
 }
 */
