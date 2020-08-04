//
//  LWHuoYuanDeatilView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanDeatilView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "SDCycleScrollView.h"
#import "zCityCollectionCell.h"
#import <WebKit/WebKit.h>
#import "SVGKImage.h"

@interface LWHuoYuanDeatilView ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UILabel * nameL;
@property (nonatomic, strong) UILabel * companL;
@property (nonatomic, strong) UILabel * proveL;
@property (nonatomic, strong) UILabel * addressL;
//@property (nonatomic, strong) UILabel * productTitleL;
//@property (nonatomic, strong) UILabel * productNickL;
@property (nonatomic, strong) UILabel * xinghaoL;

@property (nonatomic, strong) UIView * canshuView;
@property (nonatomic, strong) UIView * lunboView;
@property (nonatomic, strong) UIView * infor_topview;

@property (nonatomic, strong) UIView * chanpinJieSaoView;
@property (nonatomic, strong) WKWebView * productJieSaoL;
//@property (nonatomic, strong) LWLabel * productJieSaoL;
@property (nonatomic, strong) UILabel * productJiesao_titleL;
@property (nonatomic, assign) CGFloat  contentHeight_webview;

@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, strong) UIView * canshuDeatilView;
@property (nonatomic, strong) UIView * xhItemsView;
@property (nonatomic, strong) UICollectionView * cityCollectView;
@property (nonatomic, strong) SDCycleScrollView *sdcview;
@property (nonatomic, strong) UIView * paramItemsBgView;
@property (nonatomic, strong) NSArray * canshuDeatilArray;
@property (nonatomic, strong) UITableView * canshuDeatilTv;

@property (nonatomic, strong) NSArray * nicknameArray;
@property (nonatomic, strong) UICollectionView * nickname_collectView;
@property (nonatomic, strong) UIView * nickItemsView;
@end

@implementation LWHuoYuanDeatilView


- (void)setModel:(LWHuoYuanDeatilModel *)model
{
    _model = model;
    _nameL.text = _model.productInformation.zbName;
    _companL.text = _model.supplier.name;
    _proveL.text = _model.supplier.companyNameFirst;
    _addressL.text = _model.productInformation.productSourceName;
    
    NSString *tem_nickname_str = _model.productInformation.zbBieMing;
    if (![tem_nickname_str isNotBlank]) {
        modelListModel *model = [[modelListModel alloc] init];
        model.model = @"暂无";
        self.nicknameArray = @[model];
    }else{
        NSArray *temarr = [tem_nickname_str componentsSeparatedByString:@","];
        NSMutableArray *temmuarr = [NSMutableArray array];
        for (NSString *str in temarr    ) {
            modelListModel *model = [[modelListModel alloc] init];
            model.model = str;
            [temmuarr addObject:model];
        }
        self.nicknameArray = [temmuarr copy];
    }
    
    
    //   昵称
    [self.nickname_collectView reloadData];
    
    if (!model.modelList || model.modelList.count == 0) {
        modelListModel *model = [[modelListModel alloc] init];
        model.model = @"暂无";
        self.model.modelList = @[model];
    }
    //    产品类型
    [self.cityCollectView reloadData];
    
    
    //    图片
    if (_model.productPictureList.count > 0) {
        NSMutableArray *imageids = [[NSMutableArray alloc] init];
        for (productPictureListModel *picmodel in _model.productPictureList) {
            NSString *url = [NSString stringWithFormat:@"%@app/appfujian/download?attID=%@",kApiPrefix,picmodel.fuJianDm];
            [imageids addObject:url];
        }
        _sdcview.imageURLStringsGroup = imageids;
    }
    
    if (_model.productIntroduction.jianJieNr) {
        @try {
            NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style>img{max-width:100%}</style></header>";
            
            NSString *htmlstring = [headerString stringByAppendingString:_model.productIntroduction.jianJieNr] ;
            if ([htmlstring containsString:@"../../../"]) {
                htmlstring = [htmlstring stringByReplacingOccurrencesOfString:@"../../../" withString:[NSString stringWithFormat:@"%@",kApiPrefix]];
            }
            LWLog(@"*********%@",htmlstring);
            [_productJieSaoL loadHTMLString:htmlstring baseURL:nil];
        } @catch (NSException *exception) {
            LWLog(@"==========================%@====================",exception.description);
        } @finally {
            
        }
    }
    
//    //    更新约束
//    [self.cityCollectView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_offset(self.cityCollectView.collectionViewLayout.collectionViewContentSize.height).priorityHigh();
//    }];
//    [self.xhItemsView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_offset(self.cityCollectView.collectionViewLayout.collectionViewContentSize.height);
//    }];
}

- (void)clickCanItems:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    NSLog(@"-------------点击参数的item:%ld",tag);
    //    参数详情赋值
    NSMutableArray *tem = [NSMutableArray array];
    if (tag != 4) {
        for (productParameterListModel *parammodel in _model.productParameterList) {
            if (parammodel.canShuLx == tag) {
                [tem addObject:parammodel];
            }
        }
    }else{
        for (productEnclosureListModel *parammodel in _model.productEnclosureList) {
            [tem addObject:parammodel];
        }
    }
    if (tem.count == 0) {
        [zHud showMessage:@"暂无数据"];
        return;
    }
    
    _maskView = [UIView new];
    _maskView.backgroundColor = UIColor.blackColor;
    _maskView.alpha = 0.3;
    self.canshuDeatilView.alpha = 1;
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
    
    
    _canshuDeatilArray = [tem copy];
    [_canshuDeatilTv reloadData];
    
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
    
    _nameL = [LWLabel lw_lable:@"" font:21 textColor:BASECOLOR_GREYCOLOR155];
    _nameL.numberOfLines = 3;
    _companL = [LWLabel lw_lable:@"" font:16 textColor:BASECOLOR_GREYCOLOR155];;
    _companL.numberOfLines = 3;
    _proveL = [LWLabel lw_lable:@"" font:16 textColor:BASECOLOR_GREYCOLOR155];
    _proveL.numberOfLines = 3;
    _addressL = [LWLabel lw_lable:@"" font:16 textColor:BASECOLOR_GREYCOLOR155];
    _addressL.numberOfLines = 3;
//    _productNickL = [LWLabel lw_lable:@"" font:16 textColor:[UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0] backColor:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0]];
//    _productNickL.numberOfLines = 0;
    _xinghaoL = [LWLabel lw_lable:@"" font:16 textColor:RGB(63, 80, 181)];
    UILabel *nickL = [LWLabel lw_lable:@"产品别称" font:18 textColor:BASECOLOR_TEXTCOLOR];
    UILabel *xinghaoL = [LWLabel lw_lable:@"产品型号" font:18 textColor:BASECOLOR_TEXTCOLOR];
    
    _nameL.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    [_scrollView addSubviews:@[self.lunboView,_nameL,self.nickItemsView,self.xhItemsView,self.canshuView,xinghaoL,nickL]];
    
    
    [self.scrollView addSubview:self.infor_topview];
    
    CGFloat margin_l = 20;
    [self.lunboView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.scrollView);
        make.height.mas_offset(IS_IPAD ? 300 : 200);
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
      [_nickItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(nickL.mas_bottom).mas_offset(10);
        make.height.mas_offset(10);
    }];
    [xinghaoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_nickItemsView.mas_bottom).mas_offset(15);
    }];
    [_xhItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(xinghaoL.mas_bottom).mas_offset(10);
        make.height.mas_offset(10);
    }];
    [self.canshuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_nameL);
        make.top.mas_equalTo(_xhItemsView.mas_bottom).mas_offset(10);
        make.bottom.mas_equalTo(_scrollView.mas_bottom).mas_offset(-20);
    }];
    
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
        [_canshuView addSubviews:@[self.paramItemsBgView,self.chanpinJieSaoView]];
        [self.paramItemsBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_canshuView.mas_top).mas_offset(10);
            make.left.right.mas_equalTo(_canshuView);
        }];
        [self.chanpinJieSaoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_canshuView);
            make.top.mas_equalTo(self.paramItemsBgView.mas_bottom).mas_offset(10);
            make.bottom.mas_equalTo(_canshuView.mas_bottom).mas_offset(-10);
        }];
    }
    return _canshuView;
}

- (UIView *)paramItemsBgView
{
    if (!_paramItemsBgView) {
        _paramItemsBgView = [[UIView alloc] init];
        NSArray *items = @[@"核心参数",@"规格包装",@"售后保障",@"操作手册"];
        
        for (int i = 0; i < items.count; i++) {
            UIView *item =  [self createCanshuItem:items[i] tag:i+1];
            [self.paramItemsBgView addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.mas_equalTo(_paramItemsBgView);
                make.height.mas_offset(50);
                if (i == 0) {
                    make.top.mas_equalTo(_paramItemsBgView.mas_top).mas_offset(0);
                }else{
                    UIView *lastview = self.paramItemsBgView.subviews[self.paramItemsBgView.subviews.count - 2];
                    make.top.mas_equalTo(lastview.mas_bottom).mas_offset(5);
                }
                if (i == items.count - 1) {
                    make.bottom.mas_equalTo(_paramItemsBgView.mas_bottom).mas_offset(-5);
                }
            }];
        }
    }
    return _paramItemsBgView;
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
        
        SVGKImage *svgImage = [SVGKImage imageNamed:@"placeholdericon.svg"];
        svgImage.size = CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*0.618);
//        150
        SDCycleScrollView *sdcview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) delegate:self placeholderImage:svgImage.UIImage];
        _sdcview = sdcview;
        
        sdcview.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
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
        titleL.text = @"产品介绍";
        _productJiesao_titleL = titleL;
        titleL.font = kFont(16);
        [_chanpinJieSaoView addSubviews:@[self.productJieSaoL,titleL]];
        [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(_chanpinJieSaoView).mas_offset(10);
            make.right.mas_equalTo(_chanpinJieSaoView.mas_right).mas_offset(-10);
        }];
        [_productJieSaoL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(titleL);
            make.top.mas_equalTo(titleL.mas_bottom).mas_offset(5);
            make.height.mas_offset(1);
            make.bottom.mas_equalTo(_chanpinJieSaoView.mas_bottom).mas_offset(-10);
        }];
        
        [_chanpinJieSaoView setBoundWidth:0.5 cornerRadius:6 boardColor:BASECOLOR_BOARD];
        //        添加观察者
        [_productJieSaoL.scrollView addObserver:self forKeyPath:@"contentSize"
                                        options:NSKeyValueObservingOptionNew context:nil];
    }
    return _chanpinJieSaoView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context{
    if ([object isKindOfClass:[UICollectionView class]]){
           if(object == self.cityCollectView){
               //    更新约束
               [self.cityCollectView mas_updateConstraints:^(MASConstraintMaker *make) {
                   make.height.mas_offset(self.cityCollectView.collectionViewLayout.collectionViewContentSize.height).priorityHigh();
               }];
               [self.xhItemsView mas_updateConstraints:^(MASConstraintMaker *make) {
                   make.height.mas_offset(self.cityCollectView.collectionViewLayout.collectionViewContentSize.height);
               }];
           }else if(object == self.nickname_collectView){
              [self.nickname_collectView mas_updateConstraints:^(MASConstraintMaker *make) {
                  make.height.mas_offset(self.nickname_collectView.collectionViewLayout.collectionViewContentSize.height).priorityHigh();
              }];
              [self.nickItemsView mas_updateConstraints:^(MASConstraintMaker *make) {
                  make.height.mas_offset(self.nickname_collectView.collectionViewLayout.collectionViewContentSize.height);
              }];
           }
       }
}

- (void)clickCanshuDeatilViewBtn
{
    _maskView.alpha = 0;
    _canshuDeatilView.alpha = 0;
}

//参数详情
- (UIView *)canshuDeatilView
{
    if (!_canshuDeatilView) {
        _canshuDeatilView = [[UIView  alloc] init];
        _canshuDeatilView.backgroundColor = UIColor.whiteColor;
        UITableView *tableview = [[UITableView alloc] init];
        tableview.dataSource = self;
        tableview.rowHeight = UITableViewAutomaticDimension;
        tableview.estimatedRowHeight = 50;
        tableview.tableFooterView = [UIView new];
        [tableview registerClass:[LWCanShuDeatilTableCell class] forCellReuseIdentifier:@"LWCanShuDeatilTableCell"];
        UIButton *btn = [LWButton lw_button:@"完成" font:15 textColor:UIColor.whiteColor backColor:[UIColor colorWithRed:63/255.0 green:80/255.0 blue:181/255.0 alpha:1.0] target:self acction:@selector(clickCanshuDeatilViewBtn)];
        [btn setBoundWidth:0 cornerRadius:6];
        [_canshuDeatilView addSubviews:@[tableview,btn]];
        _canshuDeatilTv = tableview;
        [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_canshuDeatilView).mas_offset(0);
            make.top.mas_equalTo(_canshuDeatilView.mas_top).mas_offset(5);
            make.height.mas_offset(220);
        }];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_canshuDeatilView.mas_left).mas_offset(30);
            make.right.mas_equalTo(_canshuDeatilView.mas_right).mas_offset(-30);
            make.top.mas_equalTo(tableview.mas_bottom).mas_offset(20);
            make.height.mas_offset(40);
            make.bottom.mas_equalTo(_canshuDeatilView.mas_bottom).mas_offset(-1);
        }];
    }
    return _canshuDeatilView;
}

#pragma mark -----tablesourcedelegate -----

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWCanShuDeatilTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWCanShuDeatilTableCell" forIndexPath:indexPath];
    BaseModel *model = _canshuDeatilArray[indexPath.row];
    if ([model isKindOfClass:[productParameterListModel class]]) {
        productParameterListModel *prammodel = (productParameterListModel *)model;
        cell.leftL.text = prammodel.canShuMc;
        cell.descL.text = prammodel.canShuZhi;
    }else if ([model isKindOfClass:[productEnclosureListModel class]]) {
        productEnclosureListModel *prammodel = (productEnclosureListModel *)model;
        cell.descL.text = prammodel.name;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _canshuDeatilArray.count;
}

- (UIView *)nickItemsView
{
    if (!_nickItemsView) {
        _nickItemsView = [[UIView alloc] init];
        [_nickItemsView addSubview:self.nickname_collectView];
        [self.nickname_collectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_nickItemsView);
            make.height.mas_offset(self.nickname_collectView.collectionViewLayout.collectionViewContentSize.height).priorityHigh();
        }];
        [_nickname_collectView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    }
    return _nickItemsView;
}

- (UIView *)xhItemsView
{
    if (!_xhItemsView) {
        _xhItemsView = [[UIView alloc] init];
        [_xhItemsView addSubview:self.cityCollectView];
        [self.cityCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_xhItemsView);
            make.height.mas_offset(self.cityCollectView.collectionViewLayout.collectionViewContentSize.height).priorityHigh();
        }];
        [_cityCollectView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    }
    return _xhItemsView;
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

-(UICollectionView*)nickname_collectView
{
    if (!_nickname_collectView) {
        UICollectionViewLeftAlignedLayout * layout = [[UICollectionViewLeftAlignedLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(10,0, 10,0);
        layout.minimumLineSpacing = kWidthFlot(10);
        layout.minimumInteritemSpacing = kWidthFlot(10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _nickname_collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _nickname_collectView.showsVerticalScrollIndicator = NO;
        _nickname_collectView.backgroundColor = [UIColor clearColor];
        _nickname_collectView.delegate = self;
        _nickname_collectView.dataSource = self;
        _nickname_collectView.scrollEnabled = NO;
        [_nickname_collectView registerClass:[zCityCollectionCell class] forCellWithReuseIdentifier:@"zCityCollectionCell"];
        _nickname_collectView.delegate = self;
        _nickname_collectView.dataSource = self;
    }
    return _nickname_collectView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.cityCollectView) {
        return self.model.modelList.count;
    }else if (collectionView == self.nickname_collectView){
        return self.nicknameArray.count;
    }else{
        return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    zCityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zCityCollectionCell" forIndexPath:indexPath];
    cell.backColor = [UIColor colorWithHexString:@"#EFEFEF"];
    if (collectionView == self.cityCollectView) {
        modelListModel * model = self.model.modelList[indexPath.item];
        cell.souceString = model.model;
        if (![model.model isEqual:@"暂无"]) {
            cell.select = [model.customId isEqualToString:_currentModelId];
        }
    }else if (collectionView == self.nickname_collectView){
        modelListModel * model = self.nicknameArray[indexPath.item];
        cell.souceString = model.model;
    }
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    modelListModel * model = (collectionView == self.cityCollectView) ? self.model.modelList[indexPath.item]:self.nicknameArray[indexPath.row];
    return [self stringSize:model.model];
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
    if (collectionView == self.nickname_collectView || [self.model.modelList.firstObject.model isEqualToString:@"暂无"]) {
        return;
    }
    modelListModel * model = self.model.modelList[indexPath.item];
    NSLog(@"%@",model.model);
    self.currentModelId = model.customId;
    if (self.block) {
        self.block(model.customId);
    }
}

- (WKWebView *)productJieSaoL
{
    if (!_productJieSaoL) {
        _productJieSaoL = [[WKWebView alloc] init];
    }
    return _productJieSaoL;
}

-(void)dealloc
{
    NSLog(@"LWHuoYuanDeatilView ---- dealoc -------");
    [_productJieSaoL.scrollView removeObserver:self forKeyPath:@"contentSize"];
    [_cityCollectView removeObserver:self forKeyPath:@"contentSize"];
    [_nickname_collectView removeObserver:self forKeyPath:@"contentSize"];
}

@end

@implementation LWCanShuDeatilTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self confiCellUI];
    }
    return self;
}

- (void)confiCellUI
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _leftL = [LWLabel lw_lable:@"" font:15 textColor:BASECOLOR_TEXTCOLOR];
    _descL = [LWLabel lw_lable:@"" font:13 textColor:BASECOLOR_GREYCOLOR155];
    _descL.numberOfLines = 0;
    [self.contentView addSubviews:@[_leftL,_descL]];
    [_leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.width.mas_offset(70);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [_descL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leftL.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-5);
        make.height.mas_greaterThanOrEqualTo(50);
    }];
    
}

@end
