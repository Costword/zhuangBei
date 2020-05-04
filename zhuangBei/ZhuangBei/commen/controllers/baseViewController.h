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



- (void)getDataurl:(NSString *)url withParam:(id)para;

-(void)postDataWithUrl:(NSString*)url WithParam:(id)param;

//-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url;
//
//-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err;
@end

NS_ASSUME_NONNULL_END
