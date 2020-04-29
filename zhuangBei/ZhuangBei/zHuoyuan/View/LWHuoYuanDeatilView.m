//
//  LWHuoYuanDeatilView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanDeatilView.h"


@interface LWHuoYuanDeatilView ()
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UILabel * nameL;
@property (nonatomic, strong) UILabel * companL;
@property (nonatomic, strong) UILabel * proveL;
@property (nonatomic, strong) UILabel * addressL;
//@property (nonatomic, strong) UILabel * productTitleL;
@property (nonatomic, strong) UILabel * productNickL;
//@property (nonatomic, strong) UILabel * xinghaoTitleL;
@property (nonatomic, strong) UILabel * xinghaoL;

@property (nonatomic, strong) UIView * canshuView;

@end

@implementation LWHuoYuanDeatilView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self confiUI];
    }
    return self;
}

- (void)confiUI
{
    _scrollView = [UIScrollView new];
    //    _scrollView.backgroundColor = UIColor.redColor;
    
    _nameL = [UILabel new];
    _companL = [UILabel new];
    _proveL = [UILabel new];
    _addressL = [UILabel new];
    _productNickL = [UILabel new];
    _xinghaoL = [UILabel new];
    UILabel *nickL = [UILabel new];
    UILabel *xinghaoL = [UILabel new];
    
    _nameL.text = @"防弹插板";
    _nameL.font = kFont(21);
    _companL.text = @"公司名称：";
    _proveL.text = @"所在省份：";
    _addressL.text = @"供应来源：";
    nickL.text = @"产品别称";
    _productNickL.text = @"  暂无  ";
    xinghaoL.text = @"产品型号";
    _xinghaoL.text = @"  FDB3F-GD03型  ";
    
    
    [self addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    [_scrollView addSubviews:@[_nameL,_companL,_productNickL,_proveL,_addressL,_xinghaoL,self.canshuView,xinghaoL,nickL]];
    CGFloat margin_l = 20;
    CGFloat margin_t = 30;
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left).mas_offset(margin_l);
        make.right.mas_equalTo(_scrollView.mas_right).mas_offset(-margin_l);
        make.width.mas_offset(SCREEN_WIDTH-margin_l-margin_l);
        make.top.mas_equalTo(_scrollView.mas_top).mas_offset(150);
    }];
    [_companL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_nameL.mas_bottom).mas_offset(margin_t);
    }];
    [_proveL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_companL.mas_bottom).mas_offset(margin_t);
    }];
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_proveL.mas_bottom).mas_offset(margin_t);
    }];
    [nickL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_addressL.mas_bottom).mas_offset(margin_t);
    }];
    [_productNickL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameL);
        make.top.mas_equalTo(nickL.mas_bottom).mas_offset(margin_t-10);
        make.width.mas_lessThanOrEqualTo(@(60));
        make.height.mas_offset(25);
    }];
    [xinghaoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_productNickL.mas_bottom).mas_offset(margin_t);
    }];
    [_xinghaoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameL);
        make.top.mas_equalTo(xinghaoL.mas_bottom).mas_offset(margin_t-10);
        make.height.mas_offset(25);
    }];
    [self.canshuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_xinghaoL.mas_bottom).mas_offset(10);
        make.bottom.mas_equalTo(_scrollView.mas_bottom).mas_offset(-20);
        make.height.mas_offset(100);
    }];
    
    _productNickL.textAlignment = NSTextAlignmentCenter;
    [_productNickL setBoundWidth:0.5 cornerRadius:0 boardColor:UIColor.grayColor];
    [_xinghaoL setBoundWidth:0.5 cornerRadius:0 boardColor:UIColor.blueColor];
    [self.canshuView setBoundWidth:1 cornerRadius:10 boardColor:UIColor.grayColor];
    
    [self addline:_nameL rightmargin:100];
    [self addline:_companL rightmargin:0];
    [self addline:_proveL rightmargin:0];
    [self addline:_addressL rightmargin:0];
    
}

- (UIView *)canshuView
{
    if (!_canshuView) {
        _canshuView = [[UIView alloc] init];
    }
    return _canshuView;
}

- (void)addline:(UIView *)myview rightmargin:(CGFloat)margin_r
{
    UIView *line = [UIView new];
    line.backgroundColor = UIColor.grayColor;
    [myview.superview addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(myview.superview.mas_left).mas_offset(20);
        make.right.mas_equalTo(myview.superview.mas_right).mas_offset(-margin_r-20);
        make.top.mas_equalTo(myview.mas_bottom).mas_offset(10);
        make.height.mas_offset(1);
    }];
}

@end
