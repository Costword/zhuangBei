//
//  zNoticeUpDownCell.m
//  ZhuangBei
//
//  Created by aa on 2020/7/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zNoticeUpDownCell.h"
#import "MarqueeView.h"

const CGFloat kleftMargin = 20.f;

@interface zNoticeUpDownCell ()

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIImageView * noticImageView;

@property (nonatomic, strong) MarqueeView *marqueeView;

@end

@implementation zNoticeUpDownCell

+(zNoticeUpDownCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zNoticeUpDownCell";
    zNoticeUpDownCell * cell = [[zNoticeUpDownCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
//        _baseView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
//        _baseView.layer.borderWidth = 1;
//        _baseView.layer.cornerRadius = kWidthFlot(8);
    }
    return _baseView;
}

-(UIImageView*)noticImageView
{
    if (!_noticImageView) {
        _noticImageView = [[UIImageView alloc]init];
        _noticImageView.contentMode = UIViewContentModeScaleAspectFit;
        _noticImageView.image = [UIImage imageNamed:@"kefuicon"];
    }
    return _noticImageView;
}

- (MarqueeView *)marqueeView{

    if (!_marqueeView) {
        MarqueeView *marqueeView =[[MarqueeView alloc]initWithFrame:CGRectMake(kleftMargin + kWidthFlot(30), 10, SCREEN_WIDTH-(kleftMargin*2+kWidthFlot(30)), kWidthFlot(30)) withTitle:@[]];
        marqueeView.titleColor = [UIColor blackColor];
        marqueeView.titleFont = [UIFont systemFontOfSize:12];
        marqueeView.backgroundColor = [UIColor clearColor];
        __weak MarqueeView *marquee = marqueeView;
        marqueeView.handlerTitleClickCallBack = ^(NSInteger index){
            
            NSLog(@"%@----%zd",marquee.titleArr[index-1],index);
        };
        _marqueeView = marqueeView;
    }
    return _marqueeView;

}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.baseView];
        [self.baseView addSubview:self.noticImageView];
        [self.baseView addSubview:self.marqueeView];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.top.mas_equalTo(kWidthFlot(5));
        make.bottom.mas_equalTo(-kWidthFlot(5));
        make.height.mas_equalTo(kWidthFlot(50));
    }];
    
    [self.noticImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(10));
        make.centerY.mas_equalTo(self.baseView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(30), kWidthFlot(30)));
    }];
    [self.marqueeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.noticImageView.mas_right).offset(kWidthFlot(5));
        make.right.mas_equalTo(self.baseView.mas_right).offset(-kWidthFlot(5));
        make.centerY.mas_equalTo(self.baseView.mas_centerY);
        make.height.mas_equalTo(kWidthFlot(30));
    }];
    
}

-(void)setArray:(NSArray *)Array
{
    _Array = Array;
    
    NSMutableArray * titlesArr = [NSMutableArray array];
    [Array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary * dic = Array[idx];
        NSInteger current = idx+1;
        NSString * title = [NSString stringWithFormat:@"%ld %@",current,dic[@"gongGaoBt"]];
        [titlesArr addObject:title];
    }];
    self.marqueeView.titleArr = titlesArr;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}

@end
