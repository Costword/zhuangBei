//
//  LWGongYingShangListTableViewCell.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWGongYingShangListTableViewCell.h"

@interface LWGongYingShangListTableViewCell()
@property (nonatomic, strong) UILabel * compnayL;
@property (nonatomic, strong) UILabel * farenL;
@property (nonatomic, strong) UILabel * phoneL;
@property (nonatomic, strong) UILabel * addressL;
@property (nonatomic, strong) UILabel * desL;
@property (nonatomic, strong) UIImageView * logo;
@property (nonatomic, strong) UIView * bgview;

@end

@implementation LWGongYingShangListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self confiCellUI];
    }
    return self;
}

- (void)confiCellUI
{
    _compnayL = [UILabel new];
    _farenL = [UILabel new];
    _phoneL = [UILabel new];
    _addressL = [UILabel new];
    _desL = [UILabel new];
    _logo = [UIImageView new];
    _bgview = [UIView new];
    UIView *line = [UIView new];
    line.backgroundColor = UIColor.grayColor;
    
    UILabel *startL = [UILabel new];
    
    [_bgview addSubviews:@[_compnayL,_farenL,_phoneL,_addressL,_desL,_logo,line,startL,]];
    [self.contentView addSubview:_bgview];
    _compnayL.font = kFont(20);
    _compnayL.text = @"河南国度时代警用装备有限公司";
    _farenL.text = @"法人：贾鹏宇";
    _phoneL.text = @"电话：13651188696";
    _addressL.text = @"地址：www.guodushidai.com";
    _desL.text = @"简介：警用器材技术研究及生产、销售；高分子复合材料、警示牌、交通安全防护设施、防爆器材、消防器材、办公设备、服装鞋帽、箱包、陶瓷制品、安全防范设备销售；计算机软件技术开发、技术服务、技术咨询、技术推广；备案范围内的进出口业务。（依法须经批准的项目，经相关部门批准后方可开展经营活动）";
    _desL.numberOfLines = 0;
    startL.text = @"星级:  ";
    _logo.image = IMAGENAME(@"testicon3");
    
    CGFloat margin_l = 15;
    CGFloat margin_t = 15;
    [_compnayL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bgview.mas_left).mas_offset(margin_l);
        make.right.mas_equalTo(_bgview.mas_right).mas_offset(-margin_l);
        make.top.mas_equalTo(_bgview.mas_top).mas_offset(20);
    }];
    [_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_bgview.mas_right).mas_offset(-15-20);
        make.top.mas_equalTo(_compnayL.mas_bottom).mas_offset(10);
        make.width.mas_offset(70);
        make.height.mas_offset(70);
    }];
    [_farenL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_compnayL.mas_left);
        make.right.mas_equalTo(_logo.mas_left).mas_offset(-10);
        make.top.mas_equalTo(_compnayL.mas_bottom).mas_offset(margin_t);
    }];
    [_phoneL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(_farenL);
        make.top.mas_equalTo(_farenL.mas_bottom).mas_offset(margin_t);
    }];
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(_farenL);
        make.top.mas_equalTo(_phoneL.mas_bottom).mas_offset(margin_t);
    }];
    [_desL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_compnayL);
        make.top.mas_equalTo(_addressL.mas_bottom).mas_offset(margin_t);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_compnayL.mas_left);
        make.right.mas_equalTo(_logo.mas_right);
        make.height.mas_offset(1);
        make.top.mas_equalTo(_desL.mas_bottom).mas_offset(margin_t+10);
    }];
    [startL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_compnayL.mas_left);
        make.top.mas_equalTo(line.mas_bottom).mas_offset(margin_t);
        make.bottom.mas_equalTo(_bgview.mas_bottom).mas_offset(-15);
    }];
    [_bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
    }];
    
    [_bgview setBoundWidth:1 cornerRadius:0 boardColor:UIColor.grayColor];
}
@end

