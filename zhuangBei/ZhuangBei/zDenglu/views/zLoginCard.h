//
//  loginCard.h
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^loginCardEventBack)(NSInteger btnTag);

@interface zLoginCard : UIView

@property(copy,nonatomic)loginCardEventBack eventBack;

@end

NS_ASSUME_NONNULL_END
