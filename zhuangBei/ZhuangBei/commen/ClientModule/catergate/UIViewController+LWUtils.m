//
//  UIViewController+LWUtils.m
//  cs_weihai
//
//  Created by LWQ on 2019/10/30.
//  Copyright © 2019 LWQ. All rights reserved.
//

#import "UIViewController+LWUtils.h"
#import <objc/runtime.h>


static const char *LW_automaticallySetModalPresentationStyleKey;

@implementation UIViewController (LWUtils)

+ (void)load {
    Method originAddObserverMethod = class_getInstanceMethod(self, @selector(presentViewController:animated:completion:));
    Method swizzledAddObserverMethod = class_getInstanceMethod(self, @selector(LW_presentViewController:animated:completion:));
    method_exchangeImplementations(originAddObserverMethod, swizzledAddObserverMethod);
}

-(void)setLW_automaticallySetModalPresentationStyle:(BOOL)LW_automaticallySetModalPresentationStyle {
    objc_setAssociatedObject(self, LW_automaticallySetModalPresentationStyleKey, @(LW_automaticallySetModalPresentationStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)LW_automaticallySetModalPresentationStyle {
    id obj = objc_getAssociatedObject(self, LW_automaticallySetModalPresentationStyleKey);
    if (obj) {
        return [obj boolValue];
    }
    return [self.class LW_automaticallySetModalPresentationStyle];
}

+ (BOOL)LW_automaticallySetModalPresentationStyle {
    if ([self isKindOfClass:[UIImagePickerController class]] || [self isKindOfClass:[UIAlertController class]]) {
        return NO;
    }
    return YES;
}

- (void)LW_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (@available(iOS 13.0, *)) {
        if (viewControllerToPresent.LW_automaticallySetModalPresentationStyle) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self LW_presentViewController:viewControllerToPresent animated:flag completion:completion];
    } else {
        // Fallback on earlier versions
        [self LW_presentViewController:viewControllerToPresent animated:flag completion:completion];
    }
}

@end

