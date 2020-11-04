//
//  zGXBCell.m
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/30.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zGXBCell.h"

@interface zGXBCell ()

@property(strong,nonatomic)UIView*baseView;
@property(strong,nonatomic)UIView*line;

@property(strong,nonatomic)UILabel*nameLabel;
@property(strong,nonatomic)UILabel*gxbNumLabel;
@property(strong,nonatomic)UILabel*typeLabel;
@property(strong,nonatomic)UILabel*timeLabel;

@end

@implementation zGXBCell


+(zGXBCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zGXBCell";
    zGXBCell * cell = [[zGXBCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
    }
    return _baseView;
}
-(UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor grayColor];
    }
    return _line;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kFont(16);
        _nameLabel.textColor = [UIColor colorWithHexString:@"#3F50B5"];
        _nameLabel.numberOfLines = 1;
        _nameLabel.text = @"";
    }
    return _nameLabel;
}

-(UILabel*)gxbNumLabel
{
    if (!_gxbNumLabel) {
        _gxbNumLabel = [[UILabel alloc]init];
        _gxbNumLabel.font = kFont(14);
        _gxbNumLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _gxbNumLabel.numberOfLines = 1;
        _gxbNumLabel.text = @"";
    }
    return _gxbNumLabel;
}

-(UILabel*)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.font = kFont(14);
        _typeLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _typeLabel.numberOfLines = 1;
        _typeLabel.text = @"";
    }
    return _typeLabel;
}

-(UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = kFont(14);
        _timeLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _timeLabel.text = @"";
    }
    return _timeLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.baseView];
        [self.baseView addSubview:self.nameLabel];
        [self.baseView addSubview:self.gxbNumLabel];
        [self.baseView addSubview:self.typeLabel];
        [self.baseView addSubview:self.timeLabel];
        [self.baseView addSubview:self.line];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.top.mas_equalTo(kWidthFlot(5));
        make.bottom.mas_equalTo(-kWidthFlot(5));
        make.height.mas_equalTo(kWidthFlot(118));
    }];
    

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(5));
        make.top.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(17));
    }];
    
    [self.gxbNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(5));
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kWidthFlot(7));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(17));
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(5));
        make.top.mas_equalTo(self.gxbNumLabel.mas_bottom).offset(kWidthFlot(7));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(17));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(5));
        make.top.mas_equalTo(self.typeLabel.mas_bottom).offset(kWidthFlot(7));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(17));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(5));
        make.bottom.mas_equalTo(self.baseView.mas_bottom).offset(-1);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

-(void)setModel:(zGXDetailModel *)model
{
    _model = model;
    self.nameLabel.text  = model.recordContent;
    self.gxbNumLabel.text  = [NSString  stringWithFormat:@"功勋币数：%@",model.meritoriousCoinNumber];
    self.typeLabel.text  = [NSString  stringWithFormat:@"收支类型：%@",model.recordTypeShow];
    self.timeLabel.text  = [NSString  stringWithFormat:@"记录时间：%@",model.recordTime];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
