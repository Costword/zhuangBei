//
//  launchManger.m
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import "launchManger.h"

@implementation launchManger

+(launchManger*)shareInstance
{
    static launchManger *_launchInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _launchInfo = [[self alloc]init];
    });
    return _launchInfo;
}

-(BOOL)getLaunchKey
{
    return  [self getLaunchShowKey];
}

-(void)saveLaunchKey
{
    [self saveLaunchShowKey];
}

@end
