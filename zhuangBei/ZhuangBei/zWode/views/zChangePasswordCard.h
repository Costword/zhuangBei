//
//  zChangePasswordCard.h
//  ZhuangBei
//
//  Created by aa on 2020/7/23.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^zhuceTapBack)(NSMutableDictionary * userDic);

@interface zChangePasswordCard : UIView

@property(copy,nonatomic)zhuceTapBack zhuceBack;

@end

NS_ASSUME_NONNULL_END
