//
//  zWenDaVC.m
//  ZhuangBei
//
//  Created by aa on 2020/7/24.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zWenDaVC.h"

@interface zWenDaVC ()

@property(strong,nonatomic)UILabel * descLabel;

@end

@implementation zWenDaVC


-(UILabel*)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = kFont(14);
        _descLabel.text = @"当前还没有评论";
    }
    return _descLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.descLabel];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(5));
        make.left.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(10));
        make.height.mas_equalTo(kWidthFlot(20));
    }];
}


@end
