//
//  zCompanyGoodsCollectionCell.m
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/9.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCompanyGoodsCollectionCell.h"

@interface zCompanyGoodsCollectionCell ()

@property(strong,nonatomic)UIImageView * bgImageView;

@property(strong,nonatomic)UILabel * NameLabel;

@property(strong,nonatomic)UILabel * contentLabel;

@property(strong,nonatomic)UIView * lineView;

@end

@implementation zCompanyGoodsCollectionCell

-(UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"huoyuanBG"]];
        _bgImageView.layer.cornerRadius = 8;
        _bgImageView.clipsToBounds = YES;
    }
    return _bgImageView;
}

-(UILabel*)NameLabel
{
    if (!_NameLabel) {
        _NameLabel = [[UILabel alloc]init];
        _NameLabel.textAlignment = NSTextAlignmentCenter;
        CGFloat fitSize = kWidthFlot(16);
        _NameLabel.font = kFont(fitSize);
        _NameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    return _NameLabel;
}

-(UILabel*)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        CGFloat fitSize = kWidthFlot(14);
        _contentLabel.font = kFont(fitSize);
        _contentLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    return _contentLabel;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#4A4A4A"];
    }
    return _lineView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.bgImageView];
        [self.bgImageView addSubview:self.NameLabel];
        [self.bgImageView addSubview:self.contentLabel];
        [self.bgImageView addSubview:self.lineView];
        [self updateConstraintsForView];
    }
    return self;;
}

-(void)updateConstraintsForView
{
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(5));
        make.top.mas_equalTo(kWidthFlot(10));
        make.height.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(5));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.NameLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(kWidthFlot(5));
        make.height.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(5));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(kWidthFlot(5));
        make.right.mas_equalTo(-kWidthFlot(5));
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)setGoosModel:(zCompanyGoodsModel *)goosModel
{
    _goosModel = goosModel;
    self.NameLabel.text = goosModel.zbName;
    if (goosModel.productSource == 1) {
        //自产
        self.contentLabel.text = @"产品来源：自产";
        return;
    }
    if (goosModel.productSource == 2) {
        //总代理
        self.contentLabel.text = @"产品来源：总代理";
        return;
    }
    self.contentLabel.text = @"产品来源：";
}



@end
