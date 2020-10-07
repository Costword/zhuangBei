//
//  LWUpdateVersionView.h
//  ZhuangBei
//
//  Created by LWQ on 2020/7/21.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWUpdateVersionManager.h"

@interface LWUpdateVersionView : UIView

+ (instancetype)showWithModel:(LWUpdateVersionModel *)model;

- (void)showAleartViewWithTitle:(NSString *)title content:(NSString *)content btns:(NSArray *)btns callBlock:(void(^)(NSString *))block;

@end

