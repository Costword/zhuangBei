//
//  editTextField.m
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import "editTextField.h"

@interface editTextField ()

@property(strong,nonatomic)UILabel * titleLabel;

@property(strong,nonatomic)UIButton * coverButton;

@property(strong, nonatomic)UIImageView *iconView;

@property(strong, nonatomic)UIButton * show;

@property(strong, nonatomic)UIView *lineView;

@end

@implementation editTextField

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.fontColor = [UIColor blackColor];
        self.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        CGFloat fontSize = kWidthFlot(16);
        self.titleFontSize = fontSize;
        self.font = kFont(fontSize);
        _iconView = [[UIImageView alloc]init];
        _coverButton = [[UIButton alloc]init];
        _coverButton.hidden = YES;
        [_coverButton addTarget:self action:@selector(coverButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _show = [[UIButton alloc]init];
        [_show setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
        [_show setImage:[UIImage imageNamed:@"eye_open"] forState:UIControlStateSelected];
        _show.selected = YES;
        [self addSubview:_iconView];
        [self addSubview:_show];
        [self addSubview:self.lineView];
        self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kWidthFlot(30), 0)];
        [self setLeftViewMode:(UITextFieldViewModeAlways)];
        [self setRightViewMode:(UITextFieldViewModeAlways)];
        
        [_show addTarget:self action:@selector(actionClear:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addTarget:self action:@selector(actionChange:) forControlEvents:(UIControlEventEditingChanged)];
        [self addSubview:_coverButton];
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
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
//    [self.coverButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0,0, kWidthFlot(30)));
//    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];

}
-(void)setTitle:(NSString *)title
{
    CGFloat width = [self getItemWidthWithTitlt:title];
    self.titleLabel.text = title;
    self.titleLabel.textColor = self.fontColor;
    [self addSubview:self.titleLabel];
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(20);
    }];
}

-(void)setTitleFontSize:(NSInteger)titleFontSize
{
    _titleFontSize  = titleFontSize;
    self.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
}
-(CGFloat)getItemWidthWithTitlt:(NSString*)title
{
    
    CGFloat width = 0;
    NSDictionary *attributes =
    @{NSFontAttributeName : [UIFont systemFontOfSize:self.titleFontSize]};
    
    width = [title sizeWithAttributes:attributes].width;
    
    return width + 20;
}

#pragma mark - action
- (void)actionChange:(id)sender {
//    _btnClear.hidden = self.text.length == 0;
}

- (void)actionClear:(UIButton*)sender {
    _show.selected = !sender.selected;
    
    if (self.eyesTapBack) {
        
        if (_show.selected) {
            self.eyesTapBack(1);
        }else
        {
            self.eyesTapBack(0);
        }
        
    }
    [self setSecureTextEntry:!_show.selected];
}


#pragma mark - getter and setter
- (void)setMyPlaceHolder:(NSString *)myPlaceHolder {
    _myPlaceHolder = myPlaceHolder;
    CGFloat fontSize = kWidthFlot(16);
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:myPlaceHolder attributes:@{NSForegroundColorAttributeName : [kMainSingleton colorWithHexString:@"#9B9B9B" alpha:1], NSFontAttributeName: kFont(fontSize)}];
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
        [self.coverButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0,0,kWidthFlot(30)));
        }];
        
    }else
    {
        self.show.hidden = YES;
        self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kWidthFlot(10), 0)];
        [self.coverButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0,0,0));
        }];
    }
    
    [self updateConstraintsForView];
}

-(void)setShow:(BOOL)Show
{
    self.show.selected = Show;
}

-(void)setCanTap:(BOOL)canTap
{
    if (canTap) {
        self.coverButton.hidden = NO;
        self.show.userInteractionEnabled = YES;
        [self.coverButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0,0,0));
        }];
    }else
    {
        self.coverButton.hidden = YES;
        self.show.userInteractionEnabled = NO;
        [self.coverButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0,0,kWidthFlot(30)));
        }];
    }
}

//-(void)setCanEdit:(BOOL)canEdit{
//    if (canEdit) {
//        self.coverButton.hidden = YES;
//    }else
//    {
//        self.coverButton.hidden = NO;
//    }
//}

-(void)coverButtonClick
{
    if (self.tapBack) {
        self.tapBack();
    }
}


@end
