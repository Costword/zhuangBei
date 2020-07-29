//
//  zShouCeController.m
//  ZhuangBei
//
//  Created by aa on 2020/7/24.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zShouCeController.h"
#import "sliderNavMenu.h"
#import "zZhangjieVC.h"
#import "zWenDaVC.h"
#import "zBijiVC.h"


@interface zShouCeController ()<sliderNavMenuDelegate,UIScrollViewDelegate>

@property(strong,nonatomic)sliderNavMenu * navigationSliderMenu;

@property(strong,nonatomic)UILabel * titleLabel;

@property(strong,nonatomic)UILabel * descLabel;

@property(strong,nonatomic)UIScrollView* childScroContentView;

@property(strong,nonatomic)zZhangjieVC * zjVC;

@end

@implementation zShouCeController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.title = @"操作手册";
}

-(sliderNavMenu*)navigationSliderMenu
{
    if (!_navigationSliderMenu) {
        _navigationSliderMenu = [[sliderNavMenu alloc]init];
        _navigationSliderMenu.userInteractionEnabled = YES;
        _navigationSliderMenu.havesliderBar = YES;
        _navigationSliderMenu.fontSize = 17;
        _navigationSliderMenu.padding = kWidthFlot(30);
        _navigationSliderMenu.sliderRoundCorner = 1.5;
        _navigationSliderMenu.normalFontColor = [UIColor colorWithHexString:@"#666666"];
        _navigationSliderMenu.selectFontColor = [UIColor colorWithHexString:@"#333333"];
        [_navigationSliderMenu setSourceArray:@[@"课程章节",@"回答评论",@"笔记"]];
        _navigationSliderMenu.sliderType = menuAligenCenter;
        _navigationSliderMenu.delegate = self;
    }
    return _navigationSliderMenu;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blueColor];
        _titleLabel.text = @"课程简介";
        _titleLabel.font = kFont(18);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

-(UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.textColor = [UIColor blackColor];
        _descLabel.text = @"课程简介,课程咳咳咳咳咳咳";
        _descLabel.font = kFont(14);
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

-(UIScrollView *)childScroContentView{
    if (!_childScroContentView) {
        CGRect frame = self.view.bounds;
        
        frame.size.height = SCREEN_HEIGHT -(44+KstatusBarHeight);
        
        frame.origin.y =44+ KstatusBarHeight;
        _childScroContentView = [[UIScrollView alloc]initWithFrame:frame];
        _childScroContentView.delegate = self;
        _childScroContentView.contentSize = CGSizeMake(SCREEN_WIDTH *self.childViewControllers.count,0);
        _childScroContentView.pagingEnabled = YES;
        _childScroContentView.backgroundColor = [UIColor yellowColor];
        _childScroContentView.showsHorizontalScrollIndicator = NO;
        [self.view insertSubview:_childScroContentView atIndex:0];
        [self scrollViewDidEndScrollingAnimation:_childScroContentView];
    }
    return _childScroContentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navigationSliderMenu];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.descLabel];
    [self setupChildViewControllers];
    [self.view addSubview:self.childScroContentView];
    CGPoint offset = self.childScroContentView.contentOffset;
    offset.x = 0;
    [self.childScroContentView setContentOffset:offset animated:YES];
    
    [self loadData];
}

-(void)setupChildViewControllers
{
    //章节
    zZhangjieVC * zjVC = [[zZhangjieVC alloc]init];
    self.zjVC  = zjVC;
    [self addChildViewController:zjVC];
    
    //问答
    zWenDaVC* wedaVC = [[zWenDaVC alloc]init];
    [self addChildViewController:wedaVC];
    
    //笔记
    zBijiVC * bjVC = [[zBijiVC alloc]init];
    [self addChildViewController:bjVC];

}

-(void)loadData{
                
    [self requestPostWithUrl:kShouCeList paraString:@{@"wentiId":@"0",@"keChengDm":@"26",@"chuangjianId":@"1"} success:^(id  _Nonnull response) {
        NSLog(@"章节信息:%@",response);
        NSDictionary * dic = response[@"page"][@"keChengList"];
        NSArray * kcArray = dic[@"list"];
        self.zjVC.listArray = kcArray;
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.mas_topLayoutGuide).offset(10);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(20);
       make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    [self.navigationSliderMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.descLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
    }];
    
    [self.childScroContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navigationSliderMenu.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuide);
    }];
    
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:self.childScroContentView]) {
        //当前索引
        int index = (int)(scrollView.contentOffset.x / SCREEN_WIDTH);
        //拿到子控制器
        UIViewController *vc = self.childViewControllers[index];
        CGRect frame = vc.view.frame;
        frame.origin.x = scrollView.contentOffset.x;
        frame.origin.y = 0;// 设置控制器的y值为0(默认为20)
        //设置控制器的view的height值为整个屏幕的高度（默认是比屏幕少20）
        frame.size.height = scrollView.frame.size.height;
        vc.view.frame = frame;
        [scrollView addSubview:vc.view];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.childScroContentView]) {
        [self scrollViewDidEndScrollingAnimation:self.childScroContentView];
        //当前索引
        int index = (int)(scrollView.contentOffset.x / SCREEN_WIDTH);
        self.navigationSliderMenu.selectIndex = index;

    }
}


-(void)sliderNavMenuSelectIndex:(NSInteger)index
{
    CGPoint offset = self.childScroContentView.contentOffset;
    offset.x = index *SCREEN_WIDTH;
    [self.childScroContentView setContentOffset:offset animated:YES];
}

@end
