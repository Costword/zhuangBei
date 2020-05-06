//
//  zLeftMenuCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/5.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zLeftMenuCell.h"

@interface zLeftMenuCell ()

@property(strong,nonatomic)UILabel * nameLabel;

@end

@implementation zLeftMenuCell

+(zLeftMenuCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zLeftMenuCell";
    zLeftMenuCell * cell = [[zLeftMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _nameLabel.font = kFont(18);
        _nameLabel.text = @"经销商";
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.nameLabel];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(10));
        make.left.mas_equalTo(kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(25));
        make.bottom.mas_equalTo(-kWidthFlot(10));
    }];
}



-(void)setPersoamModel:(zPersonalModel *)persoamModel
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}

@end
