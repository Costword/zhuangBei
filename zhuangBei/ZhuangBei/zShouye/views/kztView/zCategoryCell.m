//
//  zCategoryCell.m
//  ZhuangBei
//
//  Created by aa on 2020/7/20.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zCategoryCell.h"
#import "MarqueeView.h"
#import "zCategoryCollectCell.h"

//const CGFloat kCategoryLeftMargin = 20.f;

static NSString * scrollItemCell_id = @"zCategoryCollectCell";

@interface zCategoryCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UIImageView * noticImageView;

@property(strong,nonatomic)UICollectionView * collectionView;

@end

@implementation zCategoryCell

+(zCategoryCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zCategoryCell";
    zCategoryCell * cell = [[zCategoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView*)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
        _baseView.layer.borderColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
        _baseView.layer.borderWidth = 1;
        _baseView.layer.cornerRadius = kWidthFlot(8);
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
        layout.minimumLineSpacing = kWidthFlot(1);
        layout.minimumInteritemSpacing = kWidthFlot(1);
        layout.sectionInset = UIEdgeInsetsMake(kWidthFlot(10),0, 0, 0);
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-20-kWidthFlot(40))/5, kWidthFlot(80));
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.scrollEnabled = NO;
        collectionView.allowsSelection = YES;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[zCategoryCollectCell class] forCellWithReuseIdentifier:scrollItemCell_id];
        _collectionView = collectionView;
    }
    return _collectionView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.baseView];
        [self.baseView addSubview:self.collectionView];
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
        make.height.mas_equalTo(kWidthFlot(100));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0,10,0,10));
        make.height.mas_equalTo(kWidthFlot(90)).priorityHigh();
    }];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.Array.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    zCategoryCollectCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:scrollItemCell_id forIndexPath:indexPath];
    cell.sourceDic = self.Array[indexPath.item];
    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = self.Array[indexPath.item];
    if (self.categoryTapBack) {
        self.categoryTapBack(dic);
    }
}


-(void)setArray:(NSArray *)Array
{
    _Array = Array;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        
    }else
    {
        
    }
}

@end
