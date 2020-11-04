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
#import "UICollectionViewLeftAlignedLayout.h"
#import "phoneNumCheck.h"
#import "UITextField+maxLength.h"
#import "SelectedListView.h"
#import "SelectedListModel.h"
#import "zEducationRankTypeInfo.h"
#import "BLDatePickerView.h"
#import "zListTypeModel.h"
#import "zCityCollectionHeaderView.h"

@interface zcityCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,BLDatePickerViewDelegate>

@property(strong,nonatomic)UILabel * nameLabel;
@property(strong,nonatomic)UILabel * selectLabel;
@property(strong,nonatomic)UICollectionView * cityCollectView;
@property(strong,nonatomic)UIView * lineView;
@property(strong,nonatomic)NSMutableArray * myCityArray;

@property(assign,nonatomic)BOOL selectAll;
@end
@implementation zcityCell

+(zcityCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zPersonalCell";
    zcityCell * cell = [[zcityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(NSMutableArray*)myCityArray
{
    if (!_myCityArray) {
        _myCityArray = [NSMutableArray array];
    }
    return _myCityArray;
}

-(UILabel*)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        CGFloat fontsize =  kWidthFlot(16);
        _nameLabel.font = kFont(fontsize);
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

-(UILabel *)selectLabel
{
    if (!_selectLabel) {
        _selectLabel = [[UILabel alloc]init];
        _selectLabel.textColor = [UIColor colorWithHexString:@"#4A4A4A"];
        CGFloat fontsize =  kWidthFlot(16);
        _selectLabel.font = kFont(fontsize);
        _selectLabel.text = @"请选择";
        _selectLabel.numberOfLines = 0;
    }
    return _selectLabel;
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
        [_cityCollectView registerClass:[zCityCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"zCityCollectionHeaderView"];
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
        self.selectAll = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.selectLabel];
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
    
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kWidthFlot(10));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(25));
    }];

    [self.cityCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(kWidthFlot(10));
        make.left.mas_equalTo(kWidthFlot(20));
        make.right.mas_equalTo(-kWidthFlot(20));
        make.height.mas_equalTo(kWidthFlot(1)).priorityLow();
        make.bottom.mas_equalTo(-kWidthFlot(1));
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
    zListTypeModel * typeModel = self.persoamModel.city[indexPath.item];
    cell.model = typeModel;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    zCityCollectionHeaderView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"zCityCollectionHeaderView" forIndexPath:indexPath];
    header.selectAllTap = ^(BOOL selectAll) {
        weakSelf.selectAll = selectAll;
        
        if (selectAll) {
            [weakSelf.myCityArray removeAllObjects];
            [weakSelf.persoamModel.city enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                zListTypeModel * typeModel = weakSelf.persoamModel.city[idx];
                typeModel.select = YES;
                [weakSelf.myCityArray addObject:typeModel];
            }];
        }else
        {
            [weakSelf.persoamModel.city enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                zListTypeModel * typeModel = weakSelf.persoamModel.city[idx];
                typeModel.select = NO;
            }];
        }
        __block NSString * cityStr = @"";
        [self.myCityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                zListTypeModel * typeModel = self.myCityArray[idx];
                if (cityStr.length>0) {
                    cityStr = [NSString stringWithFormat:@"%@,%@",cityStr,typeModel.typeId];
        //            [cityStr appendFormat:@",%@", typeModel.typeId];
                }else
                {
                    cityStr = [NSString stringWithFormat:@"%@",typeModel.typeId];
                }
            }];
            NSLog(@"==============%@",cityStr);
            if (self.changeModelBack) {
                weakSelf.upModel.district = cityStr;
                weakSelf.changeModelBack(weakSelf.upModel,weakSelf.persoamModel);
            }
        [weakSelf.cityCollectView reloadData];
    };
    header.canEdit = _canEdit;
    header.selectAll = self.selectAll;
    return header;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    zListTypeModel * typeModel = self.persoamModel.city[indexPath.item];
    return [self stringSize:typeModel.name];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.canEdit) {
        return CGSizeMake(SCREEN_WIDTH, kWidthFlot(44));
    }else
    {
        return CGSizeMake(SCREEN_WIDTH, 0);
    }
    
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
    zListTypeModel * typeModel = self.persoamModel.city[indexPath.item];
    typeModel.select = !typeModel.select;
    if ([self.myCityArray containsObject:typeModel]) {
        self.selectAll = NO;
        [self.myCityArray removeObject:typeModel];
    }else
    {
        [self.myCityArray addObject:typeModel];
    }
    __block NSString * cityStr = @"";
    [self.myCityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        zListTypeModel * typeModel = self.myCityArray[idx];
        if (cityStr.length>0) {
            cityStr = [NSString stringWithFormat:@"%@,%@",cityStr,typeModel.typeId];
//            [cityStr appendFormat:@",%@", typeModel.typeId];
        }else
        {
            cityStr = [NSString stringWithFormat:@"%@",typeModel.typeId];
        }
    }];
    NSLog(@"==============%@",cityStr);
    if (self.changeModelBack) {
        _upModel.district = cityStr;
        self.changeModelBack(_upModel,_persoamModel);
    }
    [self.cityCollectView reloadData];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

-(void)setPersoamModel:(zPersonalModel *)persoamModel
{
    [self.myCityArray removeAllObjects];
    [persoamModel.city enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        zListTypeModel * model = persoamModel.city[idx];
        if (model.select) {
            [self.myCityArray addObject:model];
        }
    }];
    _persoamModel = persoamModel;
    self.nameLabel.text = persoamModel.name;
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
    if (canEdit) {
        //输入框有点击事件
//        self.inputTextFild.canTap = YES;
        self.cityCollectView.allowsSelection = YES;
    }else
    {
        //输入框无点击事件
//        self.inputTextFild.canTap = NO;
        self.cityCollectView.allowsSelection = NO;
    }
}



-(void)setUpModel:(zUpLoadUserModel *)upModel
{
    _upModel = upModel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}
@end
