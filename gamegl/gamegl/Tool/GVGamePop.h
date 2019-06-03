
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GVGamePop : NSObject
+(GVGamePop *)sharedSingleton;
-(void)show;
-(void)remove;
@end
NS_ASSUME_NONNULL_END
