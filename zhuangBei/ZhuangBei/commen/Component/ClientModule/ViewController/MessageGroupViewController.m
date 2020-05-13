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

@interface MessageGroupViewController () <IFChatViewDelegate, XHGroupManagerDelegate>
@property (nonatomic, strong) IFChatView *chatView;
@property (nonatomic, strong) NSMutableArray<ShowMsgElem *> *showDatasArray;
@property (nonatomic, strong) NSMutableArray<ShowMsgElem *> *totalDatasArray;
@end

@implementation MessageGroupViewController
{
    int rowNum;
    dispatch_group_t dispatch_group;
    int successNum;
}

- (void)requestRecordListDatas
{
    [self requestPostWithUrl:@"app/appgroupmessage/getGroupMsgList" paraString:@{@"groupId":LWDATA(self.m_Group_ID)} success:^(id  _Nonnull response) {
        
        [self.totalDatasArray removeAllObjects];
        
        NSArray *data = response[@"data"];
        for (NSDictionary *dict in data) {
            [self.totalDatasArray addObject:[ShowMsgElem modelWithDictionary:dict]];
        }
        if (self.totalDatasArray.count > 100) {
            [self.showDatasArray addObjectsFromArray: [self.totalDatasArray subarrayWithRange:NSMakeRange(self.totalDatasArray.count - 100, 100)]];
        }else{
            self.showDatasArray = self.totalDatasArray;
        }
        
        [self.chatView.tableView reloadData];
        [self scrollTableToFoot:NO];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
//向后台发消息
- (void)requsetSendMsg:(NSString *)text
{
    dispatch_group_enter(dispatch_group);
    [[LWClientManager share] sendGroupMsg:text groupId:self.m_Group_ID success:^(id  _Nonnull response) {
        if ([response[@"code"] intValue] == 0) {
            successNum++;
        }
        dispatch_group_leave(dispatch_group);
    } failure:^(NSError * _Nonnull error) {
        dispatch_group_leave(dispatch_group);
    }];
}

//向SDK发消息
- (void)requestSDKSendMsg:(NSString *)text
{
    dispatch_group_enter(dispatch_group);
    [[XHClient sharedClient].groupManager sendMessage:text toGroup:self.m_Group_ID atUsers:nil completion:^(NSError *error) {
        if (error) {
            LWLog(@"**************消息发送失败error:%@",error);
            [UIView ilg_makeToast:error.localizedDescription];
            //            [self.showDatasArray removeLastObject];
        }else{
            successNum++;
        }
        dispatch_group_leave(dispatch_group);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
    [[XHClient sharedClient].groupManager addDelegate:self];
    
    rowNum = 0;
    self.showDatasArray = [NSMutableArray array];
    self.totalDatasArray = [NSMutableArray array];
    [self addNoticeForKeyboard];
    
    [self requestRecordListDatas];
}

#pragma mark - UI
- (void)createUI {
    self.title = self.m_Group_Name;
    
    IFChatView *chatView = [[IFChatView alloc] initWithDelegate:self];
    [self.view addSubview:chatView];
    _chatView = chatView;
    
    [chatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self setRightButtonImage:@"IM_friend_icon"];
}



#pragma mark IFChatViewDelegate
- (void)chatViewDidSendText:(NSString *)text {
    if (!dispatch_group) {
        dispatch_group = dispatch_group_create();
    }
    
    [self requsetSendMsg:text];
    
    [self requestSDKSendMsg:text];
    
    dispatch_group_notify(dispatch_group, dispatch_get_main_queue(), ^{
        [self.view endEditing:YES];
        if (successNum == 2) {
            ShowMsgElem * newMsgElem = [[ShowMsgElem alloc] init];
            newMsgElem.userID = [IMUserInfo shareInstance].userID;
            newMsgElem.content = text;
            newMsgElem.username = [LWDATA([zUserInfo shareInstance].userInfo.username) isEqualToString:@""]?@"未知昵称":[zUserInfo shareInstance].userInfo.username;
            newMsgElem.time = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            [self showTrace:newMsgElem];
        }else{
            [[zHud shareInstance] showMessage:@"消息发送失败"];
        }
        successNum = 0;
    });
}

#pragma mark XHGroupManagerDelegate
- (void)group:(NSString*)groupID didMembersNumberUpdeted:(NSInteger)membersNumber {
    self.title = [NSString stringWithFormat:@"%@(%d人在线)", self.m_Group_Name, (int)membersNumber];
}

- (void)groupUserKicked:(NSString*)groupID {
    [UIView ilg_makeToast:@"您已被管理员剔除"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)groupDidDeleted:(NSString*)groupID {
    [UIView ilg_makeToast:@"此群已被删除"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)groupMessagesDidReceive:(NSString *)aMessage fromID:(NSString *)fromID groupID:(NSString *)groupID{
    NSDictionary *dict = [LWTool stringToDictory:aMessage];
    ShowMsgElem *model = [ShowMsgElem modelWithDictionary:dict[@"mid"]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showTrace:model];
    });
}

#pragma mark TableView
/**
 * 设置table的section
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

/**
 * 设置table的行数
 */
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.showDatasArray.count;;
}
/**
 * 设置table每一行的数据
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    ShowMsgElem * getNewShowMsgElem =  [self.showDatasArray objectAtIndex:row];
    
    NSString *tableSampleIdentifier = getNewShowMsgElem.isMySelf ? @"TableSampleIdentifierRight":@"TableSampleIdentifierLeft";
    IFChatCellStyle cellStyle = getNewShowMsgElem.isMySelf ? IFChatCellStyleRight:IFChatCellStyleLeft;
    
    IFChatCell *cell = [tableView dequeueReusableCellWithIdentifier:
                        tableSampleIdentifier];
    if (cell == nil) {
        cell = [[IFChatCell alloc]
                initWithStyle:cellStyle
                reuseIdentifier:tableSampleIdentifier];
    }
    [cell.iconIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kApiPrefix,getNewShowMsgElem.uavatar]] placeholderImage:[UIImage imageNamed:@"voip_header"]];
    cell.titleLabel.text = getNewShowMsgElem.username;
    cell.subTitleLabel.text = getNewShowMsgElem.time;
    cell.contentLabel.text = getNewShowMsgElem.content;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _chatView.tableView) {
        ShowMsgElem *getNewShowMsgElem = [self.showDatasArray objectAtIndex:indexPath.row];
        if (getNewShowMsgElem.rowHeight == 0) {
            getNewShowMsgElem.rowHeight = [IFChatCell caculateTextHeightWithMaxWidth:_chatView.tableView.width - [IFChatCell reserveWithForCell] text:getNewShowMsgElem.content];
        }
        
        return getNewShowMsgElem.rowHeight;
    } else {
        return 28;
    }
}


#pragma mark - Event
- (void)rightButtonClicked:(UIButton *)button {
    MessageGroupSettingViewController *vc = [[MessageGroupSettingViewController alloc] init];
    vc.groupID = self.m_Group_ID;
    if ([self.creatorID isEqualToString:[IMUserInfo shareInstance].userID]) {
        vc.isOwner = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 键盘通知
- (void)addNoticeForKeyboard {
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
//键盘显示事件
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    __weak typeof(self) weakSelf = self;
    [UIView beginAnimations:@"Animation" context:nil];
    //设置动画的间隔时间
    [UIView setAnimationDuration:duration];
    //??使用当前正在运行的状态开始下一段动画
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置视图移动的位移
    [_chatView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).offset(-kbHeight);
    }];
    [self.view layoutIfNeeded];
    //设置动画结束
    [UIView commitAnimations];
}

//键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    __weak typeof(self) weakSelf = self;
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        [_chatView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view).offset(0);
        }];
    }];
    [self.view layoutIfNeeded];
}


#pragma mark - other

- (void)showTrace:(ShowMsgElem *)msgModel
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([msgModel.userID isEqualToString:[IMUserInfo shareInstance].userID]) {
            msgModel.isMySelf = YES;
        }
        msgModel.rowHeight = [IFChatCell caculateTextHeightWithMaxWidth:self.chatView.tableView.width - [IFChatCell reserveWithForCell] text:msgModel.content];
        [self.showDatasArray addObject:msgModel];
        rowNum++;
        [self.chatView.tableView reloadData];
        [self scrollTableToFoot:NO];
    });
}

- (void)scrollTableToFoot:(BOOL)animated
{
    NSInteger s = [self.chatView.tableView numberOfSections];  //有多少组
    if (s<1) return;  //无数据时不执行 要不会crash
    NSInteger r = [self.chatView.tableView numberOfRowsInSection:s-1]; //最后一组有多少行
    if (r<1) return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
    [self.chatView.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
}


@end
