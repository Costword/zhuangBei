//
//  zCompanyDetailCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/8.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCompanyDetailCell.h"

@interface zCompanyDetailCell ()

@property(strong,nonatomic)UIButton * arrowButton;

@end

@implementation zCompanyDetailCell

+(zCompanyDetailCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zCompanyDetailCell";
    zCompanyDetailCell * cell = [[zCompanyDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIButton*)arrowButton
{
    if (!_arrowButton) {
        _arrowButton = [[UIButton alloc]init];
        _arrowButton.userInteractionEnabled = NO;
        [_arrowButton setImage:[UIImage imageNamed:@"chose_normal"] forState:UIControlStateNormal];
        [_arrowButton setImage:[UIImage imageNamed:@"chose_select"] forState:UIControlStateSelected];
        _arrowButton.titleLabel.font = [UIFont systemFontOfSize:kWidthFlot(12)];
        [_arrowButton setTitleColor:[UIColor colorWithHexString:@"#4A4A4A"] forState:UIControlStateNormal];
        //        [_arrowButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arrowButton;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.arrowButton];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(5));
        make.left.mas_equalTo(kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(20));
        make.bottom.mas_equalTo(-kWidthFlot(5));
    }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        
    }else{
        
    }
}


@end
