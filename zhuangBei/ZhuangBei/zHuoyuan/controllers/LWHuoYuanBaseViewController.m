//
//  LWHuoYuanBaseViewController.m
//  ZhuangBei
//
//  Created by LWQ on 2020/4/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "LWHuoYuanBaseViewController.h"
#import "LWSearchViewController.h"
#import "LWUpdateVersionView.h"
#import "MessageGroupViewController.h"

@interface LWHuoYuanBaseViewController ()
@property (nonatomic, strong) LWUpdateVersionView *aleartView;

@end

@implementation LWHuoYuanBaseViewController

- (void)clickSearchBtn:(UIButton *)sender
{
    LWSearchViewController *seachvc = [LWSearchViewController new];
    [self.navigationController pushViewController:seachvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UIButton *seachBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [seachBtn setImage:IMAGENAME(@"icon_search") forState:UIControlStateNormal];
    [seachBtn addTarget:self action:@selector(clickSearchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seachBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:seachBtn];
}

- (void)refreshData
{
    self.currPage = 1;
    [self requestDatas];
}

- (void)loadMore
{
    if (self.currPage < self.totalPage) {
        ++ self.currPage;
        [self requestDatas];
    }
}

- (void)requestDatas
{
    
}

- (void)showBaoKuanAleartView:(NSString *)msg {
    
    NSString * content = [NSString stringWithFormat:@"爆款规则：\n%@",msg];
    [LEEAlert alert].config
    .LeeTitle(@"温馨提示")
    .LeeAddContent(^(UILabel * _Nonnull label) {
        label.textAlignment = NSTextAlignmentLeft;
        label.text = content;
    })
    .LeeCancelAction(@"取消", ^{
        // 点击事件Block
    })
    .LeeAction(@"进入群聊", ^{
        // 点击事件Block
        [self.navigationController pushViewController:[MessageGroupViewController chatRoomViewControllerWithRoomId:@"62" roomName:@"爆款" roomType:(LWChatRoomTypeGroup) extend:nil] animated:YES];
        
    })
    .LeeShow();
    
//    WEAKSELF(self);
//    _aleartView = [[LWUpdateVersionView alloc] init];
//    NSString *temMsg = [NSString stringWithFormat:@"爆款规则：\n\n       %@",msg];
//    [_aleartView showAleartViewWithTitle:@"温馨提示" content:temMsg btns:@[@"关闭",@"进群详聊"] callBlock:^(NSString *btnstr) {
//        if ([btnstr isEqualToString:@"关闭"]) {
//            [weakself.aleartView dismiss];
//        }else if ([btnstr isEqualToString:@"进群详聊"]){
//            [weakself.aleartView dismiss];
//            MessageGroupViewController *chatvc = [MessageGroupViewController chatRoomViewControllerWithRoomId:[NSString stringWithFormat:@"%d",62] roomName:@"爆款申请" roomType:(LWChatRoomTypeGroup) extend:nil];
//            [self.navigationController pushViewController:chatvc animated:YES];
//        }
//    }];
}

@end
