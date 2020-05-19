//
//  LWChatListViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/14.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWChatListBaseViewController.h"
#import "IQKeyboardManager.h"

NSString *const getlist_group_url  = @"app/appgroupmessage/getGroupMsgList";

NSString *const getlist_oto_url =  @"app/appfriendmessage/getFriendMsgList";


@interface LWChatListBaseViewController ()<IFChatViewDelegate, UITableViewDataSource,UITableViewDelegate, UITextViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray<ShowMsgElem *> *totalDatasArray;
@property (nonatomic, strong) NSString *m_Group_ID;
@property (nonatomic, assign) LWChatRoomType  roomType;
@property (nonatomic, strong) dispatch_group_t dispatch_group;
@property (nonatomic, assign) NSInteger  successNum;

@end

@implementation LWChatListBaseViewController

//检查群组权限
- (void)requestGroupCanSendmsg
{
    [self requestPostWithUrl:@"app/appgroupuser/findOneByGroupIdAndUserId" paraString:@{@"groupId":LWDATA(self.roomId)} success:^(id  _Nonnull response) {
        NSInteger code = [response[@"code"] integerValue];
        NSString *msg = response[@"mag"];
        [self.chatView checkUserCanSendmsg:(code == 1) msg:(code == 1)?@"":msg];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

// 获取列表的聊天记录
- (void)requestRecordListDatas
{
    NSDictionary *param = [NSDictionary new];
    NSString *url = getlist_group_url;
    if (_roomType == LWChatRoomTypeOneTOne) {
        url = getlist_oto_url;
        param = @{@"toUserId":LWDATA(self.roomId)};
    }else{
        param = @{@"groupId":LWDATA(self.m_Group_ID)};
    }
    [self requestPostWithUrl:url paraString:param success:^(id  _Nonnull response) {
        
        [self.totalDatasArray removeAllObjects];
        
        NSArray *data = response[@"data"];
        for (NSDictionary *dict in data) {
            [self.totalDatasArray addObject:[ShowMsgElem modelWithDictionary:dict]];
        }
        if (self.totalDatasArray.count > 100) {
            [self.showDatasArray addObjectsFromArray: [self.totalDatasArray subarrayWithRange:NSMakeRange(self.totalDatasArray.count - 100, 100)]];
        }else{
            self.showDatasArray = [self.totalDatasArray mutableCopy];
        }
        
        [self.chatView.tableView reloadData];
        [self scrollTableToFoot:NO];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//向后台发消息
- (void)requsetSendMsgService:(NSString *)text
{
    dispatch_group_enter(self.dispatch_group);
    if (_roomType == LWChatRoomTypeGroup) {
        [[LWClientManager share] sendGroupMsg:text groupId:self.m_Group_ID success:^(id  _Nonnull response) {
            if ([response[@"code"] intValue] == 0) {
                self.successNum++;
            }
            dispatch_group_leave(self.dispatch_group);
        } failure:^(NSError * _Nonnull error) {
            dispatch_group_leave(self.dispatch_group);
        }];
    }else if(_roomType == LWChatRoomTypeOneTOne){
        [[LWClientManager share] sendMsgOneToOne:text roomId:self.roomId success:^(id  _Nonnull response) {
            if ([response[@"code"] intValue] == 0) {
                self.successNum++;
            }
            dispatch_group_leave(self.dispatch_group);
        } failure:^(NSError * _Nonnull error) {
            dispatch_group_leave(self.dispatch_group);
        }];
    }
}

//向SDK发消息
- (void)requestSDKSendMsg:(NSString *)text
{
    dispatch_group_enter(self.dispatch_group);
    if (_roomType == LWChatRoomTypeGroup) {
        [[XHClient sharedClient].groupManager sendMessage:text toGroup:self.m_Group_ID atUsers:nil completion:^(NSError *error) {
            if (error) {
                LWLog(@"**************消息发送失败error:%@",error);
                [UIView ilg_makeToast:error.localizedDescription];
            }else{
                self.successNum++;
            }
            dispatch_group_leave(self.dispatch_group);
        }];
        
    }else if (_roomType == LWChatRoomTypeOneTOne){
        [[XHClient sharedClient].chatManager sendMessage:text toID:self.roomId completion:^(NSError *error) {
            if (error) {
                LWLog(@"**************消息发送失败error:%@",error);
                [UIView ilg_makeToast:error.localizedDescription];
            } else {
                self.successNum++;
            }
            dispatch_group_leave(self.dispatch_group);
        }];
    }
}


#pragma mark IFChatViewDelegate
- (void)chatViewDidSendText:(NSString *)text {
    //    if (!self.dispatch_group) {
    //    }
    self.dispatch_group = dispatch_group_create();
    
    [self requsetSendMsgService:text];
    
    [self requestSDKSendMsg:text];
    
    dispatch_group_notify(self.dispatch_group, dispatch_get_main_queue(), ^{
        [self.view endEditing:YES];
        if (self.successNum == 2) {
            ShowMsgElem * newMsgElem = [[ShowMsgElem alloc] init];
            newMsgElem.userID = [IMUserInfo shareInstance].userID;
            newMsgElem.content = text;
            newMsgElem.username = [LWDATA([zUserInfo shareInstance].userInfo.username) isEqualToString:@""]?@"未知昵称":[zUserInfo shareInstance].userInfo.username;
            newMsgElem.time = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            [self showTrace:newMsgElem];
        }else{
            [[zHud shareInstance] showMessage:@"消息发送失败"];
        }
        self.successNum = 0;
    });
}

- (void)showTrace:(ShowMsgElem *)msgModel
{
    if (!msgModel) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([msgModel.userID isEqualToString:[IMUserInfo shareInstance].userID]) {
            msgModel.isMySelf = YES;
        }
        msgModel.rowHeight = [IFChatCell caculateTextHeightWithMaxWidth:self.chatView.tableView.width - [IFChatCell reserveWithForCell] text:msgModel.content];
        [self.totalDatasArray addObject:msgModel];
        [self.showDatasArray removeAllObjects];
        //        [self.showDatasArray addObjectsFromArray: [self.totalDatasArray subarrayWithRange:NSMakeRange(self.totalDatasArray.count - 100, 100)]];
        [self getNeetShowDatas];
        [self.chatView.tableView reloadData];
        [self scrollTableToFoot:NO];
    });
}


#pragma mark ----------- XHGroupManagerDelegate 通知-----------

- (void)receiveNewChatGroupMsg:(NSNotification *)noti
{
    NSDictionary *msgdic = noti.object;
    NSDictionary *dict = [LWTool stringToDictory:msgdic[@"msg"]];
    ShowMsgElem *model = [ShowMsgElem modelWithDictionary:dict[@"mid"]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showTrace:model];
    });
}

- (void)deleUserGroupChat
{
    [UIView ilg_makeToast:@"您已被管理员剔除"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleGroupChat
{
    [UIView ilg_makeToast:@"此群已被删除"];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----------- XHChatManagerDelegate 通知-------------
- (void)receiveNewChatMsg:(NSNotification *)noti
{
    NSDictionary *msgdic = noti.object;
    NSDictionary *dict = [LWTool stringToDictory:msgdic[@"msg"]];
    ShowMsgElem *model = [ShowMsgElem modelWithDictionary:dict];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showTrace:model];
    });
}


/// 创建聊天室，群聊、单聊
/// @param roomId 房间ID
/// @param roomName 房间名字
/// @param roomType 聊天类型
/// @param extend 扩展字段
+ (instancetype)chatRoomViewControllerWithRoomId:(NSString *)roomId roomName:(NSString *)roomName roomType:(LWChatRoomType )roomType extend:(id)extend;
{
    LWChatListBaseViewController *vc = [[self alloc] init];
    vc.roomName = roomName;
    vc.roomId = roomId;
    vc.roomType = roomType;
    return vc;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.showDatasArray = [NSMutableArray array];
    self.totalDatasArray = [NSMutableArray array];
    self.m_Group_ID = self.roomId;
    
    ADD_NOTI(receiveNewChatMsg:, NEW_MSG_CHAT_NOTI_KEY);
    ADD_NOTI(receiveNewChatGroupMsg:, NEW_MSG_GROPU_NOTI_KEY);
    ADD_NOTI(deleGroupChat, DELE_GROPU_CHAT_NOTI_KEY);
    ADD_NOTI(deleUserGroupChat, DELE_USER_GROPU_CHAT_NOTI_KEY);
    
    if (_roomType == LWChatRoomTypeGroup) {
        [self requestGroupCanSendmsg];
    }else if (_roomType == LWChatRoomTypeOneTOne){
    }
    
    self.title = self.roomName;
    
    [self addNotiObserver];
    
    [self requestRecordListDatas];
}

#pragma mark - UI
- (void)createUI {
    
    IFChatView *chatView = [[IFChatView alloc] initWithDelegate:self];
    [self.view addSubview:chatView];
    chatView.textField.placeholder = @"来聊吧";
    _chatView = chatView;
    
    __weak typeof(self) weakSelf = self;
    [chatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(0);
        make.leading.equalTo(weakSelf.view);
        make.trailing.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
}

- (void)addNotiObserver
{
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

///键盘显示事件
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
    
    [self.chatView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).offset(-kbHeight);
    }];
    [self.view layoutIfNeeded];
    
    //设置动画结束
    [UIView commitAnimations];
}

///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    __weak typeof(self) weakSelf = self;
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        [self.chatView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view).offset(0);
        }];
    }];
    [self.view layoutIfNeeded];
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


#pragma mark TableView

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.showDatasArray.count;;
}

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
    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc] initWithString:getNewShowMsgElem.content attributes:@{ NSFontAttributeName: kFont(15), NSForegroundColorAttributeName: UIColor.whiteColor }];
    [PPStickerDataManager.sharedInstance replaceEmojiForAttributedString:attributedMessage font:kFont(15)];
    //    cell.contentLabel.adjustsFontSizeToFitWidth = true;
    cell.contentLabel.attributedText = attributedMessage;
    //    cell.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    cell.contentLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowMsgElem *getNewShowMsgElem = [self.showDatasArray objectAtIndex:indexPath.row];
    if (getNewShowMsgElem.rowHeight == 0) {
        getNewShowMsgElem.rowHeight = [IFChatCell caculateTextHeightWithMaxWidth:self.chatView.tableView.width - [IFChatCell reserveWithForCell] text:getNewShowMsgElem.content];
    }
    
    return getNewShowMsgElem.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowMsgElem *newMsgElem = self.showDatasArray[indexPath.row];
    NSLog(@"choose ID %@", newMsgElem.userID);
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y <= 0) {
        [self getNeetShowDatas];
    }
}

//加载更多数据
- (void)getNeetShowDatas
{
    if (self.totalDatasArray.count > self.showDatasArray.count) {
        if (self.totalDatasArray.count - self.showDatasArray.count > 50) {
            NSMutableArray *tem = [[NSMutableArray alloc] initWithArray:[self.totalDatasArray subarrayWithRange:NSMakeRange(self.totalDatasArray.count - self.showDatasArray.count - 50, 50)]];
            [self.showDatasArray insertObjects:tem atIndex:0];
        }else{
            self.showDatasArray = [self.totalDatasArray mutableCopy];
        }
    }
    
    [self.chatView.tableView reloadData];
}

@end
