

#import "GameShow.h"
#import "GameWebVC.h"

@implementation GameShow
+(void)show{
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[GameWebVC alloc]init] animated:NO completion:nil];
}
@end
