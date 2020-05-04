//
//  zWodeController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zWodeController.h"
#import "zUserInfoCard.h"
#import "zInstructionsCard.h"
#import "zCategoryCard.h"
#import "zSettingViewController.h"
#import "zPersonalController.h"
#import "zUserDescController.h"

@interface zWodeController ()

@property(strong,nonatomic)UIImageView * imageBaseView;
@property(strong,nonatomic)UIButton * settingButton;

@property(strong,nonatomic)zUserInfoCard * userinfoCard;
@property(strong,nonatomic)zInstructionsCard * instructionCard;
@property(strong,nonatomic)zCategoryCard * categoryCard;

@end

@implementation zWodeController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(UIImageView*)imageBaseView
{
    if (!_imageBaseView) {
        _imageBaseView = [[UIImageView alloc]init];
        _imageBaseView.backgroundColor = [kMainSingleton colorWithHexString:@"#3F50B5" alpha:1];
        _imageBaseView.userInteractionEnabled = YES;
    }
    return _imageBaseView;;
}

-(UIButton*)settingButton
{
    if (!_settingButton) {
        _settingButton = [[UIButton alloc]init];
        [_settingButton setImage:[UIImage imageNamed:@"wode_setting"] forState:UIControlStateNormal];
        [_settingButton addTarget:self action:@selector(settting) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingButton;
}

-(zUserInfoCard*)userinfoCard
{
    if (!_userinfoCard) {
        _userinfoCard = [[zUserInfoCard alloc]init];
    }
    return _userinfoCard;
}
-(zInstructionsCard*)instructionCard
{
    if (!_instructionCard) {
        _instructionCard = [[zInstructionsCard alloc]init];
    }
    return _instructionCard;
}
-(zCategoryCard*)categoryCard
{
    if (!_categoryCard) {
        __weak typeof(self)weakSelf = self;
        _categoryCard = [[zCategoryCard alloc]init];
        _categoryCard.categoryTapBack = ^(NSInteger type) {
            if (type == 0) {
                zPersonalController * persoanl = [[zPersonalController alloc]init];
                persoanl.title = @"基本信息";
                [weakSelf.navigationController pushViewController:persoanl animated:YES];
                return;
            }
            if (type == 1) {
                zUserDescController * userDesc = [[zUserDescController alloc]init];
                userDesc.title = @"个人信息";
                [weakSelf.navigationController pushViewController:userDesc animated:YES];
                return;
            }
        };
    }
    return _categoryCard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageBaseView];
    [self.imageBaseView addSubview:self.settingButton];
    [self.view addSubview:self.userinfoCard];
    [self.view addSubview:self.instructionCard];
    [self.view addSubview:self.categoryCard];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.userinfoCard.myNumbers = @"100";
    });
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.imageBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kWidthFlot(196));
    }];
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kWidthFlot(20));
        make.top.mas_equalTo(KstatusBarHeight+20);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(35), kWidthFlot(35)));
    }];
    [self.userinfoCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.top.mas_equalTo(kWidthFlot(90));
        make.height.mas_equalTo(kWidthFlot(210));
    }];
    
    [self.instructionCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.top.mas_equalTo(self.userinfoCard.mas_bottom).offset(kWidthFlot(15));
        make.height.mas_equalTo(kWidthFlot(60));
    }];
    [self.categoryCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.top.mas_equalTo(self.instructionCard.mas_bottom).offset(kWidthFlot(15));
        make.height.mas_equalTo(kWidthFlot(210));
    }];

    [self.imageBaseView setNeedsLayout];
       [self.imageBaseView layoutIfNeeded];
       UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.imageBaseView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(15, 15)];
       CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
       maskLayer.frame = self.imageBaseView.bounds;
       maskLayer.path = maskPath.CGPath;
       self.imageBaseView.layer.mask = maskLayer;
}

//设置
-(void)settting{
    zSettingViewController  * setting = [[zSettingViewController alloc]init];
    setting.title = @"设置";
    [self.navigationController pushViewController:setting animated:YES];
}

@end
