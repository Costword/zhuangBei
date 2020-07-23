//
//  zFogetCard.h
//  ZhuangBei
//
//  Created by aa on 2020/7/23.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^getMessageCode)(NSString * phoneNum);

typedef void(^zhuceTapBack)(NSMutableDictionary * userDic);


@interface zFogetCard : UIView

@property(copy,nonatomic)getMessageCode getMessageCodeTapBack;

@property(copy,nonatomic)zhuceTapBack zhuceBack;


@end

NS_ASSUME_NONNULL_END
