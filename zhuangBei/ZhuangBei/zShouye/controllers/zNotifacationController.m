//
//  zNotifacationController.m
//  ZhuangBei
//  通知公告列表页面
//  Created by aa on 2020/7/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zNotifacationController.h"
#import "zNotifacationCell.h"
#import "DIY_RefreshFooter.h"
#import "zNotifacationDetailController.h"

@interface zNotifacationController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * menuTableView;

@property(strong,nonatomic)NSMutableDictionary * listParams;

@property(strong,nonatomic)NSMutableArray * listArray;
@property(assign,nonatomic)NSInteger  currentPage;

@end

@implementation zNotifacationController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"通知公告";
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
        _menuTableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        
        DIY_RefreshFooter * footer = [DIY_RefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _menuTableView.mj_footer = footer;
    }
    return _menuTableView;
}

-(NSMutableDictionary*)listParams
{
    if (!_listParams) {
        _listParams = [NSMutableDictionary dictionary];
        [_listParams setObject:@"20" forKey:@"limit"];
        [_listParams setObject:@(self.currentPage) forKey:@"page"];
    }
    return _listParams;
}

-(NSMutableArray*)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 1;
    [self.view addSubview:self.menuTableView];
    [self refreshData];
}

-(void)refreshData
{
    self.currentPage = 1;
    [self.listParams setObject:@(self.currentPage) forKey:@"page"];
    [self loadData];
}



-(void)loadMoreData{
    self.currentPage ++;
    [self.listParams setObject:@(self.currentPage) forKey:@"page"];
    [self loadData];
}


-(void)loadData{
    [self requestPostWithUrl:kAppnoticeList paraString:self.listParams success:^(id  _Nonnull response) {
        NSLog(@"当前获取到的通知列表:%@",response);
        NSDictionary * page = response[@"page"];
        NSArray * list = page[@"list"];
        if (self.currentPage==1) {
            [self.listArray removeAllObjects];
            [self.listArray addObjectsFromArray:list];
        }else
        {
            [self.listArray addObjectsFromArray:list];
        }
        if (list.count<20) {
            [self.menuTableView.mj_header endRefreshing];
            [self.menuTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.menuTableView.mj_header endRefreshing];
            [self.menuTableView.mj_footer endRefreshing];
            
        }
        
        [self.menuTableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    zNotifacationCell * notiCell = [zNotifacationCell instanceWithTableView:tableView AndIndexPath:indexPath];
    notiCell.sourceDic = self.listArray[indexPath.row];
   return notiCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    zNotifacationDetailController * notiDetail = [[zNotifacationDetailController alloc]init];
    NSDictionary * dic = self.listArray[indexPath.row];
    NSString *  gongGaoDmName = dic[@"gongGaoDm"];
    notiDetail.gongGaoDm = gongGaoDmName;
    [self.navigationController pushViewController:notiDetail animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}



@end
