//
//  LWAddFriendTableViewCell.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/15.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWAddFriendTableViewCell.h"

@interface LWAddFriendTableViewCell ()

@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * nameL;
@property (nonatomic, strong) UILabel * emailL;
@property (nonatomic, strong) UILabel * phoneL;
@property (nonatomic, strong) UILabel * descL;
@property (nonatomic, strong) UIButton * btn1;
@property (nonatomic, strong) UIButton * btn2;
@end

@implementation LWAddFriendTableViewCell

- (void)setModel:(LWAddFriendModel *)model
{
    _model = model;
    if(model.cellType == 1){
        [_icon z_imageWithImageId:model.portrait placeholderImage:@"testtouxiang"];
        _nameL.text = model.chatNickName;
        _emailL.text = [NSString stringWithFormat:@"公司：%@",model.suoShuGsName?LWDATA(model.suoShuGsName):@"暂无"];
        _phoneL.text = [NSString stringWithFormat:@"电话：%@",model.mobile?LWDATA(model.mobile):@"暂无"];
        _descL.text = [NSString stringWithFormat:@"主营产品：%@",model.mainProduct?LWDATA(model.mainProduct):@"暂无"];
        _btn2.hidden = _btn1.hidden = NO;
        [_btn2 setTitle:@"添加好友" forState:UIControlStateNormal];
    }else{
        [_icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApiPrefix_PIC,model.avatar]] placeholderImage:IMAGENAME(@"testtouxiang")];
        _nameL.text = model.groupName;
        _emailL.text = [NSString stringWithFormat:@"创建时间：%@",LWDATA(model.buildTime)];
        _phoneL.text = [NSString stringWithFormat:@"创建人：%@",LWDATA(model.userName)];
        _descL.text = [NSString stringWithFormat:@"群签名：%@",model.groupdescription?LWDATA(model.groupdescription):@"暂无"];
        _btn1.hidden = YES;
        _btn2.hidden = NO;
        [_btn2 setTitle:@"添加群组" forState:UIControlStateNormal];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self confiCellUI];
    }
    return self;
}

- (void)confiCellUI
{
    
    UIView *bgview = [UIView new];
    [self.contentView addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView).mas_offset(10);
        make.right.bottom.mas_equalTo(self.contentView).mas_offset(-10);
    }];
    
    _icon = [UIImageView new];
    _icon.image = IMAGENAME(@"testtouxiang");
    _nameL = [LWLabel lw_lable:@"lwq" font:18 textColor:BASECOLOR_TEXTCOLOR];
    _emailL = [LWLabel lw_lable:@"邮箱：" font:14 textColor:BASECOLOR_GREYCOLOR155];
    _phoneL = [LWLabel lw_lable:@"电话：" font:14 textColor:BASECOLOR_GREYCOLOR155];
    _descL = [LWLabel lw_lable:@"个性签名：" font:14 textColor:BASECOLOR_GREYCOLOR155];
    _descL.numberOfLines = 3;
    [_icon setBoundWidth:0 cornerRadius:40];
    [bgview addSubviews:@[_icon,_nameL,_phoneL,_descL,_emailL]];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgview.mas_left).mas_offset(15);
        make.width.height.mas_offset(80);
        make.top.mas_equalTo(bgview.mas_top).mas_offset(15);
    }];
    [_icon setBoundWidth:0 cornerRadius:40];
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).mas_offset(15);
        make.right.mas_equalTo(bgview.mas_right).mas_offset(-10);
        make.top.mas_equalTo(_icon.mas_top).mas_offset(0);
    }];
    
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).mas_offset(15);
        make.right.mas_equalTo(bgview.mas_right).mas_offset(-10);
        make.top.mas_equalTo(_nameL.mas_bottom).mas_offset(7);
    }];
    
    [_emailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_right).mas_offset(15);
        make.right.mas_equalTo(bgview.mas_right).mas_offset(-10);
        make.top.mas_equalTo(_phoneL.mas_bottom).mas_offset(7);
    }];
    [_descL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_icon.mas_left).mas_offset(10);
        make.right.mas_equalTo(bgview.mas_right).mas_offset(-10);
        make.top.mas_equalTo(_icon.mas_bottom).mas_offset(7);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = BASECOLOR_BOARD;
    
    _btn1 = [LWButton lw_button:@"临时聊天" font:15 textColor:UIColor.whiteColor backColor:BASECOLOR_BLUECOLOR target:self acction:@selector(clickBtn:)];
    _btn1.tag = 1;
    
    _btn2 = [LWButton lw_button:@"添加好友" font:15 textColor:UIColor.whiteColor backColor:BASECOLOR_BLUECOLOR target:self acction:@selector(clickBtn:)];
    _btn2.tag = 2;
    
    [bgview addSubviews:@[line,_btn1,_btn2]];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(bgview).mas_offset(0);
        make.top.mas_equalTo(_descL.mas_bottom).mas_offset(5);
        make.height.mas_offset(0.5);
    }];
    
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgview.mas_right).mas_offset(-10);
        make.top.mas_equalTo(line.mas_bottom).mas_offset(10);
        make.bottom.mas_equalTo(bgview.mas_bottom).mas_offset(-10);
        make.height.mas_offset(36);
        make.width.mas_offset(80);
    }];
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_btn2.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(_btn2.mas_centerY);
        make.height.mas_offset(36);
        make.width.mas_offset(80);
    }];
    [_btn1 setBoundWidth:0 cornerRadius:4];
    [_btn2 setBoundWidth:0 cornerRadius:4];
    [bgview setBoundWidth:1 cornerRadius:10 boardColor:BASECOLOR_BOARD];
}

- (void)clickBtn:(UIButton *)btn
{
    if (self.clickBlock) {
        self.clickBlock(btn.tag);
    }
}
@end
