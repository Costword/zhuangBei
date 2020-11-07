//
//  searchCompanyCell.m
//  ZhuangBei
//
//  Created by 王明辉 on 2020/11/6.
//  Copyright © 2020 aa. All rights reserved.
//

#import "searchCompanyCell.h"

@interface searchCompanyCell ()

@property(strong,nonatomic)UILabel * AnswerLabel;//问题描述

@end

@implementation searchCompanyCell

+(searchCompanyCell*)creatTableViewCellWithTableView:(UITableView *)tableView AndIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString * CellID = [NSString stringWithFormat:@"AnswerCell%ld__%ld",indexPath.section,indexPath.row];
    searchCompanyCell * cell = [[searchCompanyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    return cell;
}


-(UILabel*)AnswerLabel
{
    if (!_AnswerLabel) {
        _AnswerLabel = [[UILabel alloc]init];
        _AnswerLabel.numberOfLines = 0;
        _AnswerLabel.font = [UIFont systemFontOfSize:16];
        _AnswerLabel.textColor = [UIColor blackColor];
    }
    return _AnswerLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.AnswerLabel];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    
    [self.AnswerLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
}


-(void)setSourceDic:(NSDictionary *)sourceDic
{
    _sourceDic = sourceDic;
    self.AnswerLabel.text = sourceDic[@"name"];
}

-(void)setAnswerLabelTextWith:(NSString*)text
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentLeft;  //对齐
    paraStyle.headIndent = 0.0f;//行首缩进
    //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    paraStyle.tailIndent = 0.0f;//行尾缩进
    paraStyle.lineSpacing = 2.0f;//行间距
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:paraStyle}];
    
    self.AnswerLabel.attributedText = attrText;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
//    self.choseBtn.selected  = selected;
//    if (selected) {
//
//    }else
//    {
//
//    }

}

@end
