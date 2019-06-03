//
//  GVGLListCell.m
//  gamegl
//
//  Created by mac04 on 2019/5/23.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVGLListCell.h"

@interface GVGLListCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
@implementation GVGLListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)setItem:(gvlistItme *)item{
    _item = item;
    self.title.text = item.title;
    self.time.text = item.time;
}
@end
