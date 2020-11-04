//
//  zGXDetailViewController.m
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zGXDetailViewController.h"
#import "zGXDetailModel.h"
#import "zGXBCell.h"

@interface zGXDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * menuTableView;

@property(assign,nonatomic)NSInteger currentPage;

@property(strong,nonatomic)NSMutableArray * menuListArray;

@property(strong,nonatomic)NSMutableArray * contentListArray;

@property(strong,nonatomic)NSMutableDictionary * listParmas;

@end

@implementation zGXDetailViewController

-(NSMutableDictionary*)listParmas
{
    if (!_listParmas) {
        _listParmas = [NSMutableDictionary dictionary];
        [_listParmas setObject:@(20) forKey:@"limit"];
        [_listParmas setObject:@(1) forKey:@"page"];
    }
    return _listParmas;
}

-(NSMutableArray*)contentListArray
{
    if (!_contentListArray) {
        _contentListArray = [NSMutableArray array];
    }
    return _contentListArray;
}

-(UITableView*)menuTableView
{
    if (!_menuTableView) {
        _menuTableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _menuTableView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
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
        _menuTableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _menuTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.menuTableView];
    [self loadList];

}


-(void)loadList
{
    
//http://test.110zhuangbei.com:8105/app/app/appusermeritoriouscoinrecord/findMyselfRecordPage?limit=20&page=1
//http://test.110zhuangbei.com:8105/app/app/appusermeritoriouscoinrecord/findMyselfRecordPage?page=1&code=3&lastNode=&zbid=&limit=20
    
    [self  requestGetWithUrl:zGXBDetail paraString:self.listParmas success:^(id  _Nonnull response) {
        [[zHud shareInstance]hild];
        NSString * code = response[@"code"];
        if ([code integerValue] == 0) {
            NSDictionary * dic = response[@"page"];
            NSLog(@"货源列表%@",dic);
            NSArray * list = dic[@"list"];
            [self.menuTableView.mj_header endRefreshing];
            if (list.count==0) {
                if (self.currentPage == 1) {
                    self.nothingView.alpha =1;
                    [self.view bringSubviewToFront:self.nothingView];
                }else
                {
                    [self.menuTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }else
            {
                if (list.count<20) {
                    [self.menuTableView.mj_footer endRefreshingWithNoMoreData];
                    [self.menuTableView.mj_footer setHidden:YES];
                }else
                {
                    [self.menuTableView.mj_footer endRefreshing];
                }
                if (self.currentPage == 1) {
                    [self.contentListArray removeAllObjects];
                }
                self.nothingView.alpha =0;
                [self.contentListArray removeAllObjects];
                [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSDictionary * dic = list[idx];
                    zGXDetailModel * model = [zGXDetailModel mj_objectWithKeyValues:dic];
                    [self.contentListArray addObject:model];
                }];
                [self.menuTableView reloadData];
            }
        }else
        {
            NSString * msg =response[@"msg"];
            [[zHud shareInstance]showMessage:msg];
        }

    } failure:^(NSError * _Nonnull error) {
        [[zHud shareInstance]hild];
    }];
    
//    [self requestPostWithUrl:zGXBDetail paraString:self.listParmas success:^(id  _Nonnull response) {
//            } failure:^(NSError * _Nonnull error)
//    {
//
//    }];
    [[zHud shareInstance]show];
}


-(void)refreshData
{
    [_listParmas setObject:@(1) forKey:@"page"];
    [self loadList];
}

-(void)loadMoreData
{
    self.currentPage ++ ;
    [_listParmas setObject:@(self.currentPage) forKey:@"page"];
    [self loadList];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    

    [self.menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
       make.top.mas_equalTo(0);
       make.bottom.mas_equalTo(-(KstatusBarHeight+44+LL_TabbarSafeBottomMargin));
       make.right.mas_equalTo(0);
    }];
    
    [self.nothingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.right.mas_equalTo(0);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentListArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    zGXBCell * cell = [zGXBCell instanceWithTableView:tableView AndIndexPath:indexPath];
    zGXDetailModel * model =  self.contentListArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    self.noContentView.alpha = 1;
    [self.view bringSubviewToFront:self.noContentView];
    
    if ([url containsString:kGoodsMangerMenu]) {
        [[zHud shareInstance]hild];
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
            
        }
    }

    if ([url containsString:kGoodsMangerList]) {
        [[zHud shareInstance]hild];
        if (err.code == -1001) {
            [[zHud shareInstance] showMessage:@"无法连接服务器"];
        }
    }
}
@end
