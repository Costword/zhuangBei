//
//  zZhangjieVC.m
//  ZhuangBei
//
//  Created by aa on 2020/7/24.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zZhangjieVC.h"
#import "zVideoListCell.h"
#import "zPlayerViewController.h"
//#import "DIY_RefreshFooter.h"

@interface zZhangjieVC ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UIButton * redButton;

@property(strong,nonatomic)UITableView * menuTableView;

@end

@implementation zZhangjieVC


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
//
//        DIY_RefreshFooter * footer = [DIY_RefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//        _menuTableView.mj_footer = footer;
    }
    return _menuTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.redButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    self.redButton.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.redButton];
    [self.view addSubview:self.menuTableView];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
-(void)setListArray:(NSArray *)listArray
{
    _listArray = listArray;
    if (listArray.count==0) {
        self.nothingView.alpha = 1;
        [self.view bringSubviewToFront:self.nothingView];
    }else
    {
        self.nothingView.alpha = 0;
        [self.menuTableView reloadData];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    zVideoListCell * videoCell = [zVideoListCell instanceWithTableView:tableView AndIndexPath:indexPath];
    videoCell.sourceDic = self.listArray[indexPath.row];
   return videoCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * dic = self.listArray[indexPath.row];
    
    NSString * url = dic[@"ossDownloadSrc"];
    
    zPlayerViewController * plaerVc = [[zPlayerViewController alloc]init];
    plaerVc.url = url;
    [self.navigationController pushViewController:plaerVc animated:YES];
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
