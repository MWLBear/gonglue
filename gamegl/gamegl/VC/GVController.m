#import <AdSupport/ASIdentifierManager.h>
#import "GVController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
//#import "UnzipTool.h"
//#import "GVGamePop.h"
#import "GVGameTool.h"


@interface GVController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UIScrollViewDelegate>
@property(nonatomic,strong)WKWebView*webView;
@property(nonatomic,strong)UIImageView*imageView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator ;

@end

@implementation GVController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    [[GVGameTool alloc]init].changeViewSuccess = ^(BOOL isSucess, NSString *gameulr) {
        dispatch_async(dispatch_get_main_queue(), ^{
             [self setupView:[NSURL URLWithString:gameulr]];
        });
    };
    [self addImage];
}

-(void)setupView:(NSURL*)url{
    NSLog(@"setupView");
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.preferences = [WKPreferences new];
    configuration.preferences.javaScriptEnabled = YES;
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    WKUserContentController *controller = [[WKUserContentController alloc] init];
    [controller addScriptMessageHandler:self name:@"openurl"];
    configuration.userContentController = controller;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    if(@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.webView.allowsBackForwardNavigationGestures = YES;
    
    if (url) {
        NSLog(@"123456789");
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }else{
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:%@", [userDefaults objectForKey:@"webPort"]]];
        NSLog(@"%@",[NSString stringWithFormat:@"http://localhost:%@", [userDefaults objectForKey:@"webPort"]]);
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"44"];
//        NSURL *fileURL = [NSURL fileURLWithPath:path];
//        [self.webView loadFileURL: fileURL allowingReadAccessToURL:fileURL];
    }
    [self.view addSubview:self.webView];
    self.webView.scrollView.bounces = NO;
    self.webView.allowsBackForwardNavigationGestures = NO;

    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.scrollView.delegate = self;
}
-(void)addImage{
    
    self.imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.image = [UIImage imageNamed:@"login.jpg"];
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.frame= CGRectMake(0, 0, 150, 150);
    self.activityIndicator.center = self.imageView.center;
    [self.imageView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.imageView];
}

-(void)removeImage{
    [self.activityIndicator stopAnimating];
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.imageView removeFromSuperview];
        self.imageView =nil;
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"openurl"]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:message.body]];
    }
}

#pragma mark = WKNavigationDelegate
//在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    
    NSLog(@"URL = %@",navigationAction.request.URL.absoluteString);
    
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
        && ![hostname containsString:@".baidu.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self removeImage];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    [self removeImage];
}
#pragma mark WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"调用alert提示框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"alert message:%@",message);
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认框" message:@"调用confirm提示框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"confirm message:%@", message);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入框" message:@"调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor blackColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
@end
