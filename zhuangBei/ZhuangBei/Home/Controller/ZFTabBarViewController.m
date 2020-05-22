//
//  ZFTabBarViewController.m
//  ZFTabBar
//
//  Created by 任子丰 on 15/9/10.
//  Copyright (c) 2014年 任子丰. All rights reserved.
//

#import "ZFTabBarViewController.h"
#import "ZFTabBar.h"
#import "MainNavController.h"
#import "zAshouyeController.h"
#import "zHyController.h"
#import "zJiaoliuController.h"
#import "zWodeController.h"

#import "LWClientHeader.h"

@interface ZFTabBarViewController () <ZFTabBarDelegate>
/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) ZFTabBar *customTabBar;
@end

@implementation ZFTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"white_bg"];
    // 初始化tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
    //    未读聊天消息数量变化
    ADD_NOTI(unreadMsgNumberChange, LOCAL_UNREAD_MSG_LIST_CHANGE_NOTI_KEY);
    
}

- (void)unreadMsgNumberChange
{
    zJiaoliuController *vc = (zJiaoliuController *)(self.childViewControllers[2].childViewControllers.lastObject);
    NSInteger num = [LWClientManager share].unreadMsgNum;
    vc.navigationController.tabBarItem.badgeValue = (num == 0) ? nil: [NSString stringWithFormat:@"%ld",num];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    ZFTabBar *customTabBar = [[ZFTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(ZFTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    if (self.selectedIndex == to && to == 0 ) {//双击刷新制定页面的列表
        //        UINavigationController *nav = self.viewControllers[0];
        //        FirstViewController *firstVC = nav.viewControllers[0];
        //        [firstVC refrshUI];
    }
    self.selectedIndex = to;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    //首页
    
    zAshouyeController *syVC = [[zAshouyeController alloc]init];
    //        syVC.tabBarItem.badgeValue = @"N";
    [self setupChildViewController:syVC title:@"首页" imageName:@"home_nor" selectedImageName:@"home_sel"];
    
    
    //货源
    zHyController *hyVC = [[zHyController alloc]init];
    //    hyVC.tabBarItem.badgeValue = @"8";
    [self setupChildViewController:hyVC title:@"货源" imageName:@"goods_nor" selectedImageName:@"goods_sel"];
    //交流
    zJiaoliuController*jlVC = [[zJiaoliuController alloc]init];
    NSInteger num = [LWClientManager share].unreadMsgNum;
    jlVC.tabBarItem.badgeValue =  num == 0 ? nil: [NSString stringWithFormat:@"%ld",num];
    
    [self setupChildViewController:jlVC title:@"交流大厅" imageName:@"friend_nor" selectedImageName:@"friend_sel"];
    
    //我的
    zWodeController*wdVC = [[zWodeController alloc]init];
    //    wdVC.tabBarItem.badgeValue = @"128";
    [self setupChildViewController:wdVC title:@"我的" imageName:@"personal_nor" selectedImageName:@"personal_sel"];
    
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2.包装一个导航控制器
    MainNavController *nav = [[MainNavController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

@end
