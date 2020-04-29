//
//  LWJiaoLiuContatcsListTableViewCell.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWJiaoLiuContatcsListTableViewCell.h"

//联系人 cell
@implementation LWJiaoLiuContatcsListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _icon = [UIImageView new];
        _icon.image = IMAGENAME(@"testicon1");
        _nameL = [UILabel new];
        _nameL.font = kFont(15);
        [self.contentView addSubviews:@[_icon,_nameL]];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(35);
            make.width.mas_offset(30);
            make.height.mas_offset(30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_icon.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_icon setBoundWidth:0 cornerRadius:15];
    }
    return self;
}

@end

// 消息列表 cell
@implementation LWJiaoLiuMessageListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _icon = [UIImageView new];
        _icon.image = IMAGENAME(@"icon_into");
        _icon.contentMode = UIViewContentModeScaleAspectFit;
        _nameL = [UILabel new];
        _nameL.font = kFont(15);
        [self.contentView addSubviews:@[_icon,_nameL]];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.width.mas_offset(20);
            make.height.mas_offset(20);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(20);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}

@end


// 联系人组头
@implementation LWJiaoLiuContatcsSeactionView

- (void)clickPullBtn:(UIButton *)sender
{
    _rightBtn.selected = !_rightBtn.selected;
    if (self.block) {
        self.block(_rightBtn.selected);
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _leftIcon = [UIImageView new];
        _leftIcon.image = IMAGENAME(@"testicon2");
        _leftL = [UILabel new];
        _rightBtn = [UIButton new];
        [_rightBtn setImage:IMAGENAME(@"icon_pull") forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(clickPullBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubviews:@[_leftIcon,_leftL,_rightBtn]];
        [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(10);
            make.width.mas_offset(30);
            make.height.mas_offset(30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_leftL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_leftIcon.mas_right).mas_offset(10);
            make.right.mas_equalTo(_rightBtn.mas_right).mas_offset(-20);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-10);
            make.width.mas_offset(40);
            make.height.mas_offset(40);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return self;
}

@end
