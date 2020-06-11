//
//  ChatRoomViewController.m
//  IMDemo
//
//  Created by  Admin on 2017/12/25.
//  Copyright © 2017年  Admin. All rights reserved.
//

#import "ChatRoomViewController.h"
#import "LWClientHeader.h"

#import "IMUserInfo.h"

#import "IFChatView.h"

#define INTERVAL_KEYBOARD  20

@interface ChatRoomViewController ()

@end

@implementation ChatRoomViewController
// app/appfriendmessage/save
//app/appfriendmessage/getFriendMsgList

- (void)deletefriend
{
    [self requestPostWithUrl:@"app/appfriend/delete" para:self.roomId paraType:(LWRequestParamTypeBody) success:^(id  _Nonnull response) {
        POST_NOTI(@"refreshFriendListDataWhenDeleteFriend", nil);
        if ([response[@"code"] intValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [LWClientManager.share requestAllGroupInforDatas];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *keys = LWClientManager.share.allGroupDatas.allKeys;
    __block BOOL ishave = NO;
    [keys enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj integerValue] == [self.roomId integerValue]) {
            ishave = YES;
            *stop = YES;
        }
    }];
    if (self.fromType != 1 && ishave) {
        [self addRightItem];
    }
}

- (void)addRightItem
{
    UIButton *rightbtn = [UIButton new];
    [rightbtn setTitle:@"删除好友" forState:UIControlStateNormal];
    [rightbtn setTitleColor:BASECOLOR_BLUECOLOR forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.frame = CGRectMake(0, 0, 40, 40);
    rightbtn.titleLabel.font = kFont(14);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
}

- (void)rightButtonClicked
{
    [LEEAlert alert].config
     .LeeTitle(@"温馨提示")
     .LeeContent(@"确认删除当前该好友？")
     .LeeCancelAction(@"取消", ^{
         // 点击事件Block
     })
     .LeeAction(@"确认", ^{
         // 点击事件Block
         [self deletefriend];
     })
     .LeeShow();
}

#pragma mark - Event

- (void)chatMessageDidReceive:(NSNotification *)notif {
    NSDictionary *dic = notif.object;
    NSString *msg = dic[@"message"];
    NSString *uid = dic[@"uid"];
    
    [self showTrace:msg userID:uid isMySelf:NO];
}



#pragma mark XHChatroomManagerDelegate



//- (NSArray *)actionTitleArr:(NSString *)targetID {
//    if ([targetID isEqualToString:[IMUserInfo shareInstance].userID]) { //自己
//        return @[];
//    } else if ([[IMUserInfo shareInstance].userID isEqualToString:self.mCreaterId]) { //不是自己，而且自己是拥有者
//        return @[@"踢出房间", @"禁止发言", @"私信"];
//    } else { //自己是普通成员
//        return @[@"私信"];
//    }
//}
//- (NSArray *)actionEventArr:(NSString *)targetID {
//    if ([targetID isEqualToString:[IMUserInfo shareInstance].userID]) { //自己
//        return @[];
//    } else if ([[IMUserInfo shareInstance].userID isEqualToString:self.mCreaterId]) { //不是自己，而且自己是拥有者
//        return @[@"kick:", @"mute:", @"privateMsg:"];
//    } else { //自己是普通成员
//        return @[@"privateMsg:"];
//    }
//}



#pragma mark - other
- (void)showManagerDialog:(NSString *)userID
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:@""
                                                                      preferredStyle:UIAlertControllerStyleAlert ];
    
    UIAlertAction *home1Action = [UIAlertAction actionWithTitle:@"剔出房间" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:home1Action];
    UIAlertAction *home2Action = [UIAlertAction actionWithTitle:@"禁止发言" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:home2Action];
    UIAlertAction *home3Action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:home3Action];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)showTrace:(NSString *)msg userID:(NSString *)userID isMySelf:(BOOL)isMySelf
{
    dispatch_async(dispatch_get_main_queue(), ^{
        ShowMsgElem *newMsgElem = [self convertMsgToModel:msg userID:userID];
        [self.showDatasArray addObject:newMsgElem];
        [self.chatTableView reloadData];
        [self scrollTableToFoot:NO];
    });
}

- (ShowMsgElem *)convertMsgToModel:(NSString *)msg userID:(NSString *)userID {
    ShowMsgElem *newMsgElem = [[ShowMsgElem alloc] init];
    newMsgElem.userID = userID;
    //    newMsgElem.text = msg;
    //    newMsgElem.isMySelf = [userID isEqualToString:UserId];
    newMsgElem.rowHeight = [IFChatCell caculateTextHeightWithMaxWidth:self.chatTableView.width - [IFChatCell reserveWithForCell] text:msg];
    return newMsgElem;
}

@end
