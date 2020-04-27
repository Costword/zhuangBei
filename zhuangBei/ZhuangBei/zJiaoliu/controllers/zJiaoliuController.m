//
//  zJiaoliuController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zJiaoliuController.h"
#import "LWSwitchBarView.h"
#import "LWJiaoLiuGroupCollectionReusableView.H"

@interface zJiaoliuController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LWSwitchBarView * switchBarView;
@property (nonatomic, strong) UICollectionView * collectView;
@property (nonatomic, strong) NSMutableArray * listDatas_Group;
@property (nonatomic, strong) NSMutableArray * listDatas_Message;
@property (nonatomic, strong) NSMutableArray * listDatas_Contatcs;
@property (nonatomic, strong) UITableView * messageTableView;
@property (nonatomic, strong) UITableView * contatcsTableView;
@property (nonatomic, strong) UIScrollView * mainScrollView;

@end

@implementation zJiaoliuController

// 切换switch标签
- (void)clickSwitchBarEvent:(NSInteger)tag
{
    
}

//点击搜索按钮
- (void)clickSearchBtn
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self confiUI];
}


- (void)confiUI
{
    WEAKSELF(self)
    self.switchBarView = [LWSwitchBarView switchBarView:@[@"消息",@"联系人",@"群组"] clickBlock:^(UIButton * _Nonnull btn) {
        [weakself clickSwitchBarEvent:btn.tag];
        [weakself.mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*btn.tag, 1) animated:YES];
    }];
    [self.view addSubview:self.switchBarView];
    [self.switchBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(10);
        make.height.mas_offset(40);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(60);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-60);
    }];
    
    UIButton *searchBtn = [UIButton new];
    //    [searchBtn setImage:IMAGENAME(@"") forState:UIControlStateNormal];
    searchBtn.backgroundColor = UIColor.redColor;
    [searchBtn addTarget:self action:@selector(clickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.switchBarView.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.switchBarView.mas_centerY);
        make.width.mas_offset(30);
        make.height.mas_offset(30);
    }];
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.switchBarView.mas_bottom).mas_offset(10);
        make.height.mas_offset(self.view.height - 60 );
    }];
}

#pragma mark ------UITableViewDelegate----------

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentifier = @"cell1";
    if (tableView == _contatcsTableView) {
        indentifier = @"cell2";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    cell.textLabel.text = indentifier;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

#pragma mark ------UICollectionViewDelegate----------

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWJiaoLiuGroupCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWJiaoLiuGroupCollectionCell" forIndexPath:indexPath];
    NSDictionary *dic = self.listDatas_Group[indexPath.section];
    NSArray *values = dic.allValues.lastObject;
    cell.nameL.text = values[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    LWJiaoLiuGroupCollectionReusableView *seactionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LWJiaoLiuGroupCollectionReusableView" forIndexPath:indexPath];
    NSDictionary *dic = self.listDatas_Group[indexPath.section];
    NSString *key = dic.allKeys.lastObject;
    seactionView.titleL.text = key;
    return seactionView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.listDatas_Group.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *dic = self.listDatas_Group[section];
    NSArray *values = dic.allValues.lastObject;
    return values.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UICollectionView *)collectView
{
    if (!_collectView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10;
        flowlayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 60);
        flowlayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
        flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat item_w = (SCREEN_WIDTH-50)/2;
        flowlayout.itemSize = CGSizeMake(item_w, item_w*0.7);
        _collectView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowlayout];
        _collectView.backgroundColor = UIColor.whiteColor;
        _collectView.delegate = self;
        _collectView.dataSource = self;
        [_collectView registerClass:[LWJiaoLiuGroupCollectionCell class] forCellWithReuseIdentifier:@"LWJiaoLiuGroupCollectionCell"];
        [_collectView registerClass:[LWJiaoLiuGroupCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LWJiaoLiuGroupCollectionReusableView"];
    }
    return _collectView;
}

- (UITableView *)messageTableView
{
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc] init];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        _messageTableView.rowHeight = 50;
        [_messageTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
        _mainScrollView.backgroundColor = UIColor.whiteColor;
    }
    return _messageTableView;
}

- (UITableView *)contatcsTableView
{
    if (!_contatcsTableView) {
        _contatcsTableView = [[UITableView alloc] init];
        _contatcsTableView.delegate = self;
        _contatcsTableView.dataSource = self;
        _contatcsTableView.rowHeight = 50;
        [_contatcsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
        _contatcsTableView.backgroundColor = UIColor.brownColor;
    }
    return _contatcsTableView;
}

- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, self.view.height-60)];
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, self.view.height-60);
        _mainScrollView.backgroundColor = UIColor.blueColor;
        NSArray *sub = @[self.messageTableView,self.contatcsTableView,self.collectView];
        [_mainScrollView addSubviews:sub];
        for (int i = 0; i< sub.count; i++) {
            [sub[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(_mainScrollView);
                make.width.mas_offset(SCREEN_WIDTH);
                make.height.mas_offset(self.view.height - 60);
                make.left.mas_equalTo(_mainScrollView.mas_left).mas_offset(SCREEN_WIDTH*i);
            }];
        }
//        _messageTableView.pagingEnabled = YES;
        _mainScrollView.showsHorizontalScrollIndicator = YES;
    }
    return _mainScrollView;
}

- (NSMutableArray *)listDatas_Group
{
    if (!_listDatas_Group) {
        _listDatas_Group = [[NSMutableArray alloc] initWithArray:@[
            @{@"联盟总群":@[@"平台总群",@"新产品申报",@"爆款申请",@"投诉建议"],},
            @{@"联盟直播":@[@"品牌直播",@"培训直播",@"论坛直播"],},
            @{@"技术交流":@[@"特巡警装备",@"警保装备",@"刑侦准备",
                        @"禁毒装备",@"交警装备",@"监所装备",@"法制装备"],},
            @{@"地区交流群":@[@"东北地区",@"西北地区",@"华东地区",@"华中地区",
                         @"东南地区",@"西南地区",@"华北地区",@"华南地区"],
              @"超级会员群":@[],
              @"顾问群":@[@"杨建顾问群",],
            },
            
        ]];
        _listDatas_Message = [[NSMutableArray alloc] init];
        _listDatas_Contatcs = [[NSMutableArray alloc] init];
    }
    return _listDatas_Group;
}
@end
