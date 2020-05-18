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
#import "ChatRoomViewController.h"
#import "LWJiaoLiuAddAlearView.h"
#import "LWAddFriendOrGroupViewController.h"
#import "LWUserGroupManagerViewController.h"

@interface zJiaoliuController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) LWSwitchBarView * switchBarView;
@property (nonatomic, strong) UICollectionView * collectView;
@property (nonatomic, strong) NSMutableArray<imGroupListModel *> * listDatas_Group;//群组
@property (nonatomic, strong) NSMutableArray<LWJiaoLiuModel *> * listDatas_JiaoLiu;//交流
@property (nonatomic, strong) NSMutableArray * listDatas_Message;
@property (nonatomic, strong) NSMutableArray<friendListModel *> * listDatas_Contatcs;
@property (nonatomic, strong) UITableView * messageTableView;
@property (nonatomic, strong) UITableView * contatcsTableView;
@property (nonatomic, strong) UITableView * groupTableView;
@property (nonatomic, strong) UIScrollView * mainScrollView;
@property (nonatomic, strong) LWJiaoLiuAddAlearView * alearView;

@end

@implementation zJiaoliuController
//交流
- (void)requestJiaoLiuDatas
{
    [self requestPostWithUrl:@"app/imgroupclassify/findListByTypeId" paraString:@{@"typeId":@"1,2,4"} success:^(id  _Nonnull response) {
        NSArray *data = response[@"data"];
        if (data&&data.count > 0) {
            for (NSDictionary*dict  in data) {
                [self.listDatas_JiaoLiu addObject:[LWJiaoLiuModel modelWithDictionary: dict]];
            }
        }
        [self.collectView reloadData];
        [[zHud shareInstance] hild];
    } failure:^(NSError * _Nonnull error) {
        [[zHud shareInstance] hild];
    }];
}

//群组、联系人
- (void)requestDatas
{
    [self requestJiaoLiuDatas];
    
    [self requestPostWithUrl:@"app/appfriendtype/getFriendTypeAndFriendList" Parameters:@{} success:^(id  _Nonnull response) {
        NSDictionary *data = response[@"data"];

        NSArray *friend = data[@"friend"];
        for (NSDictionary*dict  in friend) {
            [self.listDatas_Contatcs addObject:[friendListModel modelWithDictionary: dict]];
        }
        NSArray *group = data[@"group"];
        for (NSDictionary*dict  in group) {
            [self.listDatas_Group addObject:[imGroupListModel modelWithDictionary: dict]];
        }
        [self.groupTableView reloadData];
        [self.contatcsTableView reloadData];
        [[zHud shareInstance] hild];
    } failure:^(NSError * _Nonnull error) {
        [[zHud shareInstance] hild];
    }];
}

// 切换switch标签
- (void)clickSwitchBarEvent:(NSInteger)tag
{
    [self.mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*tag, 1) animated:YES];
}

//点击新增
- (void)clickaddBtnBtn
{
    [self.alearView showView];
    WEAKSELF(self)
    self.alearView.block = ^(NSInteger index) {
        if (index == 1) {
            [weakself.navigationController pushViewController:[LWAddFriendOrGroupViewController new] animated:YES];
        }else if (index == 2){
            [weakself.navigationController pushViewController:[LWUserGroupManagerViewController new] animated:YES];
        }
    };
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_switchBarView) {
        [self.mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*self.switchBarView.currentIndex, 1) animated:NO];
    }
    self.tabBarItem.badgeValue = @"28";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self confiUI];
    [self requestDatas];
    
    [self.nothingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(36+40+NAVIGATOR_HEIGHT);
      }];
    [self.noContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.nothingView);
    }];
}

- (void)confiUI
{
    WEAKSELF(self)
    self.switchBarView = [LWSwitchBarView switchBarView:@[@"交流",@"联系人",@"群组",@"消息",] clickBlock:^(UIButton * _Nonnull btn) {
        [weakself clickSwitchBarEvent:btn.tag];
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

        if (tableView == _groupTableView) {
            imGroupListModel *model = self.listDatas_Group[indexPath.row];
            cell.nameL.text = model.groupName;
        }else{
            friendListModel *listmodel = self.listDatas_Contatcs[indexPath.section];
            friendItemModel *itemModel = listmodel.list[indexPath.row];
            cell.nameL.text = itemModel.username;
        }
        
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
        friendListModel *listmodel = self.listDatas_Contatcs[section];
        return listmodel.isShow ? listmodel.list.count : 0;
    }
    if(tableView == _groupTableView){
        return self.listDatas_Group.count;
    }
    return  1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _contatcsTableView) {
        return self.listDatas_Contatcs.count;
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == _contatcsTableView){
       __block LWJiaoLiuContatcsSeactionView *seactionview = [[LWJiaoLiuContatcsSeactionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        friendListModel *listmodel = self.listDatas_Contatcs[section];
        seactionview.leftL.text = listmodel.groupname;
        WEAKSELF(self)
        seactionview.block = ^(BOOL isShow) {
//            weakself.isShow = isShow;
            listmodel.isShow = isShow;
            [weakself.contatcsTableView reloadData];
//            [weakself.contatcsTableView reloadSection:section withRowAnimation:(UITableViewRowAnimationNone)];
            [UIView animateWithDuration:0.25 animations:^{
                seactionview.rightBtn.imageView.transform = listmodel.isShow ? CGAffineTransformMakeRotation(M_PI):CGAffineTransformIdentity;
            }];
            
        };
        seactionview.rightBtn.selected = listmodel.isShow;
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
    }else if(tableView == _contatcsTableView){
        friendListModel *listmodel = self.listDatas_Contatcs[indexPath.section];
        friendItemModel *itemmodel = listmodel.list[indexPath.row];
         ChatRoomViewController *vc= [ChatRoomViewController chatRoomViewControllerWithRoomId:itemmodel.customId roomName:itemmodel.username roomType:(LWChatRoomTypeOneTOne) extend:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tableView == _groupTableView){
        imGroupListModel *groupmodel = self.listDatas_Group[indexPath.row];
        [self pushToGroupRoom:groupmodel.customId groupname:groupmodel.groupName];
    }
}
#pragma mark ------UICollectionViewDelegate----------

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWJiaoLiuGroupCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWJiaoLiuGroupCollectionCell" forIndexPath:indexPath];
    LWJiaoLiuModel *model = self.listDatas_JiaoLiu[indexPath.section];
    cell.nameL.text = model.imGroupList[indexPath.row].groupName;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        LWJiaoLiuGroupCollectionReusableView *seactionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LWJiaoLiuGroupCollectionReusableView" forIndexPath:indexPath];
        LWJiaoLiuModel *model = self.listDatas_JiaoLiu[indexPath.section];
        seactionView.titleL.text = model.name;
        return seactionView;
    }
    return nil;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.listDatas_JiaoLiu.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    LWJiaoLiuModel *model = self.listDatas_JiaoLiu[section];
    return model.imGroupList.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LWJiaoLiuModel *listmodel = self.listDatas_JiaoLiu[indexPath.section];
    imGroupListModel *groupmodel =  listmodel.imGroupList[indexPath.row];
    [self pushToGroupRoom:groupmodel.customId groupname:groupmodel.groupName];
}


/// 跳转群聊室
/// @param groupid 群聊id
/// @param groupname 群聊n名称
- (void)pushToGroupRoom:(NSString *)groupid groupname:(NSString *)groupname
{
    [self.navigationController pushViewController:[MessageGroupViewController chatRoomViewControllerWithRoomId:groupid roomName:groupname roomType:(LWChatRoomTypeGroup) extend:nil] animated:YES];
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

        _listDatas_Message = [[NSMutableArray alloc] initWithArray:@[]];
        _listDatas_Contatcs = [[NSMutableArray alloc] init];
    }
    return _listDatas_Group;
}


- (NSMutableArray *)listDatas_JiaoLiu
{
    if (!_listDatas_JiaoLiu) {
        _listDatas_JiaoLiu = [[NSMutableArray alloc] init];
    }
    return _listDatas_JiaoLiu;
}
- (LWJiaoLiuAddAlearView *)alearView
{
    if (!_alearView) {
        _alearView = [[LWJiaoLiuAddAlearView alloc] init];
    }
    return _alearView;
}
@end
