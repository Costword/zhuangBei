//
//  LWHuoYuanDeatilView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanDeatilView.h"

#import "SDCycleScrollView.h"

@interface LWHuoYuanDeatilView ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UILabel * nameL;
@property (nonatomic, strong) UILabel * companL;
@property (nonatomic, strong) UILabel * proveL;
@property (nonatomic, strong) UILabel * addressL;
//@property (nonatomic, strong) UILabel * productTitleL;
@property (nonatomic, strong) UILabel * productNickL;
//@property (nonatomic, strong) UILabel * xinghaoTitleL;
@property (nonatomic, strong) UILabel * xinghaoL;

@property (nonatomic, strong) UIView * canshuView;
@property (nonatomic, strong) UIView * lunboView;
@property (nonatomic, strong) UIView * infor_topview;

@property (nonatomic, strong) UILabel * chanpincailiaoL;
@property (nonatomic, strong) UILabel * fanghucailiaoL;
@property (nonatomic, strong) UILabel * fanghumianjiL;
@property (nonatomic, strong) UILabel * guigeL;
@property (nonatomic, strong) UILabel * guigedescL;
@property (nonatomic, strong) UILabel * zhixingbiaozhunL;
@property (nonatomic, strong) UIView * chanpinJieSaoView;

@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, strong) UIView * canshuDeatilView;
@property (nonatomic, strong) UILabel * canshuDeatilView_titleL;
@property (nonatomic, strong) UILabel * canshuDeatilView_descL;
@end

@implementation LWHuoYuanDeatilView

- (void)clickCanItems:(UITapGestureRecognizer *)tap
{
    NSLog(@"-------------点击参数的item:%ld",tap.view.tag);
    _maskView = [UIView new];
    _maskView.backgroundColor = UIColor.blackColor;
    _maskView.alpha = 0.3;
    [_maskView ex_addTapAction:self selector:@selector(clickCanshuDeatilViewBtn)];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubviews:@[_maskView,self.canshuDeatilView,]];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(window);
    }];
    [_canshuDeatilView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(window.mas_left).mas_offset(0);
        make.right.mas_equalTo(window.mas_right).mas_offset(-0);
        make.bottom.mas_equalTo(window.mas_bottom).mas_offset(0);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self confiUI];
    }
    return self;
}

- (void)confiUI
{
    
    
    _scrollView = [UIScrollView new];
    
    
    
    
    _nameL = [LWLabel lw_lable:@"防弹插板" font:21 textColor:BASECOLOR_GREYCOLOR155];;
    _companL = [LWLabel lw_lable:@"后台输入的公司名称" font:16 textColor:BASECOLOR_GREYCOLOR155];;
    _proveL = [LWLabel lw_lable:@"后台输入的所在省份" font:16 textColor:BASECOLOR_GREYCOLOR155];
    _addressL = [LWLabel lw_lable:@"后台输入的供应来源" font:16 textColor:BASECOLOR_GREYCOLOR155];
    _productNickL = [LWLabel lw_lable:@"  暂无  " font:16 textColor:UIColor.grayColor backColor:BASECOLOR_GREYCOLOR155];
    _xinghaoL = [LWLabel lw_lable:@"  FDB3F-GD03型  " font:16 textColor:RGB(63, 80, 181)];
    UILabel *nickL = [LWLabel lw_lable:@"产品别称" font:18 textColor:BASECOLOR_TEXTCOLOR];
    UILabel *xinghaoL = [LWLabel lw_lable:@"产品型号" font:18 textColor:BASECOLOR_TEXTCOLOR];
    
    
    _nameL.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    [_scrollView addSubviews:@[self.lunboView,_nameL,_productNickL,_xinghaoL,self.canshuView,xinghaoL,nickL]];
    
    
    [self.scrollView addSubview:self.infor_topview];
    
    CGFloat margin_l = 20;
    [self.lunboView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.scrollView);
        make.height.mas_offset(200);
    }];
    [_nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_scrollView.mas_left).mas_offset(margin_l);
        make.right.mas_equalTo(_scrollView.mas_right).mas_offset(-margin_l);
        make.width.mas_offset(SCREEN_WIDTH-margin_l-margin_l);
        make.top.mas_equalTo(_lunboView.mas_bottom).mas_offset(10);
    }];
    [self.infor_topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_nameL.mas_bottom).mas_offset(10);
    }];
    
    [nickL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_infor_topview.mas_bottom).mas_offset(15);
    }];
    [_productNickL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameL);
        make.top.mas_equalTo(nickL.mas_bottom).mas_offset(10);
        make.width.mas_greaterThanOrEqualTo(@(60));
        make.height.mas_offset(25);
    }];
    [xinghaoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_productNickL.mas_bottom).mas_offset(15);
    }];
    [_xinghaoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameL);
        make.top.mas_equalTo(xinghaoL.mas_bottom).mas_offset(10);
        make.height.mas_offset(25);
    }];
    [self.canshuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_xinghaoL.mas_bottom).mas_offset(10);
        make.bottom.mas_equalTo(_scrollView.mas_bottom).mas_offset(-20);
    }];
    
    _productNickL.textAlignment = NSTextAlignmentCenter;
    [_productNickL setBoundWidth:1 cornerRadius:0 boardColor:BASECOLOR_BOARD];
    [_xinghaoL setBoundWidth:1 cornerRadius:0 boardColor:RGB(63, 80, 181)];
    [self.canshuView setBoundWidth:0.5 cornerRadius:10 boardColor:BASECOLOR_BOARD];
    
    
    
}

/**
 公司相关信息
 */
- (UIView *)infor_topview
{
    if (!_infor_topview) {
        _infor_topview = [[UIView alloc] init];
        
        UILabel *comL =  [UILabel new];
        UILabel *proL = [UILabel new];
        UILabel *addL = [UILabel new];
        comL.text = @"公司名称:";
        proL.text = @"所在省份:";
        addL.text = @"供应来源:";
        comL.font = proL.font = addL.font = kFont(17);
        
        [_infor_topview addSubviews:@[_companL,_proveL,_addressL,comL,proL,addL]];
        
        [comL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_infor_topview.mas_left).mas_offset(5);
            make.top.mas_equalTo(_infor_topview.mas_top).mas_offset(10);
            make.width.mas_offset(80);
        }];
        [_companL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_infor_topview.mas_right).mas_offset(-10);
            make.left.mas_equalTo(comL.mas_right).mas_offset(10);
            make.top.mas_equalTo(comL.mas_bottom).mas_offset(5);
        }];
        [proL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(comL);
            make.top.mas_equalTo(_companL.mas_bottom).mas_offset(5);
        }];
        [_proveL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(_companL);
            make.top.mas_equalTo(proL.mas_bottom).mas_offset(5);
        }];
        [addL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(comL);
            make.top.mas_equalTo(_proveL.mas_bottom).mas_offset(5);
        }];
        [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_companL);
            make.top.mas_equalTo(addL.mas_bottom).mas_offset(5);
            make.bottom.mas_equalTo(_infor_topview.mas_bottom).mas_offset(-10);
        }];
        [_infor_topview setBoundWidth:1 cornerRadius:6 boardColor:BASECOLOR_BOARD];
        
        
        
    }
    return _infor_topview;
}

/**
 参数s
 */
- (UIView *)canshuView
{
    if (!_canshuView) {
        _canshuView = [[UIView alloc] init];
        UILabel *titleL = [LWLabel lw_lable:@"核心参数" font:18 textColor:BASECOLOR_TEXTCOLOR];
        titleL.textAlignment = NSTextAlignmentCenter;
        UIView *guigeview = [self createCanshuItem:@"规格保证" tag:1];
        UIView *shouhouview = [self createCanshuItem:@"售后保障" tag:2];
        UIView *caozuoview = [self createCanshuItem:@"操作手册" tag:3];
        [_canshuView addSubviews:@[titleL,guigeview,shouhouview,caozuoview,self.chanpinJieSaoView]];
        
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_canshuView.mas_left).mas_offset(0);
            make.right.mas_equalTo(_canshuView.mas_right).mas_offset(-0);
            make.top.mas_equalTo(_canshuView.mas_top).mas_offset(10);
        }];
        [guigeview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleL);
            make.top.mas_equalTo(titleL.mas_bottom).mas_offset(10);
            make.height.mas_offset(40);
        }];
        [shouhouview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleL);
            make.top.mas_equalTo(guigeview.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(guigeview.mas_height);
        }];
        [caozuoview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleL);
            make.top.mas_equalTo(shouhouview.mas_bottom).mas_offset(5);
            make.height.mas_equalTo(guigeview.mas_height);
        }];
        [self.chanpinJieSaoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleL);
            make.top.mas_equalTo(caozuoview.mas_bottom).mas_offset(10);
            make.bottom.mas_equalTo(_canshuView.mas_bottom).mas_offset(-10);
        }];
    }
    return _canshuView;
}

/**
 核心参数的item
 */
- (UIView *)createCanshuItem:(NSString *)leftstr tag:(NSInteger)tag
{
    UIView *bg = [UIView new];
    UILabel *leftL = [LWLabel lw_lable:leftstr font:16 textColor:BASECOLOR_TEXTCOLOR];
    UIButton *rightBtn = [UIButton new];
    [rightBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    [rightBtn setImage:IMAGENAME(@"icon_into") forState:UIControlStateNormal];
    rightBtn.titleLabel.font = kFont(12);
    [rightBtn setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
    [bg addSubviews:@[leftL,rightBtn]];
    [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bg.mas_left).mas_offset(10);
        make.centerY.mas_equalTo(bg.mas_centerY);
    }];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bg.mas_right).mas_offset(-10);
        make.centerY.mas_equalTo(bg.mas_centerY);
    }];
    [bg setBoundWidth:0.5 cornerRadius:6 boardColor:BASECOLOR_BOARD];
    [rightBtn layoutButtonWithEdgeInsetsStyle:(HLButtonEdgeInsetsStyleRight) imageTitleSpace:5];
    bg.tag = tag;
    [bg ex_addTapAction:self selector:@selector(clickCanItems:)];
    return bg;
}

/**
 轮播图
 */
- (UIView *)lunboView
{
    if (!_lunboView) {
        _lunboView = [[UIView alloc] init];
        SDCycleScrollView *sdcview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) delegate:self placeholderImage:IMAGENAME(@"")];
        sdcview.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588222683633&di=0337ab9e9f7deb643986cd7fd901290a&imgtype=0&src=http%3A%2F%2Fimg10.itiexue.net%2F1639%2F16390450.jpg",
                                         @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=179383074,1972838511&fm=26&gp=0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1588222683626&di=1f5ad07a32278031e3dd2c4d7a6fe33a&imgtype=0&src=http%3A%2F%2Fimgsa.baidu.com%2Fbaike%2Fpic%2Fitem%2F3c6d55fbb2fb43167ae9586c29a4462309f7d335.jpg"];
        sdcview.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        sdcview.pageDotColor = UIColor.blackColor;
        sdcview.currentPageDotColor = UIColor.grayColor;
        [_lunboView addSubview:sdcview];
        [sdcview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_lunboView);
        }];
    }
    return _lunboView;
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    
}

/**
 产品介绍
 */
- (UIView *)chanpinJieSaoView
{
    if (!_chanpinJieSaoView) {
        _chanpinJieSaoView = [[UIView alloc] init];
        UILabel *titleL = [UILabel new];
        _chanpincailiaoL = [UILabel new];
        _fanghucailiaoL = [UILabel new];
        _fanghumianjiL = [UILabel new];
        _guigeL = [UILabel new];
        _guigedescL = [UILabel new];
        _zhixingbiaozhunL = [UILabel new];
        
        titleL.text = @"产品介绍";
        _chanpincailiaoL.text = @"产品材料：PE";
        _fanghucailiaoL.text = @"防护材料：以高性能聚乙烯纤维，防弹陶瓷，防弹钢板等材料复合成型。";
        _fanghumianjiL.text = @"防护面积：0.07平方";
        _guigeL.text = @"规       格：250mm*300mm";
        _guigedescL.text = @"其他星座和面积可根据用户需求制作";
        _zhixingbiaozhunL.text = @"执行标准：产品已通过公安部特种警用装备质量监督检测中心检验，各项要求符合《A141-2010》、《NIJ101.06》中有关要求";
        
        _zhixingbiaozhunL.numberOfLines = 0;
        _fanghucailiaoL.numberOfLines = _chanpincailiaoL.numberOfLines = _fanghucailiaoL.numberOfLines = _guigeL.numberOfLines = _guigedescL.numberOfLines  = 0;
        _fanghucailiaoL.font = _fanghucailiaoL.font = _fanghumianjiL.font = _guigedescL.font = _guigeL.font = _zhixingbiaozhunL.font = _chanpincailiaoL.font = kFont(12);
        titleL.font = kFont(16);
        NSString *tem = @"防护面积";
        CGSize size = [tem limitSize:CGSizeMake(SCREEN_WIDTH - 40, 20) font:kFont(12)];
        [_chanpinJieSaoView addSubviews:@[titleL,_chanpincailiaoL,_fanghucailiaoL,_fanghumianjiL,_guigeL,_guigedescL,_zhixingbiaozhunL]];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_chanpinJieSaoView).mas_offset(10);
            make.right.mas_equalTo(_chanpinJieSaoView.mas_right).mas_offset(-10);
        }];
        [_chanpincailiaoL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleL);
            make.top.mas_equalTo(titleL.mas_bottom).mas_offset(5);
        }];
        [_fanghucailiaoL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleL);
            make.top.mas_equalTo(_chanpincailiaoL.mas_bottom).mas_offset(5);
        }];
        [_fanghumianjiL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleL);
            make.top.mas_equalTo(_fanghucailiaoL.mas_bottom).mas_offset(5);
        }];
        [_guigeL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleL);
            
            make.top.mas_equalTo(_fanghumianjiL.mas_bottom).mas_offset(5);
        }];
        [_guigedescL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(titleL);
            make.left.mas_equalTo(titleL.mas_left).mas_offset(size.width+5);
            make.top.mas_equalTo(_guigeL.mas_bottom).mas_offset(5);
        }];
        [_zhixingbiaozhunL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleL);
            make.top.mas_equalTo(_guigedescL.mas_bottom).mas_offset(5);
            make.bottom.mas_equalTo(_chanpinJieSaoView.mas_bottom).mas_offset(-10);
        }];
        [_chanpinJieSaoView setBoundWidth:0.5 cornerRadius:6 boardColor:BASECOLOR_BOARD];
    }
    return _chanpinJieSaoView;
}

- (void)clickCanshuDeatilViewBtn
{
    [_maskView removeFromSuperview];
    [_canshuDeatilView removeFromSuperview];
    _maskView = nil;
    _canshuDeatilView = nil;
}

//参数详情
- (UIView *)canshuDeatilView
{
    if (!_canshuDeatilView) {
        _canshuDeatilView = [[UIView  alloc] init];
        _canshuDeatilView.backgroundColor = UIColor.whiteColor;
        
        UILabel *titleL = [LWLabel lw_lable:@"售后保障" font:18 textColor:BASECOLOR_TEXTCOLOR];
        UILabel *desL = [LWLabel lw_lable:@"一年保修，终生维修" font:18 textColor:BASECOLOR_TEXTCOLOR];
        titleL.textAlignment = desL.textAlignment = NSTextAlignmentCenter;
        UIButton *btn = [LWButton lw_lable:@"完成" font:15 textColor:UIColor.whiteColor backColor:[UIColor colorWithRed:63/255.0 green:80/255.0 blue:181/255.0 alpha:1.0] target:self acction:@selector(clickCanshuDeatilViewBtn)];
        [btn setBoundWidth:0 cornerRadius:6];
        
        [_canshuDeatilView addSubviews:@[titleL,desL,btn]];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_canshuDeatilView.mas_left).mas_offset(0);
            make.right.mas_equalTo(_canshuDeatilView.mas_right).mas_offset(-0);
            make.top.mas_equalTo(_canshuDeatilView.mas_top).mas_offset(30);
        }];
        [desL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(titleL);
            make.top.mas_equalTo(titleL.mas_bottom).mas_offset(20);
        }];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_canshuDeatilView.mas_left).mas_offset(30);
            make.right.mas_equalTo(_canshuDeatilView.mas_right).mas_offset(-30);
            make.top.mas_equalTo(desL.mas_bottom).mas_offset(20);
            make.height.mas_offset(40);
            make.bottom.mas_equalTo(_canshuDeatilView.mas_bottom).mas_offset(-1);
        }];
        _canshuDeatilView_titleL = titleL;
        _canshuDeatilView_descL = desL;
    }
    return _canshuDeatilView;
}

@end
