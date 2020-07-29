//
//  zVideoListCell.m
//  ZhuangBei
//
//  Created by aa on 2020/7/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zVideoListCell.h"

@interface zVideoListCell ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIImageView * iconImageView;

@property(strong,nonatomic)UILabel * titleLabel;

@property(strong,nonatomic)UILabel * descLabel;

@end

@implementation zVideoListCell

+(zVideoListCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zVideoListCell";
    zVideoListCell * cell = [[zVideoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
        _baseView.layer.borderColor = [UIColor clearColor].CGColor;
        _baseView.layer.borderWidth = 1;
        _baseView.layer.cornerRadius = kWidthFlot(5);
    }
    return _baseView;
}

-(UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage imageNamed:@"play_icon"];
    }
    return _iconImageView;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = kFont(16);
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    }
    return _titleLabel;
}

-(UILabel*)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = kFont(12);
        _descLabel.numberOfLines = 0;
        _descLabel.textColor = [UIColor colorWithHexString:@"#8a8a8a"];
    }
    return _descLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.baseView];
        [self.baseView addSubview:self.iconImageView];
        [self.baseView addSubview:self.titleLabel];
        [self.baseView addSubview:self.descLabel];
        [self updateConstraintsForView];
    }
    return self;
}



-(void)updateConstraintsForView
{
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(10));
        make.top.mas_equalTo(kWidthFlot(5));
        make.bottom.mas_equalTo(-kWidthFlot(5));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.baseView.mas_top).offset(10);
        make.left.mas_equalTo(80);
        make.right.mas_equalTo(-20);
        
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(80);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(self.baseView.mas_bottom).offset(-5);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerY.mas_equalTo(self.baseView.mas_centerY);
    }];
    
}

-(void)setSourceDic:(NSDictionary *)sourceDic
{
    _sourceDic = sourceDic;
    self.titleLabel.text = _sourceDic[@"muLuMc"];
    self.descLabel.text = _sourceDic[@"chuangJianSj"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        
    }else
    {
        
    }
}

@end
