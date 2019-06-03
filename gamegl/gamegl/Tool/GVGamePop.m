
#import "GVGamePop.h"
@interface GVGamePop()
@property (strong, nonatomic) UIImageView *splashView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator ;

@end

@implementation GVGamePop

+ (GVGamePop *)sharedSingleton{
    static GVGamePop *sharedSingleton = nil;
    @synchronized(self){
        if (!sharedSingleton) {
            sharedSingleton = [[GVGamePop alloc] init];
            return sharedSingleton;
        }
    }
    return sharedSingleton;
}
-(void)show{
    UIImage*image= [UIImage imageNamed:@"login.jpg"];
    UIView *bgView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    bgView.tag = 100;
    bgView.layer.contents= (id)image.CGImage;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:bgView];
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
    self.activityIndicator.frame= CGRectMake(0, 0, 100, 100);
    self.activityIndicator.center = bgView.center;
    [bgView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];

}

-(void)remove{
    [self.activityIndicator stopAnimating];
    for (UIView*view in [[UIApplication sharedApplication].keyWindow subviews]){
        if (view.tag == 100) {
            [UIView animateWithDuration:1.0 animations:^{
                view.alpha = 0;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
        }
    }
}

@end
