//
//  zcityCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/3.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zcityCell.h"
#import "editTextField.h"
#import "zCityCollectionCell.h"
//#import "handWritingListLayout.h"
#import "UICollectionViewLeftAlignedLayout.h"

@interface zcityCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>

@property(strong,nonatomic)UILabel * nameLabel;
@property(strong,nonatomic)editTextField * inputTextFild;

@property(strong,nonatomic)UICollectionView * cityCollectView;

@property(strong,nonatomic)UIView * lineView;

@end
@implementation zcityCell

+(zcityCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zPersonalCell";
    zcityCell * cell = [[zcityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _nameLabel.font = kFont(18);
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

-(editTextField*)inputTextFild
{
    if (!_inputTextFild) {
        _inputTextFild = [[editTextField alloc]init];
        _inputTextFild.icon = [UIImage imageNamed:@"blank"];
        _inputTextFild.keyboardType = UIKeyboardTypeDefault;
        _inputTextFild.textAlignment = NSTextAlignmentRight;
        _inputTextFild.delegate = self;
    }
    return _inputTextFild;
}

-(UICollectionView*)cityCollectView
{
    if (!_cityCollectView) {
        UICollectionViewLeftAlignedLayout * layout = [[UICollectionViewLeftAlignedLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(10,0, 10,0);
        layout.minimumLineSpacing = kWidthFlot(10);
        layout.minimumInteritemSpacing = kWidthFlot(10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _cityCollectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _cityCollectView.showsVerticalScrollIndicator = NO;
        _cityCollectView.backgroundColor = [UIColor clearColor];
        _cityCollectView.delegate = self;
        _cityCollectView.dataSource = self;
        _cityCollectView.scrollEnabled = NO;
        [_cityCollectView registerClass:[zCityCollectionCell class] forCellWithReuseIdentifier:@"zCityCollectionCell"];
        _cityCollectView.delegate = self;
        _cityCollectView.dataSource = self;
    }
    return _cityCollectView;
}

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#979797"];
    }
    return _lineView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.inputTextFild];
        [self.contentView addSubview:self.cityCollectView];
        [self.contentView addSubview:self.lineView];
        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(10));
        make.left.mas_equalTo(kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(25));
    }];
    [self.inputTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.width.mas_equalTo(kWidthFlot(200));
        make.height.mas_equalTo(kWidthFlot(25));
    }];

    [self.cityCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(1)).priorityLow();
        make.bottom.mas_equalTo(-kWidthFlot(20));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.persoamModel.city.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    zCityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zCityCollectionCell" forIndexPath:indexPath];
    cell.backColor = [UIColor colorWithHexString:@"#EFEFEF"];
    NSString * city = self.persoamModel.city[indexPath.item];
    cell.souceString = city;
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * city = self.persoamModel.city[indexPath.item];
    return [self stringSize:city];
//    return CGSizeMake(kWidthFlot(70), kWidthFlot(30));
}

- (CGSize)stringSize:(NSString *)string {
    if (string.length == 0) return CGSizeZero;
    UIFont * font = [UIFont systemFontOfSize:17];
    CGFloat yOffset = 3.0f;
    CGFloat width = self.bounds.size.width - 20;
    CGSize contentSize = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    CGSize size = CGSizeMake(MIN(contentSize.width + 20,width) , MAX(22, contentSize.height + 2 * yOffset + 1));
    return size;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * city = self.persoamModel.city[indexPath.item];
    NSLog(@"%@",city);
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return _canEdit;
}

-(void)setPersoamModel:(zPersonalModel *)persoamModel
{
    _persoamModel = persoamModel;
    self.nameLabel.text = persoamModel.name;
    self.inputTextFild.canShow = persoamModel.canShow;
    [self.inputTextFild setNeedsLayout];
    [self.inputTextFild layoutIfNeeded];
    
    if ([persoamModel.name isEqualToString:@"手机号码"]) {
        NSString *numberString = [persoamModel.content stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.inputTextFild.text = numberString;
    }else
    {
        self.inputTextFild.text = persoamModel.content;
    }
    if (persoamModel.city.count>0) {
        [self.cityCollectView reloadData];
        [self.cityCollectView layoutIfNeeded];
        CGFloat height = self.cityCollectView.collectionViewLayout.collectionViewContentSize.height;

        [self.cityCollectView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height).priorityHigh();
        }];
    }
}
-(void)setCanEdit:(BOOL)canEdit
{
    _canEdit = canEdit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}
@end
