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

@interface LWJiaoLiuModel : BaseModel
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSArray<imGroupListModel *> * imGroupList;

@end

NS_ASSUME_NONNULL_END
