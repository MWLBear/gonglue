
#import "UnzipTool.h"
#import "SSZipArchive.h"
@implementation UnzipTool
+ (NSString*)unzipPressed{
    NSString*zip = [[NSBundle mainBundle]pathForResource:@"game.zip" ofType:nil];
    if (!zip)return @"0";
    NSString*unzippath = [UnzipTool tempUnzipPath];
    if (!unzippath) return @"0";
    BOOL sucess ;
    sucess = [SSZipArchive unzipFileAtPath:zip toDestination:unzippath overwrite:YES password:@"123456abc" error:nil];
    if (sucess) {
        NSString*fulltxtname = [NSString stringWithFormat:@"%@/%@",unzippath,@"game.txt"];
        NSData*data = [NSData dataWithContentsOfFile:fulltxtname];
        NSString*basetime = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSString*time15day = [UnzipTool base64DecodedString:basetime];
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
        NSInteger nowtime = timeInterval;
        
        if (time15day.integerValue > nowtime) {
            return @"0";
        }else{
            return @"abcdefeeee";
        }
    }else{
        return @"0";
    }
}

+ (NSString *)base64DecodedString:(NSString*)str
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:str options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
}

+(NSString*)tempUnzipPath {
    
    NSString*path = [NSString stringWithFormat:@"%@/%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0],[NSUUID UUID].UUIDString];
    NSURL*url = [NSURL fileURLWithPath:path];
    NSError*error = nil;
    [[NSFileManager defaultManager]createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) return nil;
    return url.path;
}
@end
