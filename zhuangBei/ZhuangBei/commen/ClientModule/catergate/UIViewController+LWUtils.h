//
//  UIViewController+LWUtils.h
//  cs_weihai
//
//  Created by LWQ on 2019/10/30.
//  Copyright © 2019 LWQ. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LWUtils)
/**
Whether or not to set ModelPresentationStyle automatically for instance, Default is [Class LL_automaticallySetModalPresentationStyle].

@return BOOL
*/
@property (nonatomic, assign) BOOL  LW_automaticallySetModalPresentationStyle;

/**
 Whether or not to set ModelPresentationStyle automatically, Default is YES, but UIImagePickerController/UIAlertController is NO.

 @return BOOL
 */
+ (BOOL)LW_automaticallySetModalPresentationStyle;


@end

NS_ASSUME_NONNULL_END
