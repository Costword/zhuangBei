//
//  LWHuoYuanThreeLevelListTableViewCell.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanThreeLevelListTableViewCell.h"

@interface LWHuoYuanThreeLevelListTableViewCell ()
@property (nonatomic, strong) UIImageView * goodsIv;
@property (nonatomic, strong) UILabel * goodsNameL;
@property (nonatomic, strong) UILabel * goodsDescL;
@property (nonatomic, strong) UILabel * desc1L;
@property (nonatomic, strong) UILabel * desc2L;
@end
@implementation LWHuoYuanThreeLevelListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self confiCellUI];
    }
    return self;
}

- (void)confiCellUI
{
    _goodsIv = [UIImageView new];
    _goodsNameL = [UILabel new];
    _goodsDescL = [UILabel new];
    _desc1L = [UILabel new];
    _desc2L = [UILabel new];
    
    UIImageView *moreBg = [UIImageView new];
    UIButton *morebtn = [UIButton new];
    [morebtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [morebtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    _goodsIv.image = IMAGENAME(@"testicon");
    _goodsNameL.text = @"防弹插板";
    _goodsNameL.font = kFont(16);
    _goodsDescL.text = @"特巡装备/软件>特警单警防护";
    _goodsDescL.font = kFont(13);
    _goodsDescL.textColor = UIColor.grayColor;
    morebtn.backgroundColor = UIColor.blueColor;
    morebtn.titleLabel.font = kFont(14);
    [self.contentView addSubviews:@[_goodsIv,_goodsNameL,_goodsDescL,_desc2L,_desc1L,moreBg,morebtn]];
    [_goodsIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(100);
        make.height.mas_offset(100);
        make.left.top.mas_equalTo(self.contentView).mas_offset(15);
    }];
    [_goodsNameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsIv.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(_goodsIv.mas_bottom).mas_offset(15);
    }];
    [_goodsDescL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsIv.mas_left);
        make.right.mas_equalTo(_goodsNameL.mas_right);
        make.top.mas_equalTo(_goodsNameL.mas_bottom).mas_offset(8);
    }];
    
//    UIView *lineview1 = [self lineView];
//    UIView *lineview2 = [self lineView];
//    [self.contentView addSubviews:@[lineview1,lineview2]];
//    [lineview1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_goodsIv.mas_right).mas_offset(20);
//        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(20);
//    }];
//    [_desc1L mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(lineview1.mas_right).mas_offset(10);
//        make.centerY.mas_equalTo(lineview1.mas_centerY);
//    }];
//    [lineview2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(lineview1.mas_centerX);
//        make.top.mas_equalTo(lineview1.mas_bottom).mas_offset(10);
//    }];
//    [_desc2L mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(lineview2.mas_right).mas_offset(10);
//        make.centerY.mas_equalTo(lineview2.mas_centerY);
//    }];
    
    [moreBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(100);
        make.height.mas_offset(30);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-0);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(0);
    }];
    [morebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(100);
        make.height.mas_offset(30);
        make.centerY.mas_equalTo(moreBg.mas_centerY);
        make.centerX.mas_equalTo(moreBg.mas_centerX);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).mas_offset(10);
        make.bottom.mas_equalTo(self).mas_offset(-10);
        make.right.mas_equalTo(self).mas_offset(5);
    }];
    [self.contentView setBoundWidth:1 cornerRadius:10 boardColor:UIColor.grayColor];
    [self.goodsIv setBoundWidth:0.5 cornerRadius:0 boardColor:UIColor.grayColor];
    
    NSArray *items = @[@"河南国度时代",@"河北卫都",@"河南国度时代",@"河北卫都",];
    NSMutableArray *lables = [NSMutableArray array];
    for (int i = 0; i<items.count; i++) {
        UIView *itemview = [self lineView:items[i]];
        
        [self.contentView addSubview:itemview];
        [itemview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsIv.mas_right).mas_offset(20);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            if (lables.count == 0) {
                make.top.mas_equalTo(moreBg.mas_bottom).mas_offset(10);
            }else{
                UIView *lastview = lables.lastObject;
                make.top.mas_equalTo(lastview.mas_bottom).mas_offset(5);
            }
        }];
        [lables addObject:itemview];
    }
}

- (UIView *)lineView:(NSString *)text
{
    UIView *bg = [UIView new];
    UIView *des1 = [UIView new];
    UIView *des2 = [UIView new];
    des1.backgroundColor = UIColor.blueColor;
    des2.backgroundColor = UIColor.blueColor;
    des2.alpha = 0.3;
    [bg addSubviews:@[des2,des1]];
    [des1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(2);
        make.height.mas_offset(20);
        make.left.mas_equalTo(bg);
        make.centerY.mas_equalTo(bg.mas_centerY);
    }];
    [des2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(2);
        make.height.mas_offset(20);
//        make.top.bottom.mas_equalTo(bg);
        make.left.mas_equalTo(des1.mas_right).mas_offset(5);
//        make.right.mas_equalTo(bg.mas_right);
        make.centerY.mas_equalTo(bg.mas_centerY);
    }];
    UILabel *lable = [UILabel new];
    [bg addSubview:lable];
    lable.text = text;
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(des2.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(bg.mas_centerY);
        make.right.mas_equalTo(bg.mas_right);
        make.top.bottom.mas_equalTo(bg);
    }];
    return bg;
}
@end
