//
//  zGXDetailModel.h
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zGXDetailModel : NSObject

//{
//    "id": 61543,
//    "userMeritoriousCoinId": 21309,
//    "recordContent": "连续签到 1天",
//    "recordType": 1,
//    "recordTypeShow": "收入",
//    "meritoriousCoinNumber": 1,
//    "recordTime": "2020-10-26 00:57:08"
//}

@property(copy,nonatomic)NSString * gxid;

@property(copy,nonatomic)NSString * userMeritoriousCoinId;
@property(copy,nonatomic)NSString * recordContent;
@property(copy,nonatomic)NSString * recordType;
@property(copy,nonatomic)NSString * recordTypeShow;
@property(copy,nonatomic)NSString * meritoriousCoinNumber;
@property(copy,nonatomic)NSString * recordTime;

@end

NS_ASSUME_NONNULL_END
