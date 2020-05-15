//
//  MessageGroupViewController.m
//  IMDemo
//
//  Created by  Admin on 2018/1/5.
//  Copyright © 2018年  Admin. All rights reserved.
//

#import "MessageGroupViewController.h"
#import "ShowMsgElem.h"
#import "MessageGroupSettingViewController.h"
#import "InterfaceUrls.h"
#import "LWClientHeader.h"
#import "IFChatView.h"
#import "IFChatCell.h"
#import "LWTool.h"

#define INTERVAL_KEYBOARD  2

@interface MessageGroupViewController ()

@end

@implementation MessageGroupViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
}



#pragma mark - Event
- (void)rightButtonClicked:(UIButton *)button {
    MessageGroupSettingViewController *vc = [[MessageGroupSettingViewController alloc] init];
//    vc.groupID = self.m_Group_ID;
//    if ([self.creatorID isEqualToString:[IMUserInfo shareInstance].userID]) {
//        vc.isOwner = YES;
//    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
