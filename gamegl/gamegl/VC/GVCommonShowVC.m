//
//  GVCommonShowVC.m
//  gamegl
//
//  Created by mac04 on 2019/5/22.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVCommonShowVC.h"
#import "Masonry.h"
#import <WebKit/WebKit.h>
#define ImageViewWH 300
@interface GVCommonShowVC ()
@property(nonatomic,strong)WKWebView*web;
@property(nonatomic,strong)UIImageView*imageView;
@end

@implementation GVCommonShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.ishowImageView = YES;
    self.title = self.titles;
    [self setupView];
   
}
-(void)setupView{
    self.web = [[WKWebView alloc]init];
    self.web.scrollView.showsVerticalScrollIndicator = NO;
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.web];
    [self.view addSubview:self.imageView];
    if (self.ishowImageView) {
         [self.view addSubview:self.imageView];
    }
    if (self.imageArr.count >1 ) {
        self.imageView.animationImages = self.imageArr;
        self.imageView.animationRepeatCount = 0;
        self.imageView.animationDuration = 1.0;
        [self.imageView startAnimating];
    }else{
        self.imageView.image = self.imageArr[0];
    }
    
    
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
    if (self.html) {
          [self.web loadHTMLString:[headerString stringByAppendingString:self.html] baseURL:nil];
    }
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.ishowImageView) {
            make.left.mas_equalTo(self.view).offset(20);
            make.right.mas_equalTo(self.view).offset(-20);

            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.equalTo(self.view).mas_offset(64);
        }else{
            make.size.mas_equalTo(CGSizeMake(ImageViewWH, ImageViewWH));
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.equalTo(self.view).mas_offset(64);
        }
        
    }];
    
  
    [self.web mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (self.ishowImageView) {
            make.left.bottom.mas_equalTo(self.view).mas_offset(15);
            make.right.mas_equalTo(self.view).mas_offset(-15);
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(10);
//        }else{
//            make.edges.equalTo(self.view).mas_offset(0);
//        }
      
    }];
}
@end
