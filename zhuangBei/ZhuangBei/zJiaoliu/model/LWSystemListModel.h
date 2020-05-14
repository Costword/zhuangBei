//
//  LWSystemListModel.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/14.
//  Copyright © 2020 aa. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface userModel : BaseModel
@property (nonatomic, strong) NSString * username;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * corporateName;
@end

@interface LWSystemListModel : BaseModel
//id
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * remark;
@property (nonatomic, strong) NSString * time;
@property (nonatomic, strong) userModel * user;
@property (nonatomic, strong) NSString * uid;
@property (nonatomic, strong) NSString * from;
@property (nonatomic, assign) NSInteger  status;

@end

NS_ASSUME_NONNULL_END

/*
 {
     "code": 0,
     "msg": "success",
     "data": {
         "totalCount": 1,
         "pageSize": 10,
         "totalPage": 1,
         "currPage": 1,
         "list": [
             {
                 "id": 271,
                 "content": "申请添加你为好友",
                 "uid": 696,
                 "from": 688,
                 "from_group": 0,
                 "type": null,
                 "remark": "688 请求添加好友",
                 "href": null,
                 "read": 1,
                 "time": "2020-05-14 11:13:24",
                 "user": {
                     "id": 688,
                     "username": "lwq",
                     "avatar": "/app/app/appfujian/download?attID=3379",
                     "sign": null,
                     "corporateName": null
                 },
                 "status": 1
             }
         ]
     },
     "pages": 1
 }
 */
