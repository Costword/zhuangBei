//
//  zShouYeLeftMenu.h
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^menuTapBack)(NSInteger index);

@interface zShouYeLeftMenu : UIView


@property(strong,nonatomic)NSArray * menuArray;

@property(copy,nonatomic)menuTapBack menutapBack;

@end

NS_ASSUME_NONNULL_END
