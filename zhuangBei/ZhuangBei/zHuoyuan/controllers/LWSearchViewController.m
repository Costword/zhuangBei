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

@interface LWSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * listDatas;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) LWSeachView * searchView;

@end

@implementation LWSearchViewController

- (void)requestDatas
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    });
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
}

- (void)ConfiUI
{
    WEAKSELF(self)
    self.searchView = [LWSeachView seachview:^(NSInteger tag, NSString * str) {
        if (tag == 1) {
            [weakself.navigationController popViewControllerAnimated:YES];
        }else{
            LWLog(@"------------------%@",str);
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
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWHuoYuanDeatilViewController *vc = [LWHuoYuanDeatilViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 200;
        [_tableView registerClass:[LWHuoYuanThreeLevelListTableViewCell class] forCellReuseIdentifier:@"LWHuoYuanThreeLevelListTableViewCell"];
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDatas)];
        _tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestDatas)];

    }
    return _tableView;
}

@end
