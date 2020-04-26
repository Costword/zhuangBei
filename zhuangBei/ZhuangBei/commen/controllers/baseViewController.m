//
//  baseViewController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/22.
//  Copyright © 2020 aa. All rights reserved.
//

#import "baseViewController.h"
#import "PPNetworkHelper.h"
#import "AFNetworking.h"
#import "zNoContentView.h"
#import "zNothingView.h"


@interface baseViewController ()

@property(strong,nonatomic)zNoContentView * noContentView;

@property(strong,nonatomic)zNothingView * nothingView;

@end

@implementation baseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem * leftBarButtonItem =   [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"return_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(actionBackClick)];
    self.navigationItem.leftBarButtonItem =leftBarButtonItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
//    NSLog(@"%@",self.navigationController.childViewControllers);
    if (self.navigationController.childViewControllers.count==1) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    self.view.backgroundColor = UIColor.whiteColor;
    
}

-(zNoContentView*)noContentView
{
    if (!_noContentView) {
        _noContentView = [[zNoContentView alloc]init];
        _noContentView.alpha = 0;
    }
    return _noContentView;
}

-(zNothingView*)nothingView
{
    if (!_nothingView) {
        _nothingView = [[zNothingView alloc]init];
        _nothingView.alpha = 0;
    }
    return _nothingView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.nothingView];
    [self.view addSubview:self.noContentView];
    [self monitorNetworkStatus];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
    
    [self.nothingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.noContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


-(void)actionBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - 获取数据请求示例 GET请求自动缓存与无缓存
#pragma  mark - 这里的请求只是一个演示, 在真实的项目中建议不要这样做, 具体做法可以参照PPHTTPRequestLayer文件夹的例子
- (void)getData:(BOOL)isOn url:(NSString *)url withParam:(NSDictionary*)para
{
    
//    NSDictionary *para = @{ @"a":@"list", @"c":@"data",@"client":@"iphone",@"page":@"0",@"per":@"10", @"type":@"29"};
    // 自动缓存
    if(isOn)
    {
        //有缓存的情况
        [PPNetworkHelper GET:url parameters:para responseCache:^(id responseCache) {
            // 1.先加载缓存数据
            NSString *  text = [self jsonToString:responseCache];
            NSLog(@"缓存数据是：%@",text);
            [self RequsetSuccessWithData:responseCache AndUrl:url];
        } success:^(id responseObject) {
            // 2.再请求网络数据
            NSString *  text  = [self jsonToString:responseObject];
            NSLog(@"请求到的数据是：%@",text);
            [self RequsetSuccessWithData:responseObject AndUrl:url];
        } failure:^(NSError *error) {
            [self RequsetFileWithUrl:url];
        }];
        
    }
    // 无缓存
    else
    {
        [PPNetworkHelper GET:url parameters:para success:^(id responseObject) {
           NSString *  text  = [self jsonToString:responseObject];
           NSLog(@"无缓存请求到的数据是：%@",text);
            [self RequsetSuccessWithData:responseObject AndUrl:url];
        } failure:^(NSError *error) {
            [self RequsetFileWithUrl:url];
        }];
    }
}

-(void)postDataWithUrl:(NSString*)url WithParam:(NSDictionary*)param
{
    [PPNetworkHelper POST:url parameters:param success:^(id responseObject) {
        NSString *  text  = [self jsonToString:responseObject];
        NSLog(@"请求到的数据是：%@",text);
        [self RequsetSuccessWithData:responseObject AndUrl:url];
    } failure:^(NSError *error) {
        [self RequsetFileWithUrl:url];
    }];
}


/**
 *  json转字符串
 */
- (NSString *)jsonToString:(NSDictionary *)dic
{
    if(!dic){
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(void)RequsetFileWithUrl:(NSString*)url
{
    
}

-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    
}

#pragma mark - 实时监测网络状态
- (void)monitorNetworkStatus
{
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
        
        switch (networkStatus) {
                // 未知网络
            case PPNetworkStatusUnknown:
                // 无网络
            case PPNetworkStatusNotReachable:
                NSLog(@"无网络,加载缓存数据");
                break;
                // 手机网络
            case PPNetworkStatusReachableViaWWAN:
                // 无线网络
            case PPNetworkStatusReachableViaWiFi:
                NSLog(@"有网络,请求网络数据");
                break;
        }
    }];
}



@end
