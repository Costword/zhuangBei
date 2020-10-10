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
#import "LWHuoYuanDaTingModel.h"
#import "LWUpdateVersionManager.h"
@interface LWHuoYuanItemsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView * collectView;
@property (nonatomic, strong) NSMutableArray<LWHuoYuanDaTingModel *> * listDatasMutableArray;
@property (nonatomic, strong) LWUpdateVersionManager *updateManager;

@end

@implementation LWHuoYuanItemsListViewController

- (void)requestDatas
{
    [self requestPostWithUrl:@"app/appzhuangbeitype/list" paraString:@{@"parentId":LWDATA(self.parentId),@"limit":@"100"} success:^(id  _Nonnull response) {
        
        [self.collectView.mj_header endRefreshing];
        [self.collectView.mj_footer endRefreshing];
        
        //        LWLog(@"-------------货源大厅二级列表:%@",response);
        if ([response[@"code"] integerValue] == 0) {
            NSDictionary *page = response[@"page"];
            self.currPage = [page[@"currPage"] integerValue];
            self.totalPage = [page[@"totalPage"] integerValue];
            NSArray *list = page[@"list"];
            if (self.currPage == 1) {
                [self.listDatasMutableArray removeAllObjects];
            }
            
            NSString *title_sub = [self.titleStr substringToIndex:2];
            LWHuoYuanDaTingModel *model = [LWHuoYuanDaTingModel new];
            model.name = [NSString stringWithFormat:@"%@爆款",[title_sub isEqualToString:@"特巡"]?@"特警":title_sub];
            model.isBaoKuan = 1;
            NSString *imageurl = [NSString stringWithFormat:@"https://zhkj001.oss-cn-beijing.aliyuncs.com/%@.jpg",[title_sub isEqualToString:@"特巡"]?@"特警":title_sub];
            imageurl = [imageurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            model.imageUrl = imageurl;
            [self.listDatasMutableArray addObject:model];
            
            for (NSDictionary *dict in list) {
                [self.listDatasMutableArray addObject: [LWHuoYuanDaTingModel modelWithDictionary:dict]];
            }
            
            if (self.currPage >= self.totalPage) {
                [self.collectView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.collectView.mj_footer resetNoMoreData];
            }
        }
        if (self.listDatasMutableArray.count == 0) {
            [self.view bringSubviewToFront:self.nothingView];
        }else{
            [self.view sendSubviewToBack:self.nothingView];
        }
        self.nothingView.alpha = self.listDatasMutableArray.count == 0 ? 1:0;
        self.collectView.mj_footer.hidden = self.listDatasMutableArray.count == 0;
        [self.collectView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self.collectView.mj_header endRefreshing];
        [self.collectView.mj_footer endRefreshing];
        if (self.currPage == 1) {
            [self.collectView.mj_footer setHidden:YES];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    [self confiUI];
    [self requestDatas];
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
    LWHuoYuanDaTingModel *model = self.listDatasMutableArray[indexPath.row];
    if (model.isBaoKuan == 1) {
        [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    }else{
        [cell.bgImageView z_imageWithImageId:model.imagesId];
    }
    cell.descL.text = model.name;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listDatasMutableArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWHuoYuanDaTingModel *model = self.listDatasMutableArray[indexPath.row];
    if (model.isBaoKuan == 1) {
        [self showBaoKuanAleartView];
    }else{
        LWHuoYuanThreeLevelViewController *itemslist = [LWHuoYuanThreeLevelViewController new];
        itemslist.titleStr = model.name;
        itemslist.zbTypeId = model.customId;
        [self.navigationController pushViewController:itemslist animated:YES];
    }
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
        _collectView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
        //        _collectView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
        
    }
    return _collectView;
}

- (NSMutableArray *)listDatasMutableArray
{
    if (!_listDatasMutableArray) {
        _listDatasMutableArray = [[NSMutableArray alloc] init];
    }
    return _listDatasMutableArray;
}
@end
