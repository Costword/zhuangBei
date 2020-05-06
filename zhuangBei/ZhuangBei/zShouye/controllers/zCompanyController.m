//
//  zCompanyController.m
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCompanyController.h"
#import "zShouYeLeftMenu.h"
#import "zLeftMenuCell.h"

@interface zCompanyController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * menuTableView;

@property(strong,nonatomic)zShouYeLeftMenu * leftMenu;

@end

@implementation zCompanyController

-(zShouYeLeftMenu*)leftMenu
{
    if (!_leftMenu) {
        __weak typeof(self)weakSelf = self;
        _leftMenu = [[zShouYeLeftMenu alloc]init];
        _leftMenu.menutapBack = ^(NSInteger index) {
            [weakSelf.menuTableView reloadData];
        };
    }
    return _leftMenu;
}

-(UITableView*)menuTableView
{
    if (!_menuTableView) {
        _menuTableView  = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _menuTableView.backgroundColor = [UIColor clearColor];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.allowsSelection = NO;
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
    self.view.backgroundColor = [UIColor greenColor];
    self.leftMenu.menuArray = @[@"1",@"2",@"3",@"4"];
    [self.view addSubview:self.leftMenu];
    [self.view addSubview:self.menuTableView];
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
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    zLeftMenuCell * cell = [zLeftMenuCell instanceWithTableView:tableView AndIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
