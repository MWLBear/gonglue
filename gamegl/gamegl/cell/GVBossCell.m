//
//  GVBossCell.m
//  gamegl
//
//  Created by mac04 on 2019/5/21.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVBossCell.h"

@interface GVBossCell()
@property (weak, nonatomic) IBOutlet CommonBtn *boss1;
@property (weak, nonatomic) IBOutlet CommonBtn *boss2;
@property (weak, nonatomic) IBOutlet CommonBtn *boss3;
@property (weak, nonatomic) IBOutlet CommonBtn *boss4;
@property (weak, nonatomic) IBOutlet CommonBtn *boss5;
@property (weak, nonatomic) IBOutlet CommonBtn *boss6;



@end
@implementation GVBossCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}
-(NSArray*)imageA{
    if (!_imageA) {
        _imageA = @[
                    [UIImage imageNamed:@"boss_1.png"],
                    [UIImage imageNamed:@"boss_2.png"],
                    [UIImage imageNamed:@"boss_3.png"],
                    [UIImage imageNamed:@"boss_4.png"],
                    [UIImage imageNamed:@"boss_5.png"],
                    [UIImage imageNamed:@"boss_6.png"],
                    ];
    }
    return _imageA;
}
-(NSArray*)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"祖玛教主",@"双头血魔",@"双头金刚",@"尸王",@"魔龙教主",@"半兽勇士"];
    }
    return _titleArr;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.boss1.title = self.titleArr[0];
    self.boss2.title = self.titleArr[1];
    self.boss3.title = self.titleArr[2];
    self.boss4.title = self.titleArr[3];
    self.boss5.title = self.titleArr[4];
    self.boss6.title = self.titleArr[5];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.boss1.image = self.imageA[0];
        self.boss2.image = self.imageA[1];
        self.boss3.image = self.imageA[2];
        self.boss4.image = self.imageA[3];
        self.boss5.image = self.imageA[4];
        self.boss6.image = self.imageA[5];

    });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)boss1c:(id)sender {
    [self send:0];
}
- (IBAction)boss2c:(id)sender {
    [self send:1];
}
- (IBAction)boss3c:(id)sender {
    [self send:2];
}
- (IBAction)boss4c:(id)sender {
    [self send:3];
}
- (IBAction)boss5c:(id)sender {
    [self send:4];
}
- (IBAction)boss6c:(id)sender {
    [self send:5];
}
-(void)send:(NSInteger)index{
    if (self.myblock) {
        self.myblock(index,self.titleArr);
    }
}

@end
