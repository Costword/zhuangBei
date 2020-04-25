//
//  zZhuCeController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zZhuCeController.h"
#import "zhuCeCard.h"

@interface zZhuCeController ()

@property(strong,nonatomic)zhuCeCard * zhuceView;

@end

@implementation zZhuCeController


-(zhuCeCard*)zhuceView
{
    if (!_zhuceView) {
        _zhuceView = [[zhuCeCard alloc]init];
    }
    return _zhuceView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.zhuceView];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.zhuceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuide);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}


@end
