//
//  ALauchCollectionViewCell.m
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import "ALauchCollectionViewCell.h"

@interface ALauchCollectionViewCell ()

@property(strong,nonatomic)UIImageView * imageView;

@property(strong,nonatomic)UIButton * nexBtn;

@end

@implementation ALauchCollectionViewCell

-(UIButton *)nexBtn
{
    if (!_nexBtn) {
        _nexBtn = [[UIButton alloc]init];
        _nexBtn.alpha = 0;
        [_nexBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nexBtn.titleLabel.font = [UIFont systemFontOfSize:kWidthFlot(14)];
        @weakify(self);
        [[self.nexBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self.launchSignal sendNext:self.nexBtn];
        }];
    }
    return _nexBtn;
}
-(RACSubject *)launchSignal
{
    if (!_launchSignal) {
        _launchSignal = [RACSubject subject];
    }
    return _launchSignal;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =  [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.bounds.size.width,self.bounds.size.height)];
        self.imageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.nexBtn];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.nexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kWidthFlot(20));
        make.bottom.mas_equalTo(-kWidthFlot(50));
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(100), kWidthFlot(60)));
    }];
}


-(void)setImagedic:(NSDictionary *)imagedic
{
    NSString * url  = imagedic[@"image"];
    self.imageView.image = [UIImage imageNamed:url];
    NSString * tag = imagedic[@"tag"];
    self.nexBtn.tag = [tag integerValue];
    if ([tag integerValue]<3) {
        [self.nexBtn setTitle:[NSString stringWithFormat:@"下一步%@",tag] forState:UIControlStateNormal];
    }else
    {
        [self.nexBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
}

@end
