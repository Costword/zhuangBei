//
//  zShouYeLeftMenu.m
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zShouYeLeftMenu.h"
#import "zLeftMenuCell.h"


@interface zShouYeLeftMenu ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView * menuTableView;

@end

@implementation zShouYeLeftMenu

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


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.menuTableView];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    zLeftMenuCell * cell = [zLeftMenuCell instanceWithTableView:tableView AndIndexPath:indexPath];
//    zPersonalModel * model = self.menuArray[indexPath.row];
//    cell.persoamModel = model;
//    cell.canEdit = self.canEdit;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.menutapBack) {
        self.menutapBack(indexPath.row);
    }
}

-(void)setMenuArray:(NSArray *)menuArray
{
    _menuArray = menuArray;
    [self.menuTableView reloadData];
}


@end
