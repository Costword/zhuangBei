//
//  zGoodsMangerController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zGoodsMangerController.h"
#import "zShouYeLeftMenu.h"
#import "zHuoYuanListCell.h"
#import "zGoodsMenuModel.h"

@interface zGoodsMangerController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * menuTableView;

@property(strong,nonatomic)zShouYeLeftMenu * leftMenu;

@property(strong,nonatomic)NSMutableArray * menuListArray;

@property(strong,nonatomic)NSMutableArray * contentListArray;

@property(strong,nonatomic)NSMutableDictionary * listParmas;

@end

@implementation zGoodsMangerController

-(NSMutableDictionary*)listParmas
{
    if (!_listParmas) {
        _listParmas = [NSMutableDictionary dictionary];
        [_listParmas setObject:@(3) forKey:@"code"];
        [_listParmas setObject:@(20) forKey:@"limt"];
        [_listParmas setObject:@(1) forKey:@"page"];
        [_listParmas setObject:@"" forKey:@"zbid"];
    }
    return _listParmas;
}

-(zShouYeLeftMenu*)leftMenu
{
    if (!_leftMenu) {
        __weak typeof(self)weakSelf = self;
        _leftMenu = [[zShouYeLeftMenu alloc]init];
        _leftMenu.menutapBack = ^(NSInteger index) {
//            [weakSelf.menuTableView reloadData];
        };
        _leftMenu.menuSelectBack = ^(zGoodsMenuModel *goodsModel) {
            weakSelf.listParmas = nil;
            [weakSelf.listParmas setObject:@(goodsModel.typeId) forKey:@"zbid"];
            [weakSelf loadList];
        };
    }
    return _leftMenu;
}

-(UITableView*)menuTableView
{
    if (!_menuTableView) {
        _menuTableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _menuTableView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.allowsSelection = YES;
        _menuTableView.estimatedRowHeight = kWidthFlot(44);
        _menuTableView.estimatedSectionHeaderHeight = 2;
        _menuTableView.estimatedSectionFooterHeight = 2;
        _menuTableView.showsVerticalScrollIndicator = NO;
        _menuTableView.rowHeight = UITableViewAutomaticDimension;
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _menuTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self)weakSelf = self;
    self.view.backgroundColor = [UIColor whiteColor];
    NSString * url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kGoodsMangerMenu];
    self.noContentView.retryTapBack = ^{
        [weakSelf postDataWithUrl:url WithParam:nil];
        [weakSelf loadList];
    };
    [self.view addSubview:self.leftMenu];
    [self.view addSubview:self.menuTableView];
    [self postDataWithUrl:url WithParam:nil];
    [self loadList];
    
    
    
//    [self requestPostWithUrl:listurl paraString:self.listParmas success:^(id  _Nonnull response) {
//        NSString * code = response[@"code"];
//        if ([code integerValue] == 0) {
//            NSDictionary * dic = response[@"page"];
//            NSLog(@"货源列表%@",dic);
//        }else
//        {
//            NSString * msg =response[@"msg"];
//            [[zHud shareInstance]showMessage:msg];
//        }
//
//    } failure:^(NSError * _Nonnull error) {
//        [[zHud shareInstance]showMessage:@"无法连接服务器"];
//    }];
    
    
}

-(void)loadList
{
    NSString * listurl = [NSString stringWithFormat:@"%@%@",kApiPrefix,kGoodsMangerList];
    
    [self postDataWithUrl:listurl WithParam:self.listParmas];
    [[zHud shareInstance]show];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.leftMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
        make.width.mas_equalTo(kWidthFlot(150));
    }];
    [self.menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftMenu.mas_right).offset(0);
       make.top.mas_equalTo(0);
       make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
       make.right.mas_equalTo(0);
    }];
    
    [self.nothingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftMenu.mas_right).offset(0);
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
    zHuoYuanListCell * cell = [zHuoYuanListCell instanceWithTableView:tableView AndIndexPath:indexPath];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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



-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    self.noContentView.alpha = 0;
    if ([url containsString:kGoodsMangerMenu]) {
        NSDictionary * dic = data[@"data"];
        NSString * code = data[@"code"];
        if ([code integerValue] == 0) {
            NSArray * treeList = dic[@"treeList"];
            NSMutableArray * firstArray = [NSMutableArray array];
            NSMutableArray * secondArray = [NSMutableArray array];
            NSMutableArray * thirdArray = [NSMutableArray array];
            [treeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                //遍历一级数组
                NSDictionary * dic =treeList[idx];
                zGoodsMenuModel * model = [zGoodsMenuModel mj_objectWithKeyValues:dic];
                model.indexSection = idx;
                [model.children enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger jdx, BOOL * _Nonnull stop) {
                    //遍历二级数组
                    NSDictionary * sedondDic = model.children[jdx];
                    zGoodsMenuModel * secondModel = [zGoodsMenuModel mj_objectWithKeyValues:sedondDic];
                    secondModel.indexSection = jdx;
                    [secondModel.children enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger zdx, BOOL * _Nonnull stop) {
                        //遍历数组
                        NSDictionary * thirdDic = secondModel.children[zdx];
                        zGoodsMenuModel * thirdModel = [zGoodsMenuModel mj_objectWithKeyValues:thirdDic];
                        thirdModel.indexSection = zdx;
                        [thirdArray addObject:thirdModel];
                    }];
                    secondModel.children = thirdArray;
                    
                    [secondArray addObject:secondModel];
                }];
                model.children = secondArray;
                [firstArray addObject:model];
            }];
            self.menuListArray = firstArray;
            self.leftMenu.menuArray = self.menuListArray;
            NSLog(@"获取货源管理目录%@",firstArray);
        }
        
    }
    if ([url containsString:kGoodsMangerList]) {
        [[zHud shareInstance]hild];
        NSString * code = data[@"code"];
        if ([code integerValue] == 0) {
            NSDictionary * dic = data[@"page"];
            NSLog(@"货源列表%@",dic);
            NSArray * list = dic[@"list"];
            if (list.count==0) {
                self.nothingView.alpha =1;
                [self.view bringSubviewToFront:self.nothingView];
            }else
            {
                self.nothingView.alpha =0;
                self.contentListArray = [[NSMutableArray alloc]initWithArray:list];
            }
            
        }else
        {
            NSString * msg =data[@"msg"];
            [[zHud shareInstance]showMessage:msg];
        }
    }
}


@end
