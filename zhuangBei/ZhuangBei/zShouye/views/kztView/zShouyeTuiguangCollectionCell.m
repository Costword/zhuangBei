//
//  zShouyeTuiguangCollectionCell.m
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/10.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zShouyeTuiguangCollectionCell.h"

@interface zShouyeTuiguangCollectionCell ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIButton * titleButton;

@property(strong,nonatomic)UIButton * nameButton;

@property(strong,nonatomic)UIButton * tapButton;

@property(strong,nonatomic)UIImageView * headerImage;



@end

@implementation zShouyeTuiguangCollectionCell

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView  alloc]init];
        _baseView.backgroundColor = [UIColor redColor];
    }
    return _baseView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.baseView];
        [self updateConstraintsForView];
    }
    return self;
}


-(void)updateConstraintsForView
{
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

-(void)setSourceDic:(NSDictionary *)sourceDic
{
    _sourceDic = sourceDic;
    
}
@end
