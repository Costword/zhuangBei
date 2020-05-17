//
//  zUserInvitelController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/16.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zUserInvitelController.h"

@interface zUserInvitelController ()

@end

@implementation zUserInvitelController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * getUserIntevial = [NSString stringWithFormat:@"%@%@",kApiPrefix,kuserGetInvitelList];
    [self getDataurl:getUserIntevial withParam:nil];
}


-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:kuserGetInvitelList]) {
        
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
        }
    }

}



-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:kuserGetInvitelList]) {
        NSDictionary * dic = data[@"page"];
        NSString * code = data[@"code"];
        if ([code integerValue] == 0) {
            
            NSArray * list = dic[@"list"];
            if (list.count == 0) {
                [[zHud shareInstance]showMessage:@"暂无邀请人"];
                self.nothingView.alpha = 1;
                [self.view bringSubviewToFront:self.nothingView];
            }
        }
        NSLog(@"公司认证信息%@",dic);
    }
}


@end
