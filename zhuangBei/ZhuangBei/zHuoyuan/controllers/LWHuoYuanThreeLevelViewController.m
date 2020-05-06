//
//  LWHuoYuanThreeLevelViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanThreeLevelViewController.h"
#import "LWHuoYuanThreeLevelListTableViewCell.h"
#import "LWGongYingShangListViewController.h"
#import "LWHuoYuanDaTingModel.h"
#import "LWHuoYuanDeatilViewController.h"

@interface LWHuoYuanThreeLevelViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray<LWHuoYuanThreeLevelModel *> * listDatas;
@property (nonatomic, strong) UITableView * tableView;
@end

// 货源大厅三级页面
@implementation LWHuoYuanThreeLevelViewController
- (void)requestDatas
{
    [ServiceManager requestPostWithUrl:@"app/appzhuangbei/listByQian" Parameters:@{@"id":LWDATA(self.zbTypeId),@"gysLimit":@"10"} success:^(id  _Nonnull response) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
//        LWLog(@"-------------货源大厅三级列表:%@",response);
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titleStr;
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
    LWHuoYuanThreeLevelListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWHuoYuanThreeLevelListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model  = self.listDatas[indexPath.row];
    WEAKSELF(self)
    cell.clickItemsBlock = ^(gysListModel * _Nonnull itemmodel) {
        LWHuoYuanDeatilViewController *vc = [LWHuoYuanDeatilViewController new];
        LWHuoYuanThreeLevelModel *model = self.listDatas[indexPath.row];
        vc.modelId = model.zblxId;
        vc.gongYingShangDm = itemmodel.customId;
        vc.zhuangBeiDm = model.zbId;
        vc.zhuangBeiLx = model.zblxName;
        vc.zhuangBeiName = model.zbName;
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.listDatas.count;
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
