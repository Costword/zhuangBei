//
//  LWGongYingShangListViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWGongYingShangListViewController.h"
#import "LWGongYingShangListTableViewCell.h"

@interface LWGongYingShangListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * listDatas;
@end

@implementation LWGongYingShangListViewController

- (void)requestDatas
{
    [ServiceManager requestPostWithUrl:@"app/appzhuangbei/listByQian" paraString:@{@"Id":LWDATA(self.zbTypeId),@"gysLimit":@(100),@"page":@(self.currPage),@"searchGYSName":@"",@"zbId":LWDATA(self.zbId)} success:^(id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([response[@"code"] integerValue] == 0) {
            NSDictionary *page = response[@"page"];
            self.currPage = [page[@"currPage"] integerValue];
            self.totalPage = [page[@"totalPage"] integerValue];
            NSArray *list = page[@"list"];
            if (self.currPage == 1) {
                [self.listDatas removeAllObjects];
            }
//            for (NSDictionary *dict in list) {
//                [self.listDatas addObject: [LWHuoYuanThreeLevelModel modelWithDictionary:dict]];
//            }
            
//            if (self.currPage >= self.totalPage) {
//                [self.tableView.mj_footer endRefreshingWithNoMoreData];
//            }else{
//                [self.tableView.mj_footer resetNoMoreData];
//            }
        }
        if (self.listDatas.count == 0) {
            [self.view bringSubviewToFront:self.nothingView];
        }else{
            [self.view sendSubviewToBack:self.nothingView];
        }
        self.nothingView.alpha = self.listDatas.count == 0 ? 1:0;
        self.tableView.mj_footer.hidden = self.listDatas.count == 0;
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (self.currPage == 1) {
                   [self.tableView.mj_footer setHidden:YES];
               }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"供应商列表";
    [self confiUI];
    [self requestDatas];
}

- (void)confiUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark ------UITableViewDelegate----------

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWGongYingShangListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWGongYingShangListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWGongYingShangListViewController *vc = [LWGongYingShangListViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[LWGongYingShangListTableViewCell class] forCellReuseIdentifier:@"LWGongYingShangListTableViewCell"];
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        _tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];

    }
    return _tableView;
}

- (NSMutableArray *)listDatas
{
    if (!_listDatas) {
        _listDatas = [[NSMutableArray alloc] init];
    }
    return _listDatas;
}
@end
