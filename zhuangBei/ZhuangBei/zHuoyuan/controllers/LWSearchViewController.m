//
//  LWSearchViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWSearchViewController.h"
#import "LWSeachView.h"
#import "LWHuoYuanThreeLevelListTableViewCell.h"
#import "LWHuoYuanDeatilViewController.h"
#import "PPNetworkHelper.h"
@interface LWSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * listDatas;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) LWSeachView * searchView;
@property (nonatomic, strong) NSString * searchValue;

@end

@implementation LWSearchViewController

- (void)requestDatas
{
    [PPNetworkHelper cancelAllRequest];
    
    [ServiceManager requestPostWithUrl:@"app/appzhuangbei/listByQian" Parameters:@{@"searchValue":LWDATA(self.searchValue),@"gysLimit":@"10"} success:^(id  _Nonnull response) {
        
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
            for (NSDictionary *dict in list) {
                [self.listDatas addObject: [LWHuoYuanThreeLevelModel modelWithDictionary:dict]];
            }
            
            if (self.currPage >= self.totalPage) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer resetNoMoreData];
            }
        }
        if (self.listDatas.count == 0) {
            self.nothingView.alpha = 1;
            self.tableView.hidden = YES;
        }
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    //    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ConfiUI];
    self.tableView.mj_footer.hidden = YES;
}

- (void)ConfiUI
{
    WEAKSELF(self)
    self.searchView = [LWSeachView seachview:^(NSInteger tag, NSString * str) {
        if (tag == 1) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            LWLog(@"------------------%@",str);
            weakself.searchValue = str;
            [weakself requestDatas];
        }
    }];
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(STATUS_BAR_HEIGHT);
        make.height.mas_offset(60);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.searchView.mas_bottom).mas_offset(0);
    }];
}

#pragma mark ------UITableViewDelegate----------

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWHuoYuanThreeLevelListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHuoYuanThreeLevelListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model  = self.listDatas[indexPath.row];
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.listDatas.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWHuoYuanDeatilViewController *vc = [LWHuoYuanDeatilViewController new];
    LWHuoYuanThreeLevelModel *model = self.listDatas[indexPath.row];
    vc.modelId = model.zbId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 210;
        [_tableView registerClass:[LWHuoYuanThreeLevelListTableViewCell class] forCellReuseIdentifier:@"LWHuoYuanThreeLevelListTableViewCell"];
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDatas)];
        _tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestDatas)];
        
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
