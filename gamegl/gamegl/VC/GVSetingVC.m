//
//  GVSetingVC.m
//  gamegl
//
//  Created by mac04 on 2019/5/20.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVSetingVC.h"
#import "GVAboutVC.h"
#import "GVNavigationVC.h"

@interface GVSetingVC ()
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@end

@implementation GVSetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.cacheLabel.text = [NSString stringWithFormat:@"%.2f M",[self folderSize]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage: [self reSizeImage:[UIImage imageNamed:@"home.png"] toSize:CGSizeMake(20,20 )] landscapeImagePhone: [self reSizeImage:[UIImage imageNamed:@"home.png"] toSize:CGSizeMake(20,20 )] style:UIBarButtonItemStyleDone target:self action:@selector(presentLeftMenuViewController:)];
}
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [reSizeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}
#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        NSLog(@"清除缓存");
        
        [self removeCache];
        self.cacheLabel.text = @"0.0 M";

    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            GVAboutVC* AboutVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AboutVC"];
            [self.navigationController pushViewController:AboutVC animated:YES];
        }else if (indexPath.row == 1){
            NSLog(@"意见建议与反馈");
        }
    }
}

// 缓存大小
- (CGFloat)folderSize{
    CGFloat folderSize = 0.0;
    
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",files.count);
    
    for(NSString *path in files) {
        
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    
    return sizeM;
}

- (void)removeCache{
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",[files count]);
    for(NSString *p in files){
        NSError*error;
        
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            if(isRemove) {
                NSLog(@"清除成功");
            }else{
                
                NSLog(@"清除失败");
                
            }
        }
    }
}
@end
