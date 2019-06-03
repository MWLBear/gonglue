
#import <UIKit/UIKit.h>
@interface GVGameTool : NSObject
@property(nonatomic,copy)void(^changeViewSuccess)(BOOL isSucess,NSString*gameulr);
@end
