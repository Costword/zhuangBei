//
//  zUserInfo.m
//  ZhuangBei
//
//  Created by aa on 2020/4/28.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zUserInfo.h"
#import <objc/runtime.h>

static NSString * UserDefaultPassword = @"UserDefaultPassword";
static NSString * UserDefaultPhoneNum = @"UserDefaultPhoneNum";

@implementation zUserInfo

+(zUserInfo*)shareInstance
{
    static zUserInfo *_userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userInfo = [[self alloc]init];
    });
    return _userInfo;
}

-(instancetype)init
{
    if (self = [super init]) {
        NSUserDefaults * accountDefaults = [NSUserDefaults standardUserDefaults];
        NSString *phonenum = [accountDefaults objectForKey:UserDefaultPhoneNum];
        NSString *password = [accountDefaults objectForKey:UserDefaultPassword];
        
        self.userAccount = phonenum;
        self.userPassWord = password;
    }
    return self;
}


//归档时调用
-(void)encodeWithCoder:(NSCoder *)coder
{
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        NSString * key = [NSString stringWithUTF8String:name];
        //kvc 获取属性的值
        id value = [self valueForKey:key];
        //归档!!
        [coder encodeObject:value forKey:key];
    }
    free(ivars);
}


- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char * name = ivar_getName(ivar);
            NSString * key = [NSString stringWithUTF8String:name];
            //解档
            id value = [coder decodeObjectForKey:key];
            //设置到属性上面  kvc
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

-(void)setUserAccount:(NSString *)userAccount
{
    _userAccount = userAccount;

}

-(void)setUserPassWord:(NSString *)userPassWord
{
    _userPassWord = userPassWord;
}

-(void)deleate{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:UserDefaultPassword];
    [userDefaults removeObjectForKey:UserDefaultPhoneNum];
    [userDefaults synchronize];//修改立即同步
}

-(void)saveUserInfo
{
    if (_userPassWord.length>0 && _userAccount.length>0) {
        NSLog(@"储存 账号:%@ \n密码:%@",_userAccount,_userPassWord);
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        [accountDefaults setObject:_userAccount forKey:UserDefaultPassword];
        [accountDefaults setObject:_userPassWord forKey:UserDefaultPhoneNum];
    }else
    {
        NSLog(@"账号或密码为空");
    }
    
//    读取本地存储
    
}


@end
