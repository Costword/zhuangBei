//
//  LWHuoYuanDeatilView.h
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWHuoYuanDeatilModel.h"
    
NS_ASSUME_NONNULL_BEGIN
typedef void(^changeModelBlock)(NSString *modelid);
@interface LWHuoYuanDeatilView : UIView
@property (nonatomic, strong) LWHuoYuanDeatilModel * model;
//当前的类型id
@property (nonatomic, strong) NSString * currentModelId;
@property (nonatomic, copy) changeModelBlock block;

@end

NS_ASSUME_NONNULL_END
