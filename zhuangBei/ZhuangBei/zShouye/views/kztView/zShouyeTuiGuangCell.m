//
//  zShouyeTuiGuangCell.m
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/10.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zShouyeTuiGuangCell.h"
#import "zShouyeTuiguangCollectionCell.h"

@interface zShouyeTuiGuangCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIImageView * iconView;
@property(strong,nonatomic)UILabel * titleLabel;
@property(strong,nonatomic)UICollectionView * collectionView;


@end

@implementation zShouyeTuiGuangCell

+(zShouyeTuiGuangCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zBaoKuanCell";
    zShouyeTuiGuangCell * cell = [[zShouyeTuiGuangCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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
           layout.sectionInset = UIEdgeInsetsMake(0,10, 0, 10);
           layout.scrollDirection = UICollectionViewScrollDirectionVertical;
           UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
           collectionView.backgroundColor = [UIColor clearColor];
           collectionView.showsVerticalScrollIndicator = NO;
           collectionView.showsHorizontalScrollIndicator = NO;
           collectionView.scrollEnabled = NO;
           collectionView.allowsSelection = YES;
           collectionView.delegate = self;
           collectionView.dataSource = self;
           [collectionView registerClass:[zShouyeTuiguangCollectionCell class] forCellWithReuseIdentifier:@"zShouyeTuiguangCollectionCell"];
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
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(10));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1).priorityLow();
        make.bottom.mas_equalTo(-kWidthFlot(10));
    }];
}

-(void)setSourceArray:(NSArray *)sourceArray
{
    _sourceArray = sourceArray;
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
//    CGFloat height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    CGFloat width  = (SCREEN_WIDTH-20-kWidthFlot(10))/2;
    
    CGFloat hei = width * 0.6 * 2 + kWidthFlot(10);
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hei).priorityHigh();
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    zShouyeTuiguangCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zShouyeTuiguangCollectionCell" forIndexPath:indexPath];
    NSDictionary * dic = self.sourceArray[indexPath.item];
    cell.sourceDic = dic;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width  = (SCREEN_WIDTH-20-kWidthFlot(10))/2;
    return CGSizeMake(width, width*0.6);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary * dic =@{};
//    if (self.baokuanTapback) {
//        self.baokuanTapback(dic);
//    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}


@end
