//
//  LWJiaoLiuModel.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/11.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWJiaoLiuModel.h"


@implementation friendItemModel

@end


@implementation friendListModel
// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"list":friendItemModel.class,
    };
}
@end


@implementation imGroupListModel
// 声明自定义类参数类型
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"groupName":@"groupname",
             @"customId":@"id"};
}
@end

@implementation LWJiaoLiuModel
// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"group":imGroupListModel.class,
             @"friend":friendListModel.class,
             @"imGroupList":imGroupListModel.class,
    };
}

@end
