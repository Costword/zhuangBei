//
//  zBaoKuanCell.m
//  ZhuangBei
//
//  Created by aa on 2020/7/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zBaoKuanCell.h"
#import "MarqueeView.h"
#import "zBaoKuanItemCell.h"

//const CGFloat kleftMargin = 20.f;

static NSString * scrollItemCell_id = @"zBaoKuanItemCell";

@interface zBaoKuanCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIImageView * iconView;
@property(strong,nonatomic)UILabel * titleLabel;
@property(strong,nonatomic)UICollectionView * collectionView;

@end

@implementation zBaoKuanCell

+(zBaoKuanCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zBaoKuanCell";
    zBaoKuanCell * cell = [[zBaoKuanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
//        _baseView.backgroundColor = [UIColor greenColor];
    }
    return _baseView;
}

-(UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.image = [UIImage imageNamed:@"fenge"];
        _iconView.backgroundColor = [UIColor whiteColor];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = kFont(16);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"爆款";
    }
    return _titleLabel;
}

-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
           layout.minimumLineSpacing = kWidthFlot(10);
           layout.sectionInset = UIEdgeInsetsMake(0,0, 0, 0);
           CGFloat width = (SCREEN_WIDTH - kWidthFlot(95))/2;
           layout.itemSize = CGSizeMake(width, width*0.7);
           layout.scrollDirection = UICollectionViewScrollDirectionVertical;
           UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
           collectionView.backgroundColor = [UIColor clearColor];
           collectionView.showsVerticalScrollIndicator = NO;
           collectionView.showsHorizontalScrollIndicator = NO;
           collectionView.scrollEnabled = NO;
           collectionView.allowsSelection = YES;
           collectionView.delegate = self;
           collectionView.dataSource = self;
           [collectionView registerClass:[zBaoKuanItemCell class] forCellWithReuseIdentifier:scrollItemCell_id];
        _collectionView = collectionView;
    }
    return _collectionView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.baseView];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.collectionView];
        [self updateConstraintsForView];
    }
    return self;
}



-(void)updateConstraintsForView
{
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        make.height.mas_equalTo(kWidthFlot(160));
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kWidthFlot(20));
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(10),kWidthFlot(25)));
        make.top.mas_equalTo(kWidthFlot(10));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(kWidthFlot(10));
        make.size.mas_equalTo(CGSizeMake(kWidthFlot(100), kWidthFlot(20)));
        make.centerY.mas_equalTo(self.iconView.mas_centerY);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.bottom.mas_equalTo(-kWidthFlot(10));
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    zBaoKuanItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:scrollItemCell_id forIndexPath:indexPath];
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic =@{};
    if (self.baokuanTapback) {
        self.baokuanTapback(dic);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}

@end
