//
//  NSObject+lanunchObsive.m
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import "NSObject+lanunchObsive.h"

static NSString * launchInfo = @"launch.archiver";

@implementation NSObject (lanunchObsive)

-(void)saveLaunchShowKey
{
    NSString * temp  = NSTemporaryDirectory();
    NSString * filePath = [temp stringByAppendingPathComponent:launchInfo];
    [NSKeyedArchiver archiveRootObject:@(1) toFile:filePath];
    
}

-(BOOL)getLaunchShowKey
{
    NSString * temp  = NSTemporaryDirectory();
    NSString * filePath = [temp stringByAppendingPathComponent:launchInfo];
    NSString * launchKey = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (launchKey && [launchKey integerValue]==1) {
        return NO;
    }
    return YES;
}
@end
