//
//  zCompanyCollectionHeaderView.m
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/9.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCompanyCollectionHeaderView.h"

@interface zCompanyCollectionHeaderView ()

@property(strong,nonatomic)UILabel * titleLabel;

@end

@implementation zCompanyCollectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel = [self creatNameLabel];
        self.titleLabel.text = @"已上架货源";
        [self addSubview:self.titleLabel];
        [self updateConstraintsForView];
    }
    return self;
}

-(UILabel*)creatNameLabel
{
    UILabel *  nameLabel = [[UILabel alloc]init];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    CGFloat fitSize = kWidthFlot(16);
    nameLabel.font = kFont(fitSize);
    nameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    nameLabel.numberOfLines = 0;
    return nameLabel;
}

-(void)updateConstraintsForView
{
    CGFloat left = kWidthFlot(10);
    CGFloat top = kWidthFlot(10);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
        make.top.mas_equalTo(top);
        make.right.mas_equalTo(-left);
        make.bottom.mas_equalTo(-top);
    }];
}

@end
