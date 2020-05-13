//
//  LWJiaoLiuModel.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/11.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWJiaoLiuModel.h"

@implementation imGroupListModel

@end

@implementation LWJiaoLiuModel
// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"imGroupList":imGroupListModel.class};
}

@end
