//
//  zCategoryCollectCell.m
//  ZhuangBei
//
//  Created by aa on 2020/7/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCategoryCollectCell.h"
#import "UIImage+LWSVGKit.h"
#import "SVGKImage.h"

@interface zCategoryCollectCell ()

@property(strong,nonatomic)UIImageView * iconView;

@property(strong,nonatomic)UILabel * titleLabel;

@property(strong,nonatomic)UILabel * badgeLabel;

@end

@implementation zCategoryCollectCell


-(UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
//        _iconView.image = [UIImage imageNamed:@"kefuicon"];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = kFont(12);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
//        _titleLabel.text = @"爆款申请";
    }
    return _titleLabel;
}

-(UILabel *)badgeLabel
{
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc]init];
        _badgeLabel.font = kFont(10);
        _badgeLabel.textColor =  [UIColor whiteColor];
        _badgeLabel.layer.cornerRadius = 10;
        _badgeLabel.layer.borderWidth = 1;
        _badgeLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.backgroundColor = [UIColor redColor];
        _badgeLabel.clipsToBounds = YES;
        _badgeLabel.alpha = 0;
    }
    return _badgeLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView  addSubview:self.badgeLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(45),kWidthFlot(45)));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(-kWidthFlot(30));
    }];
    [self.badgeLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.iconView.mas_right).offset(5);
        make.top.mas_equalTo(self.iconView.mas_top).offset(-5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-kWidthFlot(5));
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kWidthFlot(20));
    }];
}

-(void)setSourceDic:(NSDictionary *)sourceDic
{
    _sourceDic = sourceDic;
    NSString * imageName = _sourceDic[@"avatar"];
    NSString * itemid = _sourceDic[@"id"];
    NSString * badge =  [NSString stringWithFormat:@"%@", _sourceDic[@"badge"]];
    if ([badge integerValue]==0) {
        self.badgeLabel.alpha = 0;
    }else if ([badge integerValue] >99)
    {
        self.badgeLabel.alpha = 1;
        self.badgeLabel.text= @"99";
    }else
    {
        self.badgeLabel.alpha = 1;
        self.badgeLabel.text=badge;
    }
    if ([itemid integerValue] == 36 || [itemid integerValue] == 61) {
        imageName = @"shiti";
    }
    if ([imageName isEqualToString:@"gongxun"]) {
        self.iconView.image = [UIImage imageNamed:imageName];
    }else{
        UIImage * image = [self z_getImageWithSVG:[NSString stringWithFormat:@"%@.svg",imageName] andImageView:self.iconView];
        self.iconView.image = image;
    }
    self.titleLabel.text = _sourceDic[@"groupname"];
    
}

- (UIImage *)z_getImageWithSVG:(NSString *)imageName
                  andImageView:(UIImageView*)imageView
{
    if (self.frame.size.width == 0 && self.frame.size.height == 0) {
        [self.superview layoutIfNeeded];
    }
    imageView.frame = CGRectMake(0,0, kWidthFlot(45), kWidthFlot(45));
    UIImage *img;
    if ([imageName hasSuffix:@".svg"]&& ![imageName containsString:@"gonggao"]) {
        @try {
            //        防止找不到该占位图的路径造成的崩溃
            img = [UIImage svgImageNamed:imageName imgv:imageView];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }else{
        imageName = [imageName substringToIndex:imageName.length-4];
        img = IMAGENAME(imageName);
    }
    return img;
}

@end
