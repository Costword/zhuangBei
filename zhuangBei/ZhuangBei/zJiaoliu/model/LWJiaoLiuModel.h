//
//  LWJiaoLiuModel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/11.
//  Copyright © 2020 aa. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface imGroupListModel : BaseModel
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSString * appBackgroundImage;
@property (nonatomic, strong) NSString * groupName;

@end

//联系人items
@interface friendItemModel : BaseModel
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * corporateName;
@property (nonatomic, strong) NSString * sign;
@property (nonatomic, strong) NSString * avatar;
//id
@end

//联系人 组列表
@interface friendListModel : BaseModel
@property (nonatomic, strong) NSString * groupname;
@property (nonatomic, strong) NSString * online;
//id
@property (nonatomic, strong) NSArray<friendItemModel *> * list;
@property (nonatomic, assign) BOOL  isShow;
@end


@interface LWJiaoLiuModel : BaseModel
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSArray<imGroupListModel *> * imGroupList;
@property (nonatomic, strong) NSArray<imGroupListModel *> * group;
@property (nonatomic, strong) NSString * avatar;

//@property (nonatomic, strong) NSArray<friendListModel *> * friend;
@end

NS_ASSUME_NONNULL_END

/*
 {
     "code": 0,
     "msg": "success",
     "data": {
         "mine": {
             "id": 695,
             "username": "北京真格lw1000-销售部-总经理",
             "avatar": "/app/app/appfujian/download?attID=3379",
             "sign": null,
             "corporateName": null
         },
         "friend": [{
             "id": 620,
             "groupname": "默认",
             "online": null,
             "list": [{
                 "id": 688,
                 "username": "【未认证用户】 -lwq",
                 "avatar": "/app/app/appfujian/download?attID=3379",
                 "sign": null,
                 "corporateName": null
             }]
         }, {
             "id": 625,
             "groupname": "测试",
             "online": null,
             "list": [{
                 "id": 696,
                 "username": "【未认证用户】 -刘文",
                 "avatar": "/app/app/appfujian/download?attID=3379",
                 "sign": null,
                 "corporateName": null
             }]
         }],
         "group": [{
             "id": 36,
             "groupname": "平台总群",
             "avatar": "/app/app/appfujian/download?attID=/app/app/appfujian/download?attID=/app/app/appfujian/download?attID=3379"
         }, {
             "id": 45,
             "groupname": "特巡警装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 46,
             "groupname": "警保装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 47,
             "groupname": "刑侦装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 48,
             "groupname": "禁毒装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 49,
             "groupname": "交警装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 50,
             "groupname": "监所装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 51,
             "groupname": "法制装备/软件交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 52,
             "groupname": "东北地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 53,
             "groupname": "华北地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 54,
             "groupname": "华中地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 55,
             "groupname": "华东地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 56,
             "groupname": "东南地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 57,
             "groupname": "华南地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 61,
             "groupname": "新产品申报",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 62,
             "groupname": "爆款申请",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 63,
             "groupname": "投诉建议",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 64,
             "groupname": "西北地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }, {
             "id": 65,
             "groupname": "西南地区交流群",
             "avatar": "/app/app/appfujian/download?attID=3379"
         }]
     }
 }

 */
