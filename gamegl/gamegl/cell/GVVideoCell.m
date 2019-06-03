//
//  GVVideoCell.m
//  gamegl
//
//  Created by mac04 on 2019/5/21.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVVideoCell.h"

@interface GVVideoCell()
@property (weak, nonatomic) IBOutlet UIButton *video1;
@property (weak, nonatomic) IBOutlet UIButton *video2;

@end

@implementation GVVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)video:(id)sender {
    if (self.myblock) {
        self.myblock(0);
    }
}
- (IBAction)video1:(id)sender {
    if (self.myblock) {
        self.myblock(1);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
