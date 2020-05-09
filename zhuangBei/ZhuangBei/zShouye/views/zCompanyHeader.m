//
//  zCompanyHeader.m
//  ZhuangBei
//
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCompanyHeader.h"

@interface zCompanyHeader ()

@property(strong,nonatomic)UIImageView * logoImageView;
@property(strong,nonatomic)UILabel * nameLabel;
@property(strong,nonatomic)UILabel * timeLabel;
@property(strong,nonatomic)UILabel * descContentLabel;


@end

@implementation zCompanyHeader

-(UIImageView*)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.clipsToBounds = YES;
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _logoImageView.image = [UIImage imageNamed:@"testicon"];
    }
    return _logoImageView;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = kFont(14);
        _nameLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _nameLabel.numberOfLines = 0;
        _nameLabel.text = @"北京装备科技设计有限公司";
    }
    return _nameLabel;
}
-(UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = kFont(12);
        _timeLabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        _timeLabel.numberOfLines = 0;
        _timeLabel.text = @"成立时间:2000年1月1日";
    }
    return _timeLabel;
}

-(UILabel*)descContentLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kFont(14);
        _nameLabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        _nameLabel.numberOfLines = 0;
        _nameLabel.text = @"公司简介:\n 装备生产商公司我们的防爆产品很好很多，种类全年齐全激动，啊的顶级爱，顶级爱的嗯嗯记得你打算几点拿到你三代打马赛克吗看到马大姐我你的世界你多久啊水。利水电电脑上看你打击我的女神经的呢就到家啊上课考试的女生。奈史密斯的呢撒啊大姐。";
    }
    return _nameLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.logoImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.descContentLabel];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(5));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(50), kWidthFlot(50)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoImageView.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(kWidthFlot(30));
        make.right.mas_equalTo(-kWidthFlot(30));
        make.height.mas_equalTo(kWidthFlot(20));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kWidthFlot(5));
        make.left.mas_equalTo(kWidthFlot(30));
        make.right.mas_equalTo(-kWidthFlot(30));
        make.height.mas_equalTo(kWidthFlot(20));
    }];
    
    [self.descContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(kWidthFlot(5));
        make.left.mas_equalTo(kWidthFlot(30));
        make.right.mas_equalTo(-kWidthFlot(30));
    }];
}



@end
