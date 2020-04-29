//
//  LWHuoYuanDeatilViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanDeatilViewController.h"
#import "LWHuoYuanDeatilView.h"

@interface LWHuoYuanDeatilViewController ()
@property (nonatomic, strong) LWHuoYuanDeatilView * mainView;

@end

@implementation LWHuoYuanDeatilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"货源详情";
    [self confiUI];
}

- (void)confiUI
{
    self.mainView = [LWHuoYuanDeatilView new];
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
}

@end
