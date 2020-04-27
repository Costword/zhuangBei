//
//  zHyController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zHyController.h"
#import "LWHuoYuanListCollectionViewCell.h"
#import "LWHuoYuanItemsListViewController.h"

@interface zHyController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView * collectView;
@property (nonatomic, strong) NSMutableArray * listDatasMutableArray;

@end

@implementation zHyController

- (void)clickSearchBtn:(UIButton *)sender
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self confiUI];
}

- (void)confiUI
{
    [self.view addSubview:self.collectView];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [seachBtn setImage:IMAGENAME(@"") forState:UIControlStateNormal];
    [seachBtn addTarget:self action:@selector(clickSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seachBtn];
    seachBtn.backgroundColor = UIColor.redColor;
    seachBtn.frame = CGRectMake(0, 0, 30, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:seachBtn];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWHuoYuanListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWHuoYuanListCollectionViewCell" forIndexPath:indexPath];
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
    LWHuoYuanItemsListViewController *itemslist = [LWHuoYuanItemsListViewController new];
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
        [_collectView registerClass:[LWHuoYuanListCollectionViewCell class] forCellWithReuseIdentifier:@"LWHuoYuanListCollectionViewCell"];
    }
    return _collectView;
}

- (NSMutableArray *)listDatasMutableArray
{
    if (!_listDatasMutableArray) {
        _listDatasMutableArray = [[NSMutableArray alloc] init];
#warning +++++++++++testdatas
        [self.listDatasMutableArray addObjectsFromArray:@[@"特巡警装备/软件",@"警保装备/软件",@"刑侦装备/软件",@"禁毒装备/软件",@"交警装备/软件",@"监所装备/软件",@"法制装备/软件"]];
    }
    return _listDatasMutableArray;
}
@end
