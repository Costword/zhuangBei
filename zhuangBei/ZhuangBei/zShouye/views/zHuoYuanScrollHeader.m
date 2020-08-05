//
//  zHuoYuanScrollHeader.m
//  ZhuangBei
//
//  Created by aa on 2020/5/7.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zHuoYuanScrollHeader.h"
//#import "NewPagedFlowView.h"
//#import "PGIndexBannerSubiew.h"
//#import "PGCustomBannerView.h"
#import "WMZBannerView.h"
#import "MyCell.h"

@interface zHuoYuanScrollHeader ()

@property(strong,nonatomic)NSMutableArray * imageArray;

@end

@implementation zHuoYuanScrollHeader



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        [self demoOne];
        [self updateConstraintsForView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)creatBanner{
    WMZBannerParam *param =
        BannerParam()
       //自定义视图必传
       .wMyCellClassNameSet(@"MyCell")
       .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, id model, UIImageView *bgImageView,NSArray*dataArr) {
                  //自定义视图
           MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyCell class]) forIndexPath:indexPath];
           cell.leftText.text = model[@"name"];
           [cell.icon setImage:model[@"image"]];
           return cell;
       })
       .wFrameSet(CGRectMake(0,0, BannerWitdh, (BannerWitdh-40)*1080/1920))
    .wDataSet(self.imageArray)
       //关闭pageControl
       .wHideBannerControlSet(YES)
       //自定义item的大小
       .wItemSizeSet(CGSizeMake(BannerWitdh*0.8, (BannerWitdh-40)*1080/1920))
       //固定移动的距离
       .wContentOffsetXSet(0.5)
    //   //自动滚动
       .wAutoScrollSet(YES)
        //循环
        .wRepeatSet(YES)
       //整体左右间距  设置为size.width的一半 让最后一个可以居中
       .wSectionInsetSet(UIEdgeInsetsMake(0,20, 0, (BannerWitdh-40)*0.55*0.3))
       //间距
       .wLineSpacingSet(20)
       ;
       WMZBannerView *bannerView = [[WMZBannerView alloc]initConfigureWithModel:param];
       [self addSubview:bannerView];
    }


-(void)updateConstraintsForView
{

}

-(void)setBannerArray:(NSArray *)bannerArray
{
    [self.imageArray removeAllObjects];
    [bannerArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * imageName = bannerArray[idx];
        UIImage *image = [UIImage imageNamed:imageName];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:[NSString stringWithFormat:@"%ld/%ld",idx+1,bannerArray.count] forKey:@"name"];
        [dic setObject:image forKey:@"image"];
        [self.imageArray addObject:dic];
    }];
    [self creatBanner];
}

-(NSMutableArray*)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end
