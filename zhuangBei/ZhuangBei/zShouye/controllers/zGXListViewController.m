//
//  zGXListViewController.m
//  ZhuangBei
//
//  Created by 王明辉 on 2020/10/28.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zGXListViewController.h"
#import "BAKit_WebView.h"
#import "zInviteController.h"
#import "zGXDetailViewController.h"

#define  khtmlUrl @"http://test.110zhuangbei.com:8105/app/modules/app/appusermeritoriouscoin/appusermeritoriouscoinAppList.html"

@interface zGXListViewController ()<WKNavigationDelegate,WKUIDelegate>

@property(nonatomic, strong) WKWebView *webView;

@property(nonatomic, strong) WKWebViewConfiguration *webConfig;

@end

@implementation zGXListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

- (WKWebView *)webView
{
    if (!_webView)
    {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT) configuration:self.webConfig];
        //  添加 WKWebView 的代理，注意：用此方法添加代理
        
        [_webView.scrollView setShowsVerticalScrollIndicator:NO];
        _webView.scrollView.contentScaleFactor = NO;
        [self.webView ba_web_initWithDelegate:self.webView uIDelegate:self.webView];
        _webView.ba_web_isAutoHeight = NO;
//        self.webView.multipleTouchEnabled = YES;
        self.webView.autoresizesSubviews = YES;
        
        
        self.webView.ba_web_isLoadingBlock = ^(BOOL isLoading, CGFloat progress) {
            NSLog(@"加载中%f",progress);
        };
        self.webView.ba_web_didFailBlock = ^(WKWebView * _Nonnull webView, WKNavigation * _Nonnull navigation) {
            NSLog(@"加载失败");
        };
        self.webView.ba_web_didStartBlock = ^(WKWebView * _Nullable webView, WKNavigation * _Nonnull navigation) {
            NSLog(@"加载开始");
        };
    }
    return _webView;
}

- (WKWebViewConfiguration *)webConfig
{
    if (!_webConfig) {
        
        // 创建并配置WKWebView的相关参数
        // 1.WKWebViewConfiguration:是WKWebView初始化时的配置类，里面存放着初始化WK的一系列属性；
        // 2.WKUserContentController:为JS提供了一个发送消息的通道并且可以向页面注入JS的类，WKUserContentController对象可以添加多个scriptMessageHandler；
        // 3.addScriptMessageHandler:name:有两个参数，第一个参数是userContentController的代理对象，第二个参数是JS里发送postMessage的对象。添加一个脚本消息的处理器,同时需要在JS中添加，window.webkit.messageHandlers.<name>.postMessage(<messageBody>)才能起作用。
        
        _webConfig = [[WKWebViewConfiguration alloc] init];
        _webConfig.allowsInlineMediaPlayback = YES;
        
//        _webConfig.allowsPictureInPictureMediaPlayback = YES;
        
        // 通过 JS 与 webView 内容交互
        // 注入 JS 对象名称 senderModel，当 JS 通过 senderModel 来调用时，我们可以在WKScriptMessageHandler 代理中接收到
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        NSString *cookieValue = @"document.cookie = 'fromapp=ios';document.cookie = 'channel=appstore';";
        WKUserScript * cookieScript = [[WKUserScript alloc]
                                           initWithSource: cookieValue
                                           injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [userContentController addUserScript:cookieScript];
        //        [userContentController addScriptMessageHandler:self name:@"BAShare"];
        _webConfig.userContentController = userContentController;
        
        // 初始化偏好设置属性：preferences
        _webConfig.preferences = [WKPreferences new];
        // The minimum font size in points default is 0;
//        _webConfig.preferences.minimumFontSize = 40;
        // 是否支持 JavaScript
        _webConfig.preferences.javaScriptEnabled = YES;
        // 不通过用户交互，是否可以打开窗口
        _webConfig.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
    }
    return _webConfig;
}

- (NSMutableString*)getCookieValue{
    // 在此处获取返回的cookie
    
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
    NSMutableString *cookieValue = [NSMutableString stringWithFormat:@""];
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
//    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:url]];
    
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsCookie];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
//            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
            [cookieDic setObject:cookie.value forKey:cookie.name];
        }
    }
    // cookie重复，先放到字典进行去重，再进行拼接
    for (NSString *key in cookieDic) {
        NSString *appendString = [NSString stringWithFormat:@"%@=%@;", key, [cookieDic valueForKey:key]];
        [cookieValue appendString:appendString];
    }
    [cookieValue appendString:@"path=/app;httponly"];
    return cookieValue;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"功勋币";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
    [self.view addSubview:self.webView];
    [self setHtmlStr:khtmlUrl];
    [self ba_JS_OC];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    self.webView.frame = CGRectMake(20,1,self.view.bounds.size.width-40,self.view.bounds.size.height-1);
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

-(void)setHtmlStr:(NSString *)htmlStr
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:htmlStr]];
        [request setValue:[self getCookieValue] forHTTPHeaderField:@"Cookie"];
    [self.webView loadRequest:request];
}

- (void)ba_JS_OC
{
    // 1、先注册ID
    NSArray *messageNameArray = @[@"iOSShare", @"iOSGXDetail"];
    [self.webView ba_web_addScriptMessageHandlerWithNameArray:messageNameArray];
    
    // 2、JS 调用 OC 时 webview 会调用此 block
    BAKit_WeakSelf
    self.webView.ba_web_userContentControllerDidReceiveScriptMessageBlock = ^(WKUserContentController * _Nonnull userContentController, WKScriptMessage * _Nonnull message) {
        BAKit_StrongSelf
        if ([message.name isEqualToString:messageNameArray[0]])
        {
//            NSString *msg = @"生命不息，折腾不止...来自 OC Alert！";
//            BAKit_ShowAlertWithMsg_ios8(msg);
            zInviteController *vc = [zInviteController new];
            vc.title  = @"邀请好友";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([message.name isEqualToString:messageNameArray[1]])
        {
            zGXDetailViewController *vc = [zGXDetailViewController new];
            vc.title = @"功勋币收支记录";
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
}


-(void)RequsetFileWithUrl:(NSString*)url WithError:(NSError*)err
{
    if ([url containsString:khtmlUrl]) {
        [[zHud shareInstance]showMessage:@"获取验协议失败"];
        return;
    }
}

-(void)RequsetSuccessWithData:(id)data AndUrl:(NSString*)url
{
    if ([url containsString:khtmlUrl]) {
        NSDictionary * dic = data;
        NSString * msg = dic[@"msg"];
        NSString * code = dic[@"code"];
        if ([code integerValue] == 0) {
            NSString * htmlContent = dic[@"appAgreement"][@"agreementContent"];
            [self.webView loadHTMLString:htmlContent baseURL:nil];
        }else
        {
            [[zHud shareInstance]showMessage:msg];
        }
        
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //禁止用户选择
    NSString *fontFamilyStr = @"document.getElementsByTagName('body')[0].style.fontFamily='Arial';";
    [webView evaluateJavaScript:fontFamilyStr completionHandler:nil];
}

- (void)webView:(WKWebView*)webView decidePolicyForNavigationResponse:(WKNavigationResponse*)navigationResponse decisionHandler:(void(^)(WKNavigationResponsePolicy))decisionHandler{

   
    decisionHandler(WKNavigationResponsePolicyAllow);
}

@end
