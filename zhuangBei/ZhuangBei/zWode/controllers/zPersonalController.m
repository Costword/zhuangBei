//
//  zPersonalController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zPersonalController.h"
#import "zcityCell.h"
#import "zCityEditFooter.h"
#import "zPersonalModel.h"
#import "zPersonalHeader.h"

@interface zPersonalController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * persoanTableView;
@property(strong,nonatomic)zPersonalHeader * headerView;
@property(strong,nonatomic)zCityEditFooter * footView;

@property(strong,nonatomic)NSMutableArray * persoanArray;

@property(assign,nonatomic)BOOL canEdit;

@end

@implementation zPersonalController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(NSMutableArray*)persoanArray
{
    if (!_persoanArray) {
        NSArray * persoanl = @[
            @{
                @"name":@"姓名（必填）",
                @"content":@"阿秀",
                @"canShow":@(0)
            },@{
                @"name":@"性别（必填）",
                @"content":@"男",
                @"canShow":@(0)
            },@{
                @"name":@"手机号码",
                @"content":@"15516562513",
                @"canShow":@(1)
            },@{
                @"name":@"出生日期",
                @"content":@"5月19日",
                @"canShow":@(1)
            },@{
                @"name":@"E-mail",
                @"content":@"1213791064@qq.com",
                @"canShow":@(0)
            },@{
                @"name":@"籍贯",
                @"content":@"河南省",
                @"canShow":@(0)
            },@{
                @"name":@"学历",
                @"content":@"本科",
                @"canShow":@(1)
            },@{
                @"name":@"工作年限",
                @"content":@"5年",
                @"canShow":@(1)
            },@{
                @"name":@"公司类型",
                @"content":@"有限责任公司",
                @"canShow":@(0)
            },@{
                @"name":@"公司所在省份（必选）",
                @"content":@"河南省",
                @"canShow":@(0)
            },@{
                @"name":@"部门（必填）",
                @"content":@"技术部",
                @"canShow":@(0)
            },@{
                @"name":@"职务",
                @"content":@"总经理",
                @"canShow":@(0)
            },
            @{
                @"name":@"管辖地",
                @"content":@"请选择",
                @"canShow":@(0),
                @"city":@[
                @"城市1",
                @"城市2",
                @"城市3",
                @"城市4",
                @"城市5",
                @"城市6",
                @"城市7",
                @"城市8",
                @"城市9",
                @"城市10",
                @"城市11",
                @"城市12"
                ]
            },
        ];
        NSMutableArray * mutableArray = [NSMutableArray array];
        [persoanl enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary * dic = persoanl[idx];
            zPersonalModel * model = [zPersonalModel mj_objectWithKeyValues:dic];
            [mutableArray addObject:model];
        }];
        _persoanArray = mutableArray;
    }
    return _persoanArray;
}

-(UITableView*)persoanTableView
{
    if (!_persoanTableView) {
        _persoanTableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _persoanTableView.backgroundColor = [UIColor clearColor];
        _persoanTableView.delegate = self;
        _persoanTableView.dataSource = self;
        _persoanTableView.allowsSelection = NO;
        _persoanTableView.estimatedRowHeight = kWidthFlot(44);
        _persoanTableView.estimatedSectionHeaderHeight = 2;
        _persoanTableView.estimatedSectionFooterHeight = 2;
        _persoanTableView.showsVerticalScrollIndicator = NO;
        _persoanTableView.rowHeight = UITableViewAutomaticDimension;
        _persoanTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _persoanTableView;
}
-(zPersonalHeader*)headerView
{
    if (!_headerView) {
        _headerView = [[zPersonalHeader alloc]init];
    }
    return _headerView;
}

-(zCityEditFooter*)footView
{
    if (!_footView) {
        __weak typeof(self)weakSelf = self;
        _footView = [[zCityEditFooter alloc]init];
        _footView.tapBack = ^(NSInteger type) {
            if (type == 1) {
                weakSelf.canEdit = YES;
            }else
            {
                weakSelf.canEdit = NO;
            }
            [weakSelf.persoanTableView reloadData];
        };
        
    }
    return _footView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.persoanTableView];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.persoanTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.persoanArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    zcityCell * cell = [zcityCell instanceWithTableView:tableView AndIndexPath:indexPath];
    zPersonalModel * model = self.persoanArray[indexPath.row];
    cell.persoamModel = model;
    cell.canEdit = self.canEdit;
    return cell;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    self.footView.canEdit = self.canEdit;
    return self.footView;
}

@end
