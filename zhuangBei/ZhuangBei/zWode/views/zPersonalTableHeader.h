//
//  zPersonalTableHeader.h
//  ZhuangBei
//
//  Created by 王明辉 on 2020/9/28.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zUpLoadUserModel.h"
#import "zPersonalModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^changeUpModelBack)(zUpLoadUserModel * upModel,zPersonalModel* perModel);

@interface zPersonalTableHeader : UIView

@property(strong,nonatomic)zUpLoadUserModel * upModel;

@property(strong,nonatomic)zPersonalModel * persoamModel;

@property(assign,nonatomic)BOOL canEdit;

@property(assign,nonatomic)BOOL refresh;

@property(copy,nonatomic)changeUpModelBack changeModelBack;

@end

NS_ASSUME_NONNULL_END
