
#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,RESideMenuDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)RESideMenu *sideMenuViewController;

@end

