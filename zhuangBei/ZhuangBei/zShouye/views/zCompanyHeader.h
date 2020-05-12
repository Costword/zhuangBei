//
//  zCompanyHeader.h
//  ZhuangBei
//
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^headerSliderMenuBack)(NSInteger index);

@interface zCompanyHeader : UIView

@property(copy,nonatomic)headerSliderMenuBack headerSlideBack;

@end

NS_ASSUME_NONNULL_END
