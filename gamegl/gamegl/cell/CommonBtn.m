//
//  CommonBtn.m
//  gamegl
//
//  Created by mac04 on 2019/5/21.
//  Copyright © 2019 game. All rights reserved.
//

#import "CommonBtn.h"
#import "Masonry.h"

@interface CommonBtn ()
@property(nonatomic,strong)UIImageView*imageViews;
@property(nonatomic,strong)UILabel *titleL;
@end
@implementation CommonBtn
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addsubview];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self addsubview];
    }
    return self;
}

-(void)addsubview{
    self.imageViews = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.titleL = [[UILabel alloc]initWithFrame:CGRectZero];
    self.titleL.font = [UIFont boldSystemFontOfSize:16];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.imageViews];
    [self addSubview:self.titleL];
    
    [self.imageViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.top.mas_equalTo(self.mas_top);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.titleL.mas_top).mas_offset(-5);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
   
    
}
-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageViews.image = image;

}
-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleL.text = self.title;
}
@end
