//
//  LWUpdateVersionManager.h
//  ZhuangBei
//
//  Created by LWQ on 2020/7/21.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface LWUpdateVersionModel : BaseModel
@property (nonatomic, strong) NSString * versionCode;//版本号
@property (nonatomic, strong) NSString * versionNumber;//版本名称
@property (nonatomic, assign) NSInteger  isForceUpdate; //更新力度：1手动更新，2强制更新
@property (nonatomic, strong) NSString * updateTime;//更新时间 yyyy-MM-dd HH:mm:ss
@property (nonatomic, strong) NSString * updateUser;//更新人
@property (nonatomic, strong) NSString * updateUserName;
//@property (nonatomic, strong) NSString * downloadLocation;//下载地址
@property (nonatomic, strong) NSString * updateDetails;//更新详情
@property (nonatomic, strong) NSString * isForceUpdateShow;

//var id: String? = null           //主键
@end

@interface LWUpdateVersionManager : NSObject

/// 更新检查
- (void)checkUpdate;

@end

