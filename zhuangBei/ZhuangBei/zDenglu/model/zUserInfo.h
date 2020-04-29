//
//  zUserInfo.h
//  ZhuangBei
//
//  Created by aa on 2020/4/28.
//  Copyright © 2020 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface zUserInfo : NSObject<NSCoding>

+(zUserInfo*)shareInstance;

@property(copy,nonatomic)NSString * userAccount;

@property(copy,nonatomic)NSString * userPassWord;

-(void)saveUserInfo;
-(void)deleate;
@end

NS_ASSUME_NONNULL_END
