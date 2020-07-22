//
//  zBaoKuanItemCell.m
//  ZhuangBei
//
//  Created by aa on 2020/7/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zBaoKuanItemCell.h"

@interface zBaoKuanItemCell ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIButton * iconView;

@end

@implementation zBaoKuanItemCell


//-(UIView*)baseView
//{
//    if (!_baseView) {
//        _baseView = [[UIView alloc]init];
//        _baseView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
//        _baseView.layer.borderWidth = 1;
//        _baseView.layer.cornerRadius = kWidthFlot(8);
//    }
//    return _baseView;
//}

-(UIButton *)iconView
{
    if (!_iconView) {
        _iconView = [[UIButton alloc]init];
        [_iconView setBackgroundImage:[UIImage imageNamed:@"icon_hot_product"] forState:UIControlStateNormal];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.layer.cornerRadius = kWidthFlot(5);
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:self.baseView];
        [self.contentView addSubview:self.iconView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
//    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsZero);
//    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(kWidthFlot(5));
        make.right.bottom.mas_equalTo(-kWidthFlot(5));
    }];
}

@end
