//
//  GVGLCell.m
//  gamegl
//
//  Created by mac04 on 2019/5/21.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVGLCell.h"
#import "CommonBtn.h"

@interface GVGLCell()
@property (weak, nonatomic) IBOutlet CommonBtn *gl1;
@property (weak, nonatomic) IBOutlet CommonBtn *gl2;
@property (weak, nonatomic) IBOutlet CommonBtn *gl3;
@property (weak, nonatomic) IBOutlet CommonBtn *gl4;
@property(nonatomic,strong)NSArray*imageA;
@property(nonatomic,strong)NSArray*titleArr;
@end
@implementation GVGLCell

-(NSArray*)imageA{
    if (!_imageA) {
        _imageA = @[
                    [UIImage imageNamed:@"攻略-最新.png"],
                    [UIImage imageNamed:@"攻略-热门.png"],
                    [UIImage imageNamed:@"攻略-官方.png"],
                    [UIImage imageNamed:@"攻略-大神.png"],
                    ];
    }
    return _imageA;
}
-(NSArray*)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"最新攻略",@"热门攻略",@"官方攻略",@"大神攻略"];
    }
    return _titleArr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)layoutSubviews{
    [super layoutSubviews];
  
    self.gl1.title = self.titleArr[0];
    self.gl2.title = self.titleArr[1];
    self.gl3.title = self.titleArr[2];
    self.gl4.title = self.titleArr[3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.gl1.image = self.imageA[0];
        self.gl2.image = self.imageA[1];
        self.gl3.image = self.imageA[2];
        self.gl4.image = self.imageA[3];
    });
 
}

- (IBAction)gl1:(id)sender {
    if (self.myblock) {
        self.myblock(0);
    }
}
- (IBAction)gl2:(id)sender {
    if (self.myblock) {
        self.myblock(1);
    }
}
- (IBAction)gl3:(id)sender {
    if (self.myblock) {
        self.myblock(2);
    }
}
- (IBAction)gl4:(id)sender {
    if (self.myblock) {
        self.myblock(3);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
