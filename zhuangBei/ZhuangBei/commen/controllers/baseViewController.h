//
//  baseViewController.h
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zInterfacedConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface baseViewController : UIViewController



- (void)getData:(BOOL)isOn url:(NSString *)url withParam:(NSDictionary*)para;

-(void)postDataWithUrl:(NSString*)url WithParam:(NSDictionary*)param;
@end

NS_ASSUME_NONNULL_END
