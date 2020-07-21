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

@interface zHuoYuanMangerController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)zHuoYuanScrollHeader * scrollHeader;
@property(strong,nonatomic)UITableView * menuTableView;

@end

@implementation zHuoYuanMangerController

-(zHuoYuanScrollHeader*)scrollHeader
{
    if (!_scrollHeader) {
        _scrollHeader = [[zHuoYuanScrollHeader alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, SCREEN_WIDTH * 9/16)];
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
        _menuTableView.allowsSelection = YES;
        _menuTableView.estimatedRowHeight = kWidthFlot(44);
        _menuTableView.estimatedSectionHeaderHeight = 2;
        _menuTableView.estimatedSectionFooterHeight = 2;
        _menuTableView.showsVerticalScrollIndicator = NO;
        _menuTableView.rowHeight = UITableViewAutomaticDimension;
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _menuTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//        _menuTableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _menuTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollHeader];
    self.menuTableView.tableHeaderView = self.scrollHeader;
    [self.view addSubview:self.menuTableView];
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
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        zNoticeUpDownCell * cell = [zNoticeUpDownCell instanceWithTableView:tableView AndIndexPath:indexPath];
        return cell;
    }else
    {
        zCategoryCell * categoryCell = [zCategoryCell instanceWithTableView:tableView AndIndexPath:indexPath];
        return categoryCell;
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
