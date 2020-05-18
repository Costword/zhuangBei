//
//  LWSystemMessageListViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/30.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWSystemMessageListViewController.h"
#import "LWJiaoLiuContatcsListTableViewCell.h"
#import "HYTopBarView.h"
#import "LWSystemListModel.h"

@interface LWSystemMessageListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * friendVerifiTableView;
@property (nonatomic, strong) UITableView * groupTableView;
@property (nonatomic, strong) HYTopBarView * topBarView;
@property (nonatomic, strong) UIScrollView * mainScrollView;
@property (nonatomic, strong) NSMutableArray<LWSystemListModel *> * listdatas_verifi;

@end

@implementation LWSystemMessageListViewController

- (void)requestDatas
{
    [self requestPostWithUrl:@"app/appfriendapply/msgList" Parameters:@{@"page":@(self.currPage)} success:^(id  _Nonnull response) {
        NSDictionary *data = response[@"data"];
        self.currPage = [data[@"currPage"] integerValue];
        self.totalPage = [data[@"totalPage"] integerValue];
        NSArray *list = data[@"list"];
        for (NSDictionary *dic in list) {
            [self.listdatas_verifi addObject:[LWSystemListModel modelWithDictionary:dic]];
        }
        [self.friendVerifiTableView reloadData];
        if (self.listdatas_verifi.count == 0) {
            [[zHud shareInstance] showMessage:@"暂无数据"];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"系统消息";
    [self confiUI];
    [self requestDatas];
}

- (void)confiUI
{
    WEAKSELF(self)
    _topBarView = [HYTopBarView creatTopBarWithDataArr:@[@"好友验证",@"群系统消息"] selectColor:BASECOLOR_TEXTCOLOR callBack:^(NSInteger index) {
        [weakself.mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 1) animated:YES]; 
    }];
    _topBarView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_topBarView];
    CGFloat left = (SCREEN_WIDTH - 200)/2 - 10;
    [_topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(0);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-0);
        make.top.mas_equalTo(self.view.top).mas_offset(10);
        make.height.mas_offset((45));
    }];
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topBarView.mas_bottom).mas_offset(10);
    }];
}

#pragma mark ------UITableViewDelegate----------

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _groupTableView) {
        LWSystemGroupMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWSystemGroupMessageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        LWJiaoLiuContatcsListTableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"LWJiaoLiuContatcsListTableViewCell" forIndexPath:indexPath];
        [cell setBottomLine:1];
        [cell updateForVerifiCell];
        LWSystemListModel *model = self.listdatas_verifi[indexPath.row];
        cell.descL.text = model.content;
        cell.nameL.text = model.user.username;
        cell.timelL.text = model.time;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftBtn.hidden = model.status != 0;
        if (model.status == 1) {
            [cell.rightBtn setTitle:@"已同意" forState:UIControlStateNormal];
        }else if (model.status == 2){
            [cell.rightBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
        }
        return cell;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if (tableView == self.friendVerifiTableView) {
            return self.listdatas_verifi.count;
        }
    
    return  10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (tableView == _messageTableView) {
    //        LWSystemMessageListViewController *system = [LWSystemMessageListViewController new];
    //        [self.navigationController pushViewController:system animated:YES];
    //    }
}

- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, self.view.height-60-10)];
        _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, 1000);
        //        _mainScrollView.backgroundColor = UIColor.redColor;
        NSArray *sub = @[self.friendVerifiTableView,self.groupTableView];
        [_mainScrollView addSubviews:sub];
        for (int i = 0; i< sub.count; i++) {
            [sub[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(_mainScrollView);
                make.width.mas_offset(SCREEN_WIDTH);
                make.height.mas_offset(self.view.height - 60 -NAVIGATOR_HEIGHT);
                make.left.mas_equalTo(_mainScrollView.mas_left).mas_offset(SCREEN_WIDTH*i);
            }];
        }
        _mainScrollView.scrollEnabled = NO;
    }
    return _mainScrollView;
}

- (UITableView *)friendVerifiTableView
{
    if (!_friendVerifiTableView) {
        _friendVerifiTableView = [[UITableView alloc] init];
        _friendVerifiTableView.delegate = self;
        _friendVerifiTableView.dataSource = self;
        _friendVerifiTableView.rowHeight = 90;
        [_friendVerifiTableView registerClass:[LWJiaoLiuContatcsListTableViewCell class] forCellReuseIdentifier:@"LWJiaoLiuContatcsListTableViewCell"];
        _friendVerifiTableView.backgroundColor = UIColor.whiteColor;
        _friendVerifiTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _friendVerifiTableView;
}

- (UITableView *)groupTableView
{
    if (!_groupTableView) {
        _groupTableView = [[UITableView alloc] init];
        _groupTableView.delegate = self;
        _groupTableView.dataSource = self;
        _groupTableView.estimatedRowHeight = 1;
        _groupTableView.rowHeight = UITableViewAutomaticDimension;
        [_groupTableView registerClass:[LWSystemGroupMessageCell class] forCellReuseIdentifier:@"LWSystemGroupMessageCell"];
        _groupTableView.backgroundColor = UIColor.whiteColor;
        _groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _groupTableView;
}
- (NSMutableArray *)listdatas_verifi
{
    if (!_listdatas_verifi) {
        _listdatas_verifi = [[NSMutableArray alloc] init];
    }
    return _listdatas_verifi;
}
@end
