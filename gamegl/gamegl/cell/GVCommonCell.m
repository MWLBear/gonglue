//
//  GVCommonCell.m
//  gamegl
//
//  Created by mac04 on 2019/5/21.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVCommonCell.h"
#import "CommonBtn.h"

@interface GVCommonCell()
@property (weak, nonatomic) IBOutlet CommonBtn *btn1;
@property (weak, nonatomic) IBOutlet CommonBtn *btn2;
@property (weak, nonatomic) IBOutlet CommonBtn *btn3;

@end
@implementation GVCommonCell
- (IBAction)btn1:(id)sender {
    if (self.myblock) {
        self.myblock(0);
    }
}
- (IBAction)btn2:(id)sender {
    if (self.myblock) {
        self.myblock(1);
    }
}
- (IBAction)btn3:(id)sender {
    if (self.myblock) {
        self.myblock(2);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    
 
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
+(CGFloat)cellHeight{
    return 180;
}
-(void)setItemA:(NSArray *)itemA{
    
    _itemA = itemA;
    self.btn1.title = ((commonItem*)self.itemA[0]).title;
    self.btn2.title = ((commonItem*)self.itemA[1]).title;
    self.btn3.title = ((commonItem*)self.itemA[2]).title;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.btn1.image = ((commonItem*)self.itemA[0]).image;
        self.btn2.image = ((commonItem*)self.itemA[1]).image;
        self.btn3.image = ((commonItem*)self.itemA[2]).image;
        
    });
}
@end
