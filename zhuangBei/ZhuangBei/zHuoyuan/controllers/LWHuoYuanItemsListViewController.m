//
//  LWHuoYuanItemsListViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/26.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanItemsListViewController.h"
#import "LWHuoYuanItemListCollectionViewCell.h"
#import "LWHuoYuanThreeLevelViewController.h"

@interface LWHuoYuanItemsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView * collectView;
@property (nonatomic, strong) NSMutableArray * listDatasMutableArray;

@end

@implementation LWHuoYuanItemsListViewController

- (void)requestDatas
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_collectView.mj_header endRefreshing];
        [_collectView.mj_footer endRefreshing];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    [self confiUI];
}

- (void)confiUI
{
    [self.view addSubview:self.collectView];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWHuoYuanItemListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWHuoYuanItemListCollectionViewCell" forIndexPath:indexPath];
    cell.descL.text = self.listDatasMutableArray[indexPath.row];
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listDatasMutableArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWHuoYuanThreeLevelViewController *itemslist = [LWHuoYuanThreeLevelViewController new];
    itemslist.titleStr = self.listDatasMutableArray[indexPath.row];
    [self.navigationController pushViewController:itemslist animated:YES];
}

- (UICollectionView *)collectView
{
    if (!_collectView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10;
        flowlayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat item_w = (SCREEN_WIDTH-50)/2;
        flowlayout.itemSize = CGSizeMake(item_w, item_w*0.8);
        _collectView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowlayout];
        _collectView.backgroundColor = UIColor.whiteColor;
        _collectView.delegate = self;
        _collectView.dataSource = self;
        [_collectView registerClass:[LWHuoYuanItemListCollectionViewCell class] forCellWithReuseIdentifier:@"LWHuoYuanItemListCollectionViewCell"];
        _collectView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDatas)];
        _collectView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestDatas)];

    }
    return _collectView;
}

- (NSMutableArray *)listDatasMutableArray
{
    if (!_listDatasMutableArray) {
        _listDatasMutableArray = [[NSMutableArray alloc] init];
#warning +++++++++++testdatas
        [self.listDatasMutableArray addObjectsFromArray:@[@"智慧警保管理软件",@"公安专用奖励品",@"特种柜体",@"暖警装备",]];
    }
    return _listDatasMutableArray;
}
@end
