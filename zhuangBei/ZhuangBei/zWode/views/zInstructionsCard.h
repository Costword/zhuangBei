//
//  zInstructionsCard.h
//  ZhuangBei
//  操作手册
//  Created by aa on 2020/4/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^shouCeTap)(void);

@interface zInstructionsCard : UIView

@property(copy,nonatomic)shouCeTap shouceTapBack;

@end

NS_ASSUME_NONNULL_END
