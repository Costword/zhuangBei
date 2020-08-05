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
- (void)demoOne{
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

- (NSArray*)getData{
    return @[
      @{@"name":@"自定义文本1",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744105022&di=f4aadd0b85f93309a4629c998773ae83&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1206%2F07%2Fc0%2F11909864_1339034191111.jpg"},
      @{@"name":@"自定义文本2",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744105022&di=f06819b43c8032d203642874d1893f3d&imgtype=0&src=http%3A%2F%2Fi2.sinaimg.cn%2Fent%2Fs%2Fm%2Fp%2F2009-06-25%2FU1326P28T3D2580888F326DT20090625072056.jpg"},
      @{@"name":@"自定义文本3",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1577338893&di=189401ebacb9704d18f6ab02b7336923&imgtype=jpg&er=1&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201308%2F05%2F20130805105309_5E2zE.jpeg"},
      @{@"name":@"自定义文本4",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744174216&di=36ffb42bf8757df08455b34c6b7d66c5&imgtype=0&src=http%3A%2F%2Fwww.7dapei.com%2Fimages%2F201203c%2F119.3.jpg"}
      ];
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
    [self demoOne];
}

-(NSMutableArray*)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end
