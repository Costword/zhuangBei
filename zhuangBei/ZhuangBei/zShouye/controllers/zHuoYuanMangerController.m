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
//#import "ChatRoomViewController.h"
#import "MessageGroupViewController.h"
#import "ServiceManager.h"
#import "zShouyeTuiGuangCell.h"

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
    
    [self loadData];
}


-(void)loadData{
    //获取分类
    [self requestPostWithUrl:kFindListByID paraString:nil success:^(id  _Nonnull response) {
        NSArray * data = response[@"data"][@"group"];
        NSDictionary * dic = data[0];
        NSArray * list = dic[@"list"];
        
        NSMutableArray * array = [NSMutableArray array];
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = list[idx];
            NSString * groupid = dic[@"id"];
            if ([groupid integerValue] == 36 || [groupid integerValue] == 61) {
                [array addObject:dic];
            }
        }];
        
        NSArray * buchangArr = @[
            @{
                @"status":@"2",
                @"id":@"1",
                @"groupname":@"邀请好友",
                @"avatar":@"fenxiang",
            },@{
                @"status":@"2",
                @"id":@"2",
                @"groupname":@"通知公告",
                @"avatar":@"gonggao",
            },@{
                @"status":@"2",
                @"id":@"3",
                @"groupname":@"即将推出",
                @"avatar":@"baokuan",
            },
        ];
        
        [array addObjectsFromArray:buchangArr];
        self.categoryArray = array;
        [self.menuTableView reloadData];
//        NSLog(@"通知结果:%@",imGroupList);
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
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
    return 4;
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
    }else if (indexPath.row ==  2)
    {
        zShouyeTuiGuangCell  * tuiguangcell = [zShouyeTuiGuangCell instanceWithTableView:tableView AndIndexPath:indexPath];
        tuiguangcell.sourceArray = self.tuiguangArray;
        return tuiguangcell;
    }else
    {
        zBaoKuanCell * baoKuanCell = [zBaoKuanCell instanceWithTableView:tableView AndIndexPath:indexPath];
//        __weak typeof(self)weakSelf = self;
        baoKuanCell.baokuanTapback = ^(NSDictionary * _Nonnull sourceDic) {
            NSString * content = @"爆款规则：\n1.有发明专利证书者\n2.功勋币换取爆款推荐\n3.本平台内搜索热度/被关注度最高者";
            [LEEAlert alert].config
            .LeeTitle(@"温馨提示")
//            .LeeContent(content)
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
