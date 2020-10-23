//
//  zCompanyHeader.m
//  ZhuangBei
//
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCompanyHeader.h"
#import "sliderNavMenu.h"
#import "UIImageView+LWImageView.h"

@interface zCompanyHeader ()<sliderNavMenuDelegate>

@property(strong,nonatomic)UIView * baseView;
@property(strong,nonatomic)UILabel * logoLabel;
@property(strong,nonatomic)UIImageView * logoImageView;
@property(strong,nonatomic)UILabel * nameLabel;
@property(strong,nonatomic)UILabel * timeLabel;
@property(strong,nonatomic)UILabel * descNameLabel;
@property(strong,nonatomic)UILabel * descContentLabel;
@property(strong,nonatomic)sliderNavMenu * navigationSliderMenu;

@end

@implementation zCompanyHeader

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
    }
    return _baseView;
}

-(UIImageView*)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH*0.6, SCREEN_WIDTH*0.75*0.6)];
        _logoImageView.image = [_logoImageView z_getPlaceholderImageWithSVG];
    }
    return _logoImageView;
}
-(UILabel*)logoLabel
{
    if (!_logoLabel) {
        _logoLabel = [[UILabel alloc]init];
        _logoLabel.textAlignment = NSTextAlignmentCenter;
        _logoLabel.font = kFont(20);
        _logoLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _logoLabel.numberOfLines = 0;
    }
    return _logoLabel;
}


-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = kFont(20);
        _nameLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _nameLabel.numberOfLines = 0;
        _nameLabel.text = @"北京装备科技设计有限公司";
    }
    return _nameLabel;
}
-(UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = kFont(12);
        _timeLabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        _timeLabel.numberOfLines = 0;
        _timeLabel.text = @"成立时间:2000年1月1日";
    }
    return _timeLabel;
}
-(UILabel*)descNameLabel
{
    if (!_descNameLabel) {
        _descNameLabel = [[UILabel alloc]init];
        _descNameLabel.textAlignment = NSTextAlignmentLeft;
        _descNameLabel.font = kFont(12);
        _descNameLabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        _descNameLabel.numberOfLines = 0;
        _descNameLabel.text = @"公司简介:";
    }
    return _descNameLabel;
}

-(UILabel*)descContentLabel
{
    if (!_descContentLabel) {
        _descContentLabel = [[UILabel alloc]init];
        _descContentLabel.font = kFont(12);
        _descContentLabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        _descContentLabel.text = @"";
        _descContentLabel.numberOfLines = 0;
    }
    return _descContentLabel;
}

-(sliderNavMenu*)navigationSliderMenu
{
    if (!_navigationSliderMenu) {
        _navigationSliderMenu = [[sliderNavMenu alloc]init];
        _navigationSliderMenu.userInteractionEnabled = YES;
        _navigationSliderMenu.havesliderBar = YES;
        _navigationSliderMenu.padding = kWidthFlot(30);
        _navigationSliderMenu.sliderRoundCorner = 1.5;
        _navigationSliderMenu.normalFontColor = [UIColor colorWithHexString:@"#666666"];
        _navigationSliderMenu.selectFontColor = [UIColor colorWithHexString:@"#333333"];
        if (self.type ==1) {
            [_navigationSliderMenu setSourceArray:@[@"企业详情"]];
        }else
        {
            [_navigationSliderMenu setSourceArray:@[@"企业详情",@"货源详情"]];
        }
        _navigationSliderMenu.sliderType = menuAligenLeft;
        _navigationSliderMenu.delegate = self;
    }
    return _navigationSliderMenu;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
        [self addSubview:self.baseView];
        
        [self.baseView addSubview:self.logoLabel];
//        [self.baseView addSubview:self.logoImageView];
//        [self.baseView addSubview:self.nameLabel];
//        [self.baseView addSubview:self.timeLabel];
//        [self.baseView addSubview:self.descNameLabel];
//        [self.baseView addSubview:self.descContentLabel];
//        [self.baseView addSubview:self.navigationSliderMenu];
        [self updateConstraintsForView];
    }
    return self;
}


-(void)updateConstraintsForView
{
    CGFloat margin = 20;
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(10));
        make.left.mas_equalTo(margin);
        make.right.mas_equalTo(-margin);
        make.bottom.mas_equalTo(-kWidthFlot(10));
    }];
    
//    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.logoLabel.mas_bottom).offset(5);
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*0.6, SCREEN_WIDTH*0.75*0.6));
//    }];
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.logoImageView.mas_bottom).offset(10);
//        make.left.mas_equalTo(margin);
//        make.right.mas_equalTo(-margin);
//        make.height.mas_equalTo(20);
//    }];
//
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
//        make.left.mas_equalTo(margin);
//        make.right.mas_equalTo(-margin);
//        make.height.mas_equalTo(20);
//    }];
//    [self.descNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(5);
//        make.left.mas_equalTo(margin);
//        make.width.mas_equalTo(SCREEN_WIDTH-margin*2);
//        make.height.mas_equalTo(20);
//    }];
//    [self.descContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.descNameLabel.mas_bottom).offset(5);
//        make.left.mas_equalTo(margin);
//        make.width.mas_equalTo(SCREEN_WIDTH-margin*2);
//    }];
//
//    [self.navigationSliderMenu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.descContentLabel.mas_bottom).offset(kWidthFlot(5));
//        make.left.mas_equalTo(0);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(44);
//        make.bottom.mas_equalTo(-kWidthFlot(10));
//    }];
}

-(void)setType:(NSInteger)type
{
    _type = type;
    if (type==1) {
        [self.navigationSliderMenu setSourceArray:@[@"企业详情"]];
    }
}

-(void)setGoosModel:(zGoodsContentModel *)goosModel
{
    _goosModel = goosModel;
    self.logoLabel.text = _goosModel.name;
//    self.timeLabel.text = [NSString stringWithFormat:@"成立时间:%@",_goosModel.createDate];
//    self.descContentLabel.text = _goosModel.approveText;
//    [self.logoImageView z_imageWithImageId:_goosModel.imagesId];
}

-(void)setCompanyType:(NSInteger)companyType
{
    _companyType = companyType;
    self.navigationSliderMenu.selectIndex = companyType;
    
}



-(void)sliderNavMenuSelectIndex:(NSInteger)index
{
    if (self.headerSlideBack) {
        self.headerSlideBack(index);
    }
}


@end
