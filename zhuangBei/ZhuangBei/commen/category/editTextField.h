//
//  editTextField.h
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface editTextField : UITextField
@property(strong, nonatomic)UIImage *icon;

@property(copy, nonatomic)NSString *myPlaceHolder;

@property(assign,nonatomic)BOOL  canShow;
@end

NS_ASSUME_NONNULL_END
