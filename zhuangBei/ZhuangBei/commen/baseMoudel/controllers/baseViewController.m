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
#import "ServiceManager.h"

@interface baseViewController ()

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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
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
    self.currPage = 1;
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
- (void)getDataurl:(NSString *)url withParam:(id)para
{
    
    [zNetWorkManger GETworkWithUrl:url WithParamer:para Success:^(id  _Nonnull responseObject) {
        NSString *  text  = [self jsonToString:responseObject];
        NSLog(@"请求到的数据是：%@",text);
        [self RequsetSuccessWithData:responseObject AndUrl:url];
    } Failure:^(NSError * _Nonnull error) {
        [self RequsetFileWithUrl:url WithError:error];
    }];
}

-(void)postDataWithUrl:(NSString*)url WithParam:(id)param
{
    NSLog(@"当前请求的URL:%@\n参数:%@",url,param);
    
    //    [ServiceManager requestPostWithUrl:url Parameters:param success:^(id  _Nonnull response) {
    //        NSString *  text  = [self jsonToString:response];
    //        [self RequsetSuccessWithData:response AndUrl:url];
    //        NSLog(@"请求到的数据是：%@",text);
    //    } failure:^(NSError * _Nonnull error) {
    //        [self RequsetFileWithUrl:url WithError:error];
    //    }];
    
    [zNetWorkManger POSTworkWithUrl:url WithParamer:param Success:^(id  _Nonnull responseObject) {
        NSString *  text  = [self jsonToString:responseObject];
        [self RequsetSuccessWithData:responseObject AndUrl:url];
        NSLog(@"请求到的数据是：%@",text);
    } Failure:^(NSError * _Nonnull error) {
        [self RequsetFileWithUrl:url WithError:error];
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

-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
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
                [[zHud shareInstance]showMessage:@"当前网络未连接"];
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


- (void)requestPostWithUrl:(NSString *)url Parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailure)failure;
{
    [ServiceManager requestPostWithUrl:url Parameters:parameters success:^(id  _Nonnull response) {
        if (self.noContentView.alpha == 1) {
            self.noContentView.alpha = 0;
            [self.view sendSubviewToBack:self.noContentView];
        }
        success(response);
    } failure:^(NSError * _Nonnull error) {
        [self.view bringSubviewToFront:self.noContentView];
        self.noContentView.alpha = 1;
        failure(error);
    }];
}


/// POST  网络请求 内部拼接参数
/// @param url 地址
/// @param paraString 参数字典，内部转拼接参数
/// @param success 成功
/// @param failure 失败
- (void)requestPostWithUrl:(NSString *)url paraString:(id)paraString success:(RequestSuccess)success failure:(RequestFailure)failure;
{
    [ServiceManager requestPostWithUrl:url paraString:paraString success:^(id  _Nonnull response) {
        if (self.noContentView.alpha == 1) {
            self.noContentView.alpha = 0;
            [self.view sendSubviewToBack:self.noContentView];
        }
        success(response);
    } failure:^(NSError * _Nonnull error) {
        [self.view bringSubviewToFront:self.noContentView];
        self.noContentView.alpha = 1;
        failure(error);
    }];
}

- (void)requestDatas
{
// 子类重写
}
@end
