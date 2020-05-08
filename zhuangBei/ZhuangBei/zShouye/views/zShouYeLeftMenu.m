//
//  zShouYeLeftMenu.m
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zShouYeLeftMenu.h"
#import "zLeftMenuHeader.h"
#import "zLeftMenuCell.h"
#import "zHuoYuanModel.h"

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
        self.backgroundColor = [UIColor colorWithHexString:@"#D8D8D8"];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.menuArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   zHuoYuanModel * model =  _menuArray[section];
    if (model.select==YES) {
        return model.hyArray.count;
    }
   return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    zLeftMenuCell * cell = [zLeftMenuCell instanceWithTableView:tableView AndIndexPath:indexPath];
    zHuoYuanModel * model =  _menuArray[indexPath.section];
    cell.name = model.hyArray[indexPath.row];
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    zLeftMenuHeader * header = [[zLeftMenuHeader alloc]init];
    header.menuHeaerTapBack = ^(zHuoYuanModel * _Nonnull hymodel) {
        zHuoYuanModel * model = self.menuArray[hymodel.indexSection];
        model.select = !model.select;
        [UIView performWithoutAnimation:^{
           [self.menuTableView reloadSection:hymodel.indexSection withRowAnimation:UITableViewRowAnimationNone];
        }];
    };
    header.hyModel = _menuArray[section];
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.menutapBack) {
        self.menutapBack(indexPath.row);
    }
}

-(void)setMenuArray:(NSArray *)menuArray
{
    NSMutableArray * array = [NSMutableArray array];
    [menuArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        zHuoYuanModel * model = [[zHuoYuanModel alloc]init];
        model.name = [NSString stringWithFormat:@"目录--%ld",idx];
        model.select = NO;
        model.indexSection = idx;
        model.hyArray = @[@"二级目录1",@"二级目录2",@"二级目录3"];
        [array addObject:model];
    }];
    _menuArray = array;
    [self.menuTableView reloadData];
}


@end
