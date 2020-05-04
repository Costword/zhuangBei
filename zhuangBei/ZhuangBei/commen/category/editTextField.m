//
//  editTextField.m
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import "editTextField.h"

@interface editTextField ()

@property(strong, nonatomic)UIImageView *iconView;

@property(strong, nonatomic)UIButton * show;

@property(strong, nonatomic)UIView *lineView;

@end

@implementation editTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconView = [[UIImageView alloc]init];
        _show = [[UIButton alloc]init];
        [_show setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
        [_show setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
        _show.selected = YES;
        [self addSubview:_iconView];
        [self addSubview:_show];
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kWidthFlot(10), 0)];
        self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kWidthFlot(30), 0)];
        [self setLeftViewMode:(UITextFieldViewModeAlways)];
        [self setRightViewMode:(UITextFieldViewModeAlways)];
        
        [_show addTarget:self action:@selector(actionClear:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addTarget:self action:@selector(actionChange:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(12));
        make.centerY.mas_equalTo(self);
    }];
    [_show mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(kWidthFlot(30));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];

}


#pragma mark - action
- (void)actionChange:(id)sender {
//    _btnClear.hidden = self.text.length == 0;
}

- (void)actionClear:(UIButton*)sender {
    _show.selected = !sender.selected;
    [self setSecureTextEntry:!_show.selected];
}


#pragma mark - getter and setter
- (void)setMyPlaceHolder:(NSString *)myPlaceHolder {
    _myPlaceHolder = myPlaceHolder;
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:myPlaceHolder attributes:@{NSForegroundColorAttributeName : [kMainSingleton colorWithHexString:@"#9B9B9B" alpha:1], NSFontAttributeName: kFont(16)}];
    self.attributedPlaceholder = placeholderString;
}

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    _iconView.image = icon;
}

-(void)setCanShow:(BOOL)canShow
{
    _canShow = canShow;
    if (_canShow) {
        self.show.hidden = NO;
    }else
    {
        self.show.hidden = YES;
        self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kWidthFlot(10), 0)];
    }
    [self updateConstraintsForView];
}
@end
