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

@property(strong,nonatomic)UIImageView * noticImageView;

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
-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
           layout.minimumLineSpacing = kWidthFlot(10);
           layout.sectionInset = UIEdgeInsetsMake(0,0, 0, 0);
           layout.itemSize = CGSizeMake(SCREEN_WIDTH - kWidthFlot(95), kWidthFlot(80));
           layout.scrollDirection = UICollectionViewScrollDirectionVertical;
           UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
           collectionView.backgroundColor = [UIColor clearColor];
           collectionView.showsVerticalScrollIndicator = NO;
           collectionView.showsHorizontalScrollIndicator = NO;
           collectionView.scrollEnabled = NO;
           collectionView.allowsSelection = NO;
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
        [self.baseView addSubview:self.noticImageView];
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
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    zBaoKuanItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:scrollItemCell_id forIndexPath:indexPath];
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}

@end
