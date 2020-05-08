//
//  zLeftMenuCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zLeftMenuCell.h"

@interface zLeftMenuCell ()

@property(strong,nonatomic)UIButton * arrowButton;

@end

@implementation zLeftMenuCell

+(zLeftMenuCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zLeftMenuCell";
    zLeftMenuCell * cell = [[zLeftMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIButton*)arrowButton
{
    if (!_arrowButton) {
        _arrowButton = [[UIButton alloc]init];
        [_arrowButton setImage:[UIImage imageNamed:@"leftMenu_arrowDown"] forState:UIControlStateNormal];
        [_arrowButton setImage:[UIImage imageNamed:@"leftMenu_arrowLeft"] forState:UIControlStateNormal];
        _arrowButton.titleLabel.font = [UIFont systemFontOfSize:kWidthFlot(12)];
        [_arrowButton setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
    }
    return _arrowButton;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.arrowButton];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(5));
        make.left.mas_equalTo(kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(20));
        make.bottom.mas_equalTo(-kWidthFlot(5));
    }];
}

-(void)setName:(NSString *)name
{
    [self.arrowButton setTitle:name forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}

@end
