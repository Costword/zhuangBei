//
//  zPlayerViewController.m
//  ZhuangBei
//
//  Created by aa on 2020/7/29.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zPlayerViewController.h"
#import "CLPlayerView.h"


@interface zPlayerViewController ()

/**CLplayer*/
@property (nonatomic,weak) CLPlayerView *playerView;

@end

@implementation zPlayerViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"pushViewController";
    
    CLPlayerView *playerView = [[CLPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    
    _playerView = playerView;
    [self.view addSubview:_playerView];
   
    [_playerView updateWithConfigure:^(CLPlayerViewConfigure *configure) {
        //后台返回是否继续播放
        configure.backPlay = NO;
        //转子颜色
        configure.strokeColor = [UIColor redColor];
        //工具条消失时间，默认10s
        configure.toolBarDisappearTime = 8;
        //顶部工具条隐藏样式，默认不隐藏
        configure.topToolBarHiddenType = TopToolBarHiddenAlways;
        configure.videoFillMode = VideoFillModeResizeAspect;
    }];
    
    //视频地址
    _playerView.url = [NSURL fileURLWithPath:self.url];
    //播放
    [_playerView playVideo];
    //返回按钮点击事件回调,小屏状态才会调用，全屏默认变为小屏
    [_playerView backButton:^(UIButton *button) {
        NSLog(@"返回按钮被点击");
    }];
    //播放完成回调
    [_playerView endPlay:^{
        NSLog(@"播放完成");
    }];
    
}
- (void)next{
    _playerView.url = [NSURL URLWithString:@"http://120.24.184.1/cdm/media/k2/videos/1.mp4"];
    [_playerView playVideo];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_playerView destroyPlayer];
}
// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return NO;
}
// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
@end
