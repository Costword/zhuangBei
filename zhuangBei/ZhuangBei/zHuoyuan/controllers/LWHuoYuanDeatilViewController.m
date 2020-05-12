//
//  LWHuoYuanDeatilViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanDeatilViewController.h"
#import "LWHuoYuanDeatilView.h"
#import "LWHuoYuanDeatilModel.h"

@interface LWHuoYuanDeatilViewController ()
@property (nonatomic, strong) LWHuoYuanDeatilView * mainView;
@property (nonatomic, strong) LWHuoYuanDeatilModel * datasModel;
@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UIButton * rightBtn;
@end

@implementation LWHuoYuanDeatilViewController

- (void)requestDatas
{
    [self requestPostWithUrl:@"app/appgyszblink/getSourceDetailsByModelId" paraString:@{
        @"modelId":LWDATA(self.modelId),
        @"gongYingShangDm":LWDATA(self.gongYingShangDm),
        @"zhuangBeiDm":LWDATA(self.zhuangBeiDm),
        @"zhuangBeiLx":LWDATA(self.zhuangBeiLx),
        @"zhuangBeiName":LWDATA(self.zhuangBeiName)} success:^(id  _Nonnull response) {
        
        if (!_mainView) {
            [self confiUI];
        }
        self.datasModel = [LWHuoYuanDeatilModel modelWithDictionary:response[@"data"]];
        [self handlerDatas];
        if ([response[@"code"] integerValue] == 0) {
        }else{
            [[zHud shareInstance] showMessage:LWDATA(response[@"msg"])];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void)handlerDatas
{
    if(!self.modelId){
        modelListModel *modelmodel = self.datasModel.modelList.firstObject;
        self.modelId = modelmodel.customId;
    }
    self.mainView.model = self.datasModel;
    self.mainView.currentModelId = self.modelId;
    
    if (self.datasModel.isFollow == 3){
        //        [self.leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        //              make.left.mas_equalTo(self.view.mas_left);
        //              make.right.mas_equalTo(_rightBtn.mas_left).mas_offset(-0);
        //              make.height.mas_offset(54);
        //              make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(0);
        //          }];
        [_rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_leftBtn.mas_right).mas_offset(0);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-0);
            make.width.mas_offset(0);
        }];
    }else{
        
        [_rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_leftBtn.mas_right).mas_offset(0);
            make.right.mas_equalTo(self.view.mas_right).mas_offset(-0);
            make.width.height.bottom.mas_equalTo(_leftBtn);
        }];
        if (self.datasModel.isFollow == 1) {
            [self.rightBtn setTitle:@"取消关注" forState:UIControlStateNormal];
        }else if (self.datasModel.isFollow == 2){
            [self.rightBtn setTitle:@"关注货源" forState:UIControlStateNormal];
        }
    }
}

- (void)clickBottomBtn:(UIButton *)sender
{
    NSLog(@"-----------------%ld",sender.tag);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"货源详情";
    //    [self confiUI];
    [self requestDatas];
}

- (void)confiUI
{
    self.mainView = [LWHuoYuanDeatilView new];
    [self.view addSubview:self.mainView];
    WEAKSELF(self);
    self.mainView.block = ^(NSString * _Nonnull modelid) {
        weakself.modelId = modelid;
        [weakself requestDatas];
    };
    
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
    _leftBtn = leftbtn;
    _rightBtn = rightbtn;
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
