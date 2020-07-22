//
//  zNotifacationCell.m
//  ZhuangBei
//
//  Created by aa on 2020/7/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zNotifacationCell.h"
#import "MarqueeView.h"
#import "zCategoryCollectCell.h"

//const CGFloat kCategoryLeftMargin = 20.f;

static NSString * scrollItemCell_id = @"zCategoryCollectCell";

@interface zNotifacationCell ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIButton *iconButton;

@property(strong,nonatomic)UILabel *titleLabel;

@property(strong,nonatomic)UILabel *timeLabel;

@property(strong,nonatomic)UILabel *personLabel;

@property(strong,nonatomic)UILabel *messageLabel;

@property(strong,nonatomic)UIButton *backButton;


@end

@implementation zNotifacationCell

+(zNotifacationCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zNotifacationCell";
    zNotifacationCell * cell = [[zNotifacationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
        _baseView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
        _baseView.layer.borderWidth = 1;
        _baseView.layer.cornerRadius = kWidthFlot(5);
    }
    return _baseView;
}

-(UIButton*)iconButton
{
    if (!_iconButton) {
        _iconButton = [[UIButton alloc]init];
        [_iconButton setBackgroundImage:[UIImage imageNamed:@"noti_no_read"] forState:UIControlStateNormal];
        [_iconButton setBackgroundImage:[UIImage imageNamed:@"noti_read"] forState:UIControlStateSelected];
    }
    return _iconButton;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = kFont(16);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = kFont(12);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor blackColor];
    }
    return _timeLabel;
}

-(UILabel *)personLabel
{
    if (!_personLabel) {
        _personLabel = [[UILabel alloc]init];
        _personLabel.font = kFont(12);
        _personLabel.textAlignment = NSTextAlignmentLeft;
        _personLabel.textColor = [UIColor blackColor];
    }
    return _personLabel;
}

-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.font = kFont(12);
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.textColor = [UIColor blackColor];
    }
    return _messageLabel;
}

-(UIButton*)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc]init];
        _backButton.backgroundColor = [UIColor blueColor];
        [_backButton setTitle:@"回执" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _backButton.layer.cornerRadius = kWidthFlot(2);
        _backButton.clipsToBounds = YES;
    }
    return _backButton;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.baseView];
        [self.baseView addSubview:self.iconButton];
        [self.baseView addSubview:self.titleLabel];
        [self.baseView addSubview:self.timeLabel];
        [self.baseView addSubview:self.personLabel];
        [self.baseView addSubview:self.messageLabel];
        [self.baseView addSubview:self.backButton];
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
        make.height.mas_equalTo(kWidthFlot(100));
    }];
    
    [self.iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(50), kWidthFlot(50)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconButton.mas_right).offset(kWidthFlot(5));
        make.top.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(10));
        make.height.mas_equalTo(kWidthFlot(20));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconButton.mas_right).offset(kWidthFlot(5));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(kWidthFlot(5));
        make.right.mas_equalTo(-kWidthFlot(10));
        make.height.mas_equalTo(kWidthFlot(15));
    }];
    
    [self.personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconButton.mas_right).offset(kWidthFlot(5));
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(kWidthFlot(5));
        make.right.mas_equalTo(-kWidthFlot(10));
        make.height.mas_equalTo(kWidthFlot(15));
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconButton.mas_right).offset(kWidthFlot(5));
        make.top.mas_equalTo(self.personLabel.mas_bottom).offset(kWidthFlot(5));
        make.right.mas_equalTo(-kWidthFlot(10));
        make.height.mas_equalTo(kWidthFlot(15));
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kWidthFlot(10));
        make.centerY.mas_equalTo(self.baseView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(50), kWidthFlot(25)));
    }];
    
    
}

-(void)setSourceDic:(NSDictionary *)sourceDic
{
    _sourceDic = sourceDic;
    
    NSString * shiFouYd =_sourceDic[@"shiFouYd"];
    if ([shiFouYd integerValue] == 1) {
        self.iconButton.selected =YES;
    }else
    {
        self.iconButton.selected =NO;
    }
    
    self.titleLabel.text = _sourceDic[@"gongGaoDmName"];
    self.timeLabel.text =[NSString stringWithFormat:@"发布时间:%@",_sourceDic[@"chuangJianSj"]];
    NSString * tongZhiRName =_sourceDic[@"tongZhiRName"];
    if ([tongZhiRName isEqual:[NSNull null]]) {
        tongZhiRName = @"暂无";
    }
    self.personLabel.text =[NSString stringWithFormat:@"通知人:  %@",tongZhiRName];
    NSString * huizhi =_sourceDic[@"huiZhiNr"];
    if ([huizhi isEqual:[NSNull null]]) {
        huizhi = @"暂无";
    }
    self.messageLabel.text = [NSString stringWithFormat:@"回执消息:  %@",huizhi];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        
    }else
    {
        
    }
}

@end
