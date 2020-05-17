//
//  LWBaseAlearView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/17.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWAlearCustomManagerView.h"


@interface LWAlearCustomManagerView()

@property (nonatomic, strong) UIView * bgview;

@property (nonatomic, strong) UIView * mainView;

@end

@implementation LWAlearCustomManagerView

+ (instancetype)showAlearView:(UIView *)mainview
{
    LWAlearCustomManagerView *v = [LWAlearCustomManagerView new];
    v.mainView = mainview;
    [v confiUI];
    return v;
}

- (void)confiUI
{
    _bgview = [UIView new];
    _bgview.backgroundColor = UIColor.blackColor;
    _bgview.alpha = 0.3;
    [_bgview ex_addTapAction:self selector:@selector(dimiss)];
    
    NSAssert(!_mainView, @"主体视图不能为空");
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubviews:@[_bgview,_mainView]];
    
    [_bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(window);
    }];
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(200);
        make.width.mas_offset(300);
        make.centerX.mas_equalTo(window.mas_centerX);
        make.centerY.mas_equalTo(window.mas_centerY);
    }];
    
    [_mainView setBoundWidth:0 cornerRadius:4];
}

- (void)dimiss
{
    [_mainView removeFromSuperview];
    [_bgview removeFromSuperview];
    _mainView = nil;
    _bgview = nil;
}

- (void)showAddNewUserGroupView
{
    
    LWAddNewUserGroupView *temview = [[NSBundle mainBundle] loadNibNamed:@"LWAddNewUserGroupView" owner:self options:nil].firstObject;
    _mainView = temview;
    
}
@end


@implementation LWAddNewUserGroupView

- (IBAction)clickCancleBtn:(id)sender {
    
}

- (IBAction)clickSure:(id)sender {
}

@end
