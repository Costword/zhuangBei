//
//  ShowMsgElem.m
//  IMDemo
//
//  Created by  Admin on 2018/1/9.
//  Copyright © 2018年  Admin. All rights reserved.
//

#import "ShowMsgElem.h"

@implementation ShowMsgElem


// 声明自定义类参数类型

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper;
{
    return  @{@"isMySelf":@"mine",
              @"userID":@"uid",
    };
}
@end
