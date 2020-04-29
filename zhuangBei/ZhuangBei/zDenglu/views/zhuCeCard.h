//
//  zhuCeCard.h
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^getMessageCode)(NSString * phoneNum);

typedef void(^zhuceTapBack)(NSMutableDictionary * userDic);

typedef void(^backToLogin)(void);

@interface zhuCeCard : UIView

@property(copy,nonatomic)getMessageCode getMessageCodeTapBack;

@property(copy,nonatomic)zhuceTapBack zhuceBack;

@property(copy,nonatomic)backToLogin backLogin;



@end

NS_ASSUME_NONNULL_END
