
#import "GVNavigationVC.h"

@interface GVNavigationVC ()<UIGestureRecognizerDelegate>

@end

@implementation GVNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
    [self setupNavigationBar];
}

- (void)setupNavigationBar
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setBarTintColor:[UIColor getColor:@"fb9c0a"]];
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttribute[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [appearance setTitleTextAttributes:textAttribute];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
        [backButton setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateHighlighted];
        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [backButton addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)popView
{
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
