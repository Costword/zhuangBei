//
//  zHuoYuanMangerController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/7.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zHuoYuanMangerController.h"
#import "zHuoYuanScrollHeader.h"
#import "zHuoYuanListCell.h"
#import "zNoticeUpDownCell.h"
#import "zCategoryCell.h"
#import "zBaoKuanCell.h"
#import "zInviteController.h"
#import "zNotifacationController.h"
#import "LEEAlert.h"
#import "MessageGroupViewController.h"
#import "ServiceManager.h"
#import "zShouyeTuiGuangCell.h"
#import "LWClientManager.h"
#import "LWLocalChatRecordModel.h"

@interface zHuoYuanMangerController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)zHuoYuanScrollHeader * scrollHeader;
@property(strong,nonatomic)UITableView * menuTableView;

@property(strong,nonatomic)NSArray * categoryArray;

@property(strong,nonatomic)NSArray * notiArray;

//签到状态
@property(strong,nonatomic)NSDictionary * qiandaoDic;

//推广
@property(strong,nonatomic)NSArray * tuiguangArray;

@end

@implementation zHuoYuanMangerController

-(zHuoYuanScrollHeader*)scrollHeader
{
    if (!_scrollHeader) {
        _scrollHeader = [[zHuoYuanScrollHeader alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,(SCREEN_WIDTH-40)*1080/1920)];
        _scrollHeader.bannerArray = @[@"bg_banner_1",@"bg_banner_2",@"bg_banner_3",@"bg_banner_4",@"bg_banner_5"];
    }
    return _scrollHeader;
}

-(UITableView*)menuTableView
{
    if (!_menuTableView) {
        _menuTableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _menuTableView.backgroundColor = [UIColor clearColor];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.allowsSelection = NO;
        _menuTableView.estimatedRowHeight = kWidthFlot(44);
        _menuTableView.estimatedSectionHeaderHeight = 2;
        _menuTableView.estimatedSectionFooterHeight = 2;
        _menuTableView.showsVerticalScrollIndicator = NO;
        _menuTableView.rowHeight = UITableViewAutomaticDimension;
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _menuTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollHeader];
    self.menuTableView.tableHeaderView = self.scrollHeader;
    [self.view addSubview:self.menuTableView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData) name:LOCAL_UNREAD_MSG_LIST_CHANGE_NOTI_KEY object:nil];
    
//    [self loadData];
}

-(void)loadData{
    
    //线程 同步，处理未读数
    dispatch_queue_t customQuue  = dispatch_queue_create("getcagegoryData", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t custonGroup = dispatch_group_create();
    
    dispatch_group_async(custonGroup, customQuue, ^{
        [self requsetCategoryWithGroup:custonGroup];
    });

    dispatch_group_notify(custonGroup,dispatch_get_main_queue(), ^{
        NSLog(@"获取未读数完成");
        [self getMessage];
    });
    //获取分类
    [self getNoticeData];
}
-(void)requsetCategoryWithGroup:(dispatch_group_t)group{
    dispatch_group_enter(group);
    NSArray * buchangArr = @[
        @{
            @"status":@"1",
            @"id":@"36",
            @"groupname":@"联盟总群",
            @"avatar":@"shiti",
        },
        @{
            @"status":@"2",
            @"id":@"1",
            @"groupname":@"通知公告",
            @"avatar":@"gonggao",
        },
        @{
            @"status":@"2",
            @"id":@"2",
            @"groupname":@"邀请好友",
            @"avatar":@"fenxiang",
        },@{
            @"status":@"1",
            @"id":@"62",
            @"groupname":@"爆款",
            @"avatar":@"baokuan",
        },@{
            @"status":@"2",
            @"id":@"4",
            @"groupname":@"功勋币",
            @"avatar":@"gongxun",
        }
    ];
    self.categoryArray = buchangArr;
    dispatch_group_leave(group);
}

-(void)getMessage
{
    
    //联盟总群
    NSArray *  lianmeng =  [[LWClientManager share] getUnReadMessageDataWithRoomId:36];
    //爆款
    NSArray *  baokuan =  [[LWClientManager share] getUnReadMessageDataWithRoomId:62];
    NSInteger  unreadNum = 0;
    NSInteger  bkunreadNum = 0;
    if (lianmeng.count>0) {
        LWLocalChatRecordModel * model =lianmeng[0];
        unreadNum  = model.unreadNum;
    }
    if (baokuan.count>0) {
        LWLocalChatRecordModel * model =baokuan[0];
        bkunreadNum  = model.unreadNum;
    }
    NSMutableArray  * mutArray = [NSMutableArray array];
    [self.categoryArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary * dic = self.categoryArray[idx];
        
        NSMutableDictionary * mutdic = [[NSMutableDictionary alloc]initWithDictionary:dic];
        NSString * name = mutdic[@"groupname"];
        if ([name isEqualToString:@"联盟总群"]) {
            [mutdic setObject:@(unreadNum) forKey:@"badge"];
        }else if ([name isEqualToString:@"爆款"])
        {
            [mutdic setObject:@(bkunreadNum) forKey:@"badge"];
        }else
        {
            [mutdic setObject:@(0) forKey:@"badge"];
        }
        [mutArray addObject:mutdic];
    }];
    self.categoryArray = mutArray;
    [self.menuTableView reloadData];
}

-(void)getNoticeData
{
    //获取通知
    [self requestPostWithUrl:kAppnotice paraString:nil success:^(id  _Nonnull response) {
        //        NSLog(@"快捷结果:%@",response);
        NSArray * data = response[@"data"];
        self.notiArray = data;
        [self.menuTableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    [self getQinadaoState];
    [self getTuiguangData];
}

-(void)getTuiguangData
{
    [ServiceManager requestGetWithUrl:kTuiguang Parameters:nil success:^(id  _Nonnull response) {
        NSArray * data = response[@"data"];
        self.tuiguangArray = data;
        [self.menuTableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)getQinadaoState{
    [ServiceManager requestGetWithUrl:kQiandaoFindOne Parameters:nil success:^(id  _Nonnull response) {
        NSDictionary * data = response[@"data"];
        self.qiandaoDic = data;
        [self.menuTableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)qiandaoRequest{
    [self requestPostWithUrl:kQiandaoSignIn body:nil success:^(id  _Nonnull response) {
        NSDictionary * data = response[@"data"];
        [self getQinadaoState];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //推荐功能需求未定，如确定则为4
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        zNoticeUpDownCell * cell = [zNoticeUpDownCell instanceWithTableView:tableView AndIndexPath:indexPath];
        cell.Array = self.notiArray;
        cell.userStateDic =self.qiandaoDic;
        [cell.qiandaoSignal subscribeNext:^(id  _Nullable x) {
            [self qiandaoRequest];
        }];
        return cell;
    }else if(indexPath.row == 1)
    {
        zCategoryCell * categoryCell = [zCategoryCell instanceWithTableView:tableView AndIndexPath:indexPath];
        categoryCell.Array = self.categoryArray;
        categoryCell.categoryTapBack = ^(NSDictionary * _Nonnull dic) {
            NSLog(@"%@",dic);
            NSString * status = dic[@"status"];
            NSString * myid = dic[@"id"];
            if ([status integerValue] != 2) {
                //进入聊天详情
                //                NSString * roomId = dic[@"id"];
                NSString* roomName = dic[@"groupname"];
                //                [self.navigationController pushViewController:[MessageGroupViewController chatRoomViewControllerWithRoomId:myid roomName:roomName roomType:(LWChatRoomTypeGroup) extend:nil] animated:YES];
                
                [self.navigationController pushViewController:[MessageGroupViewController chatRoomViewControllerWithRoomId:myid roomName:roomName roomType:(LWChatRoomTypeGroup) extend:nil] animated:YES];
                
            }else
            {
                //进入其他页面
                if ([myid integerValue]==1) {
                    //邀请好友
                    zInviteController * inviteVC = [[zInviteController alloc]init];
                    [self.navigationController pushViewController:inviteVC animated:YES];
                }else if ([myid integerValue]==2)
                {
                    //通知公告
                    zNotifacationController * notiVC = [[zNotifacationController alloc]init];
                    [self.navigationController pushViewController:notiVC animated:YES];
                }else
                {
                    //即将推出
                }
            }
        };
        return categoryCell;
    }
//    else if (indexPath.row ==  2)
//    {
//        zShouyeTuiGuangCell  * tuiguangcell = [zShouyeTuiGuangCell instanceWithTableView:tableView AndIndexPath:indexPath];
//        tuiguangcell.sourceArray = self.tuiguangArray;
//        return tuiguangcell;
//    }
else
    {
        zBaoKuanCell * baoKuanCell = [zBaoKuanCell instanceWithTableView:tableView AndIndexPath:indexPath];
        baoKuanCell.baokuanTapback = ^(NSDictionary * _Nonnull sourceDic) {
            NSString * content = @"爆款规则：\n1.有发明专利证书者\n2.功勋币换取爆款推荐\n3.本平台内搜索热度/被关注度最高者";
            [LEEAlert alert].config
            .LeeTitle(@"温馨提示")
            .LeeAddContent(^(UILabel * _Nonnull label) {
                label.textAlignment = NSTextAlignmentLeft;
                label.text = content;
            })
            .LeeCancelAction(@"取消", ^{
                // 点击事件Block
            })
            .LeeAction(@"进入群聊", ^{
                // 点击事件Block
                [self.navigationController pushViewController:[MessageGroupViewController chatRoomViewControllerWithRoomId:@"62" roomName:@"爆款" roomType:(LWChatRoomTypeGroup) extend:nil] animated:YES];
                
            })
            .LeeShow();
        };
        return baoKuanCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


-(void)gotoLogInVC
{
    zUserModel * model = [zUserInfo shareInstance].userInfo;
    NSDictionary * userInfo = [model mj_keyValues];
    
    NSString * userInfojson = [userInfo jsonString];
    
    NSString * content = [NSString stringWithFormat:@"您的信息\n%@",userInfojson];
    [LEEAlert alert].config
    .LeeTitle(@"温馨提示")
    .LeeContent(content)
    .LeeCancelAction(@"取消", ^{
        // 点击事件Block
    })
    .LeeAction(@"确认", ^{
        // 点击事件Block
    })
    .LeeShow();
    
    //    zDengluController * dlVC = [[zDengluController alloc]init];
    //    dlVC.title = @"登陆";
    //    [self.navigationController pushViewController:dlVC animated:YES];
}




@end
