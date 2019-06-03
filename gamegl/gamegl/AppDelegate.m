
#import "AppDelegate.h"
#import "GVController.h"
#import "GVLeftMenuVC.h"
#import "GVRightVC.h"
#import "HTTPServer.h"
#import "GVMainVC.h"
#import "GVNavigationVC.h"
#import "GVController.h"
#import "UnzipTool.h"
#define webPath [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"44"]

@interface AppDelegate ()
@property(strong,nonatomic)NSString*port;
@property(nonatomic,strong)HTTPServer *localHttpServer;
@end

@implementation AppDelegate

-(RESideMenu*)sideMenuViewController{
    if (!_sideMenuViewController) {
        GVLeftMenuVC *leftVC = [[GVLeftMenuVC alloc]init];
        GVMainVC *mianVC = [[GVMainVC alloc]init];
        _sideMenuViewController = [[RESideMenu alloc]initWithContentViewController:[[GVNavigationVC alloc]initWithRootViewController:mianVC] leftMenuViewController:leftVC rightMenuViewController:nil];
        
        _sideMenuViewController.backgroundImage = [UIImage imageNamed:@"login.jpg"];
        _sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
        _sideMenuViewController.delegate = self;
        _sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
        _sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
        _sideMenuViewController.contentViewShadowOpacity = 0.5;
        _sideMenuViewController.contentViewShadowRadius = 12;
        _sideMenuViewController.contentViewShadowEnabled = YES;
    }
    return _sideMenuViewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self setupLocalHttpServer];
    self.window.rootViewController = [[GVController alloc]init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)setupLocalHttpServer{
    self.localHttpServer = [[HTTPServer alloc]init];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSLog(@"%@",webPath);
    
    
    if (![fileManager fileExistsAtPath:webPath]){
        
        NSLog(@"File path error!");
    }else{
        NSString *webLocalPath = webPath;
        [_localHttpServer setDocumentRoot:webLocalPath];
        NSLog(@"webLocalPath:%@",webLocalPath);
        [self startServer];
    }
}

- (void)startServer
{
    NSError *error;
    if([_localHttpServer start:&error]){
        NSLog(@"Started HTTP Server on port %hu", [_localHttpServer listeningPort]);
        self.port = [NSString stringWithFormat:@"%d",[_localHttpServer listeningPort]];
        //保存端口号，在调用的时候使用
        NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
        [accountDefaults setObject:self.port forKey:@"webPort"];
        [accountDefaults synchronize];
    }
    else{
        NSLog(@"Error starting HTTP Server: %@", error);
    }
}


- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
