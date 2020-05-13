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
#import "LWJiaoLiuContatcsListTableViewCell.h"
#import "LWSystemMessageListViewController.h"
#import "LWJiaoLiuModel.h"
#import "MessageGroupViewController.h"

@interface zJiaoliuController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LWSwitchBarView * switchBarView;
@property (nonatomic, strong) UICollectionView * collectView;
@property (nonatomic, strong) NSMutableArray<LWJiaoLiuModel *> * listDatas_Group;//交流
@property (nonatomic, strong) NSMutableArray * listDatas_Message;
@property (nonatomic, strong) NSMutableArray * listDatas_Contatcs;
@property (nonatomic, strong) UITableView * messageTableView;
@property (nonatomic, strong) UITableView * contatcsTableView;
@property (nonatomic, strong) UITableView * groupTableView;
@property (nonatomic, strong) UIScrollView * mainScrollView;

@property (nonatomic, assign) BOOL  isShow;
@end

@implementation zJiaoliuController

- (void)requestDatas
{
    [self requestPostWithUrl:@"app/imgroupclassify/findListByTypeId" paraString:@{@"typeId":@"1,2,4"} success:^(id  _Nonnull response) {
        NSArray *data = response[@"data"];
        if (data&&data.count > 0) {
            for (NSDictionary*dict  in data) {
                [self.listDatas_Group addObject:[LWJiaoLiuModel modelWithDictionary: dict]];
            }
        }
        [self.collectView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

// 切换switch标签
- (void)clickSwitchBarEvent:(NSInteger)tag
{
    
}

//点击新增
- (void)clickaddBtnBtn
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_switchBarView) {
        [self.mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*self.switchBarView.currentIndex, 1) animated:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isShow = YES;
    [self confiUI];
    [self requestDatas];
}

- (void)confiUI
{
    WEAKSELF(self)
    self.switchBarView = [LWSwitchBarView switchBarView:@[@"交流",@"联系人",@"群组",@"消息",] clickBlock:^(UIButton * _Nonnull btn) {
        [weakself clickSwitchBarEvent:btn.tag];
        [weakself.mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*btn.tag, 1) animated:YES];
    }];
    [self.view addSubview:self.switchBarView];
    [self.switchBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(20);
        make.height.mas_offset(36);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
    }];
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [addBtn setImage:IMAGENAME(@"icon_search") forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(clickaddBtnBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.switchBarView.mas_bottom).mas_offset(10);
    }];
}

#pragma mark ------UITableViewDelegate----------

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _contatcsTableView || tableView == _groupTableView) {
        LWJiaoLiuContatcsListTableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"LWJiaoLiuContatcsListTableViewCell" forIndexPath:indexPath];
        //        NSDictionary *dic = _listDatas_Contatcs[indexPath.section];
        //        NSArray *values = dic.allValues.lastObject;
        //        cell.nameL.text = values[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        LWJiaoLiuMessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWJiaoLiuMessageListTableViewCell" forIndexPath:indexPath];
        cell.nameL.text = @"系统消息";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _contatcsTableView) {
        NSDictionary *dic = _listDatas_Contatcs[section];
        NSArray *values = dic.allValues.lastObject ;
        return _isShow ? values.count : 0;
        return 10;
    }
    if(tableView == _groupTableView){
        return 10;
    }
    
    return  1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    if (tableView == _contatcsTableView) {
    //        return _listDatas_Contatcs.count;
    //    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == _contatcsTableView){
        LWJiaoLiuContatcsSeactionView *seactionview = [[LWJiaoLiuContatcsSeactionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        seactionview.leftL.text = @"默认";
        WEAKSELF(self)
        seactionview.block = ^(BOOL isShow) {
            weakself.isShow = isShow;
            [weakself.contatcsTableView reloadData];
            LWLog(@"--------------%ld--------------%ld",isShow,(long)section);
            WEAKSELF(self)
            [UIView animateWithDuration:0.25 animations:^{
                seactionview.rightBtn.imageView.transform = weakself.isShow ? CGAffineTransformMakeRotation(M_PI):CGAffineTransformIdentity;
            }];
            
        };
        seactionview.rightBtn.selected = _isShow;
        return seactionview;
    }
    return [UIView new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _contatcsTableView == tableView ? 40:0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _messageTableView) {
        LWSystemMessageListViewController *system = [LWSystemMessageListViewController new];
        [self.navigationController pushViewController:system animated:YES];
    }
}
#pragma mark ------UICollectionViewDelegate----------

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWJiaoLiuGroupCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWJiaoLiuGroupCollectionCell" forIndexPath:indexPath];
    LWJiaoLiuModel *model = self.listDatas_Group[indexPath.section];
    cell.nameL.text = model.imGroupList[indexPath.row].groupName;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        LWJiaoLiuGroupCollectionReusableView *seactionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LWJiaoLiuGroupCollectionReusableView" forIndexPath:indexPath];
        LWJiaoLiuModel *model = self.listDatas_Group[indexPath.section];
        seactionView.titleL.text = model.name;
        return seactionView;
    }
    return nil;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.listDatas_Group.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    LWJiaoLiuModel *model = self.listDatas_Group[section];
    return model.imGroupList.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWJiaoLiuModel *listmodel = self.listDatas_Group[indexPath.section];
    imGroupListModel *groupmodel =  listmodel.imGroupList[indexPath.row];
    MessageGroupViewController *messageGroupVC = [MessageGroupViewController new];
    messageGroupVC.m_Group_ID = groupmodel.customId;
    messageGroupVC.m_Group_Name = groupmodel.groupName;
    [self.navigationController pushViewController:messageGroupVC animated:YES];
}


#pragma mark ---------------lazy-------------------
- (UICollectionView *)collectView
{
    if (!_collectView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.minimumLineSpacing = 10;
        flowlayout.minimumInteritemSpacing = 10;
        flowlayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 30);
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
        _collectView.backgroundColor = UIColor.whiteColor;
//        _collectView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDatas)];
    }
    return _collectView;
}

//消息
- (UITableView *)messageTableView
{
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        _messageTableView.rowHeight = 50;
        [_messageTableView registerClass:[LWJiaoLiuMessageListTableViewCell class] forCellReuseIdentifier:@"LWJiaoLiuMessageListTableViewCell"];
        _messageTableView.backgroundColor = UIColor.whiteColor;
    }
    return _messageTableView;
}

//联系人
- (UITableView *)contatcsTableView
{
    if (!_contatcsTableView) {
        _contatcsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _contatcsTableView.delegate = self;
        _contatcsTableView.dataSource = self;
        _contatcsTableView.rowHeight = 66;
        [_contatcsTableView registerClass:[LWJiaoLiuContatcsListTableViewCell class] forCellReuseIdentifier:@"LWJiaoLiuContatcsListTableViewCell"];
        _contatcsTableView.backgroundColor = UIColor.whiteColor;
        _contatcsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _contatcsTableView;
}

//群组
- (UITableView *)groupTableView
{
    if (!_groupTableView) {
        _groupTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _groupTableView.delegate = self;
        _groupTableView.dataSource = self;
        _groupTableView.rowHeight = 66;
        [_groupTableView registerClass:[LWJiaoLiuContatcsListTableViewCell class] forCellReuseIdentifier:@"LWJiaoLiuContatcsListTableViewCell"];
        _groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _groupTableView;
}

- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, self.view.height-60-10)];
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*4, 1000);
        _mainScrollView.backgroundColor = UIColor.whiteColor;
        NSArray *sub = @[self.collectView,self.contatcsTableView,self.groupTableView,self.messageTableView,];
        [_mainScrollView addSubviews:sub];
        for (int i = 0; i< sub.count; i++) {
            [sub[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(_mainScrollView);
                make.width.mas_offset(SCREEN_WIDTH);
                make.height.mas_offset(self.view.height - 60 - TABBAR_HIEGHT-NAVIGATOR_HEIGHT);
                make.left.mas_equalTo(_mainScrollView.mas_left).mas_offset(SCREEN_WIDTH*i);
            }];
        }
        _mainScrollView.scrollEnabled = NO;
    }
    return _mainScrollView;
}

- (NSMutableArray *)listDatas_Group
{
    if (!_listDatas_Group) {
        _listDatas_Group = [[NSMutableArray alloc] init];
//                            WithArray:@[
//            @{@"联盟总群":@[@"平台总群",@"新产品申报",@"爆款申请",@"投诉建议"],},
//            @{@"联盟直播":@[@"品牌直播",@"培训直播",@"论坛直播"],},
//            @{@"技术交流":@[@"特巡警装备",@"警保装备",@"刑侦准备",
//                        @"禁毒装备",@"交警装备",@"监所装备",@"法制装备"],},
//            @{@"地区交流群":@[@"东北地区",@"西北地区",@"华东地区",@"华中地区",
//                         @"东南地区",@"西南地区",@"华北地区",@"华南地区"],},
//            @{@"超级会员群":@[],},
//            @{@"顾问群":@[@"杨建顾问群",],},
//        ]];
        _listDatas_Message = [[NSMutableArray alloc] initWithArray:@[]];
        _listDatas_Contatcs = [[NSMutableArray alloc] initWithArray:@[@{@"默认":@[@"北京真和王宁宁-销售-主管",@"北京真和JoannChen-全公司-商务"]}]];
    }
    return _listDatas_Group;
}

@end
