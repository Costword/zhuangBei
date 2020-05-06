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

- (void)requestDatas
{
    [ServiceManager requestPostWithUrl:@"app/appgyszblink/getSourceDetailsByModelId" Parameters:@{@"modelId":LWDATA(self.modelId)} success:^(id  _Nonnull response) {
        
        if ([response[@"code"] integerValue] == 0) {
            
            
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void)clickBottomBtn:(UIButton *)sender
{
    NSLog(@"-----------------%ld",sender.tag);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"货源详情";
    [self confiUI];
    [self requestDatas];
}

- (void)confiUI
{
    self.mainView = [LWHuoYuanDeatilView new];
    [self.view addSubview:self.mainView];
    
    
    UIButton *leftbtn = [UIButton new];
    UIButton *rightbtn = [UIButton new];
    [leftbtn setTitle:@"在线咨询" forState:UIControlStateNormal];
    [rightbtn setTitle:@"关注成我的货源" forState:UIControlStateNormal];
    [leftbtn setImage:IMAGENAME(@"zAccount") forState:UIControlStateNormal];
    [rightbtn setImage:IMAGENAME(@"zAccount") forState:UIControlStateNormal];
    [leftbtn layoutButtonWithEdgeInsetsStyle:(HLButtonEdgeInsetsStyleLeft) imageTitleSpace:10];
    [rightbtn layoutButtonWithEdgeInsetsStyle:(HLButtonEdgeInsetsStyleLeft) imageTitleSpace:10];
    [leftbtn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    [rightbtn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    
    [self.view addSubviews:@[leftbtn,rightbtn]];
    [leftbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(rightbtn.mas_left).mas_offset(-0);
        make.height.mas_offset(54);
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(0);
    }];
    [rightbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftbtn.mas_right).mas_offset(0);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-0);
        make.width.height.bottom.mas_equalTo(leftbtn);
    }];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.width.mas_offset(SCREEN_WIDTH);
        make.bottom.mas_equalTo(leftbtn.mas_top).mas_offset(-5);
    }];
    [leftbtn setBoundWidth:0.5 cornerRadius:0 boardColor:BASECOLOR_BOARD];
    [rightbtn setBoundWidth:0.5 cornerRadius:0 boardColor:BASECOLOR_BOARD];
    [leftbtn addTarget:self action:@selector(clickBottomBtn:) forControlEvents:UIControlEventTouchUpInside];
    leftbtn.tag = 1;
    rightbtn.tag = 2;
}



@end
