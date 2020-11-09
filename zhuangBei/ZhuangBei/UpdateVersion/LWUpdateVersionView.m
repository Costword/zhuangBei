//
//  LWUpdateVersionView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/7/21.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWUpdateVersionView.h"

@interface LWUpdateVersionView ()
@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIView * bgmarkView;
@property (nonatomic, strong) LWUpdateVersionModel * model;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *contentL;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, copy) void(^callBlock)(NSString *);
@property (nonatomic, assign) BOOL isCanClickBgViewBool;

@end

@implementation LWUpdateVersionView

- (void)showAleartViewWithTitle:(NSString *)title content:(NSString *)content btns:(NSArray *)btns callBlock:(void(^)(NSString *))block
{
    _isCanClickBgViewBool = YES;
    _callBlock = block;
    [self configureUI];
    _titleL.text = title;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    _contentL.attributedText = attributedString;
    [_contentL sizeToFit];
    
    if (btns.count > 1) {
        [_leftBtn setTitle:btns[0] forState:UIControlStateNormal];
        [_rightBtn setTitle:btns[1] forState:UIControlStateNormal];
        [_leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bgView.mas_left).mas_offset(5);
            make.right.mas_equalTo(_line3.mas_left).mas_offset(-0);
            make.top.mas_equalTo(_line2.mas_bottom).mas_offset(0);
            make.height.mas_offset(40);
            make.bottom.mas_equalTo(_bgView.mas_bottom).mas_offset(0);
        }];
        [_rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_line3.mas_right).mas_offset(0);
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-5);
            make.top.mas_equalTo(_line2.mas_bottom).mas_offset(0);
            make.height.mas_equalTo(_leftBtn.mas_height);
        }];
    }else if(btns.count == 1){
        [_rightBtn setTitle:btns[0] forState:UIControlStateNormal];
        _leftBtn.hidden = YES;
        [_rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bgView.mas_left).mas_offset(5);
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-5);
            make.top.mas_equalTo(_line2.mas_bottom).mas_offset(0);
            make.height.mas_offset(40);
            make.bottom.mas_equalTo(_bgView.mas_bottom).mas_offset(0);
        }];
    }else{
        _leftBtn.hidden = YES;
        _rightBtn.hidden = YES;
        _line2.hidden = YES;
    }
}

+ (instancetype)showWithModel:(LWUpdateVersionModel *)model
{
    LWUpdateVersionView *instance = [[LWUpdateVersionView alloc] init];
    instance.model = model;
    [instance configureUI];
    return instance;
}

- (void)configureUI
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *bgmarkView = [UIView new];
    _bgmarkView = bgmarkView;
    bgmarkView.backgroundColor = UIColor.blackColor;
    bgmarkView.alpha = 0.3;
    [window addSubview:bgmarkView];
    [bgmarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(window);
    }];
    
    [window addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(window.mas_centerX);
        make.centerY.mas_equalTo(window.mas_centerY);
        make.width.mas_equalTo(window.mas_width).multipliedBy(0.75);
        make.height.mas_lessThanOrEqualTo(window.mas_height).multipliedBy(0.9);
        make.height.mas_greaterThanOrEqualTo(window.mas_height).multipliedBy(0.3);
    }];
    
    if (_isCanClickBgViewBool) {
        [bgmarkView ex_addTapAction:self selector:@selector(dismiss)];
    }
}

- (void)clickBtnLeft
{
    [self dismiss];
}

- (void)clickBtnRight
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1513804704"] ];
}

- (void)clickBtnsEvents:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"忽略"]) {
        [self clickBtnLeft];
    }else if ([btn.titleLabel.text isEqualToString:@"马上尝试"]) {
        [self clickBtnRight];
    }else {
        if (self.callBlock) {
            self.callBlock(btn.titleLabel.text);
        }
    }
}

- (void)dismiss
{
    [_bgmarkView removeFromSuperview];
    _bgmarkView = nil;
    [_bgView removeFromSuperview];
    _bgView = nil;
}

- (void)__dismiss
{
    if (_model.isForceUpdate == 2) {
        return;
    }
    [self dismiss];
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.whiteColor;
        [_bgView ex_addTapAction:self selector:@selector(__dismiss)];
        
        UILabel *titelL = [LWLabel labelWithFont:kFont(15) text:@"新版本上线了" textColor:BASECOLOR_TEXTCOLOR ];
        titelL.textAlignment = NSTextAlignmentCenter;
        _titleL = titelL;
        
        UIView *line1 = [UIView new];
        line1.backgroundColor = BASECOLOR_BOARD;
        
        UIView *line2 = [UIView new];
        line2.backgroundColor = BASECOLOR_BOARD;
        
        UIView *line3 = [UIView new];
        line3.backgroundColor = BASECOLOR_BOARD;
        _line2 = line2;
        _line3 = line3;
        
        UILabel *contentL = [LWLabel labelWithFont:kFont(14) text:@"" textColor:BASECOLOR_TEXTCOLOR];
        contentL.numberOfLines = 0;
        if (_model) {
            contentL.text = _model.updateDetails;
        }
        _contentL = contentL;
        
        UIButton *btn1 = [LWButton lw_button:@"忽略" font:14 textColor:BASECOLOR_TEXTCOLOR backColor:UIColor.whiteColor target:self acction:@selector(clickBtnsEvents:)];
        _leftBtn = btn1;
        
        UIButton *btn2 = [LWButton lw_button:@"马上尝试" font:14 textColor:BASECOLOR_TEXTCOLOR backColor:UIColor.whiteColor target:self acction:@selector(clickBtnsEvents:)];
        _rightBtn = btn2;
        
        [_bgView addSubviews:@[titelL,line1,line2,line3,contentL,btn1,btn2]];
        
        [titelL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_bgView).mas_offset(0);
            make.top.mas_equalTo(_bgView.mas_top).mas_offset(0);
            make.height.mas_offset(40);
        }];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_bgView).mas_offset(0);
            make.top.mas_equalTo(titelL.mas_bottom).mas_offset(0);
            make.height.mas_offset(0.5);
        }];
        
        [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bgView.mas_left).mas_offset(15);
            make.right.mas_equalTo(_bgView.mas_right).mas_offset(-15);
            make.top.mas_equalTo(line1.mas_bottom).mas_offset(10);
        }];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_bgView).mas_offset(0);
            make.top.mas_equalTo(contentL.mas_bottom).mas_offset(10);
            make.height.mas_offset(0.5);
        }];
        if(_model.isForceUpdate == 2){
            line3.hidden = btn1.hidden = YES;
            [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_bgView.mas_left).mas_offset(5);
                make.right.mas_equalTo(_bgView.mas_right).mas_offset(-5);
                make.top.mas_equalTo(line2.mas_bottom).mas_offset(0);
                make.height.mas_offset(40);
                make.bottom.mas_equalTo(_bgView.mas_bottom).mas_offset(0);
            }];
        }else{
            line3.hidden = btn1.hidden = NO;
            [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_bgView.mas_left).mas_offset(5);
                make.right.mas_equalTo(line3.mas_left).mas_offset(-0);
                make.top.mas_equalTo(line2.mas_bottom).mas_offset(0);
                make.height.mas_offset(40);
                make.bottom.mas_equalTo(_bgView.mas_bottom).mas_offset(0);
            }];
            [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(line3.mas_right).mas_offset(0);
                make.right.mas_equalTo(_bgView.mas_right).mas_offset(-5);
                make.top.mas_equalTo(line2.mas_bottom).mas_offset(0);
                make.height.mas_equalTo(btn1.mas_height);
            }];
        }
        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_bgView.mas_centerX);
            make.top.mas_equalTo(btn2.mas_top).mas_offset(10);
            make.bottom.mas_equalTo(btn2.mas_bottom).mas_offset(-10);
            make.width.mas_offset(0.5);
        }];
        [_bgView setBoundWidth:0 cornerRadius:10];
        
    }
    return _bgView;
}

-(void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
