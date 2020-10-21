//
//  ALaunchController.m
//  ZhuangBei
//  引导页
//  Created by 王明辉 on 2020/10/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import "ALaunchController.h"
#import "ALauchCollectionViewCell.h"
#import "zDengluController.h"
#import "MainNavController.h"
#import "launchManger.h"
@interface ALaunchController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UIView * baseView;

@property(strong,nonatomic)UICollectionView * collectionView;

@property(strong,nonatomic)UIScrollView  *  scrollView;

@property(strong,nonatomic)NSArray * sourceArray;

@end

@implementation ALaunchController

-(UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc]init];
    }
    return _baseView;
}


-(UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0.1;
        layout.minimumInteritemSpacing = 0.1;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.alwaysBounceVertical = NO;
        collectionView.scrollEnabled = NO;
        collectionView.allowsSelection = YES;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[ALauchCollectionViewCell class] forCellWithReuseIdentifier:@"ALauchCollectionViewCell"];
        _collectionView = collectionView;
    }
    return _collectionView;
}

-(NSArray *)sourceArray
{
    if (!_sourceArray) {
        _sourceArray = @[
            @{
                @"image":@"splash1",
                @"tag":@"0"
            },
            @{
                @"image":@"splash2",
                @"tag":@"1"
            },
            @{
                @"image":@"splash3",
                @"tag":@"2"
            },
            @{
                @"image":@"splash4",
                @"tag":@"3"
            },
            @{
                @"image":@"splash5",
                @"tag":@"4"
            }
        ];
    }
    return _sourceArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.baseView];
    [self.baseView addSubview:self.collectionView];
    [self updateViewConstraintForView];
}

-(void)updateViewConstraintForView
{
    [super viewDidLayoutSubviews];
    
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ALauchCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ALauchCollectionViewCell" forIndexPath:indexPath];
    cell.imagedic = self.sourceArray[indexPath.item];
    [cell.launchSignal subscribeNext:^(id  _Nullable x) {
        UIButton * btn  = x;
        if (btn.tag<self.sourceArray.count-1) {
            NSIndexPath  * index = [NSIndexPath indexPathForItem:btn.tag+1 inSection:0];
            [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
    }];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item<self.sourceArray.count-1) {
        NSIndexPath  * index = [NSIndexPath indexPathForItem:indexPath.item+1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }else
    {
        NSLog(@"没有啦，显示首页");
        [[launchManger shareInstance] saveLaunchKey];
        zDengluController * rootVC  = [[zDengluController alloc]init];
        MainNavController * rootNav = [[MainNavController alloc]initWithRootViewController:rootVC];
        rootNav.navigationBar.hidden = YES;
        UIApplication *app = [UIApplication sharedApplication];
        [app keyWindow].rootViewController = rootNav;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}


@end
