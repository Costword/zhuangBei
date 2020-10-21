//
//  launchManger.h
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+lanunchObsive.h"

NS_ASSUME_NONNULL_BEGIN

@interface launchManger : NSObject

+(launchManger*)shareInstance;

-(BOOL)getLaunchKey;

-(void)saveLaunchKey;

@end

NS_ASSUME_NONNULL_END
