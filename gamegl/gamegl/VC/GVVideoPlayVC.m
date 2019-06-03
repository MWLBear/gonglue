//
//  GVVideoPlayVC.m
//  gamegl
//
//  Created by mac04 on 2019/5/23.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVVideoPlayVC.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface GVVideoPlayVC ()
@property(nonatomic,strong)AVPlayerViewController*vc;
@end

@implementation GVVideoPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"精品视频";
    NSString *pathurl = [[NSBundle mainBundle] pathForResource:self.path ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:pathurl];
    
    self.vc = [[AVPlayerViewController alloc] init];
    self.vc.player = [[AVPlayer alloc] initWithURL:url];
    self.vc.view.frame = self.view.bounds;
    [self.view addSubview:self.vc.view];
    
    [self.vc.player play];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.vc.player pause];
}
@end
