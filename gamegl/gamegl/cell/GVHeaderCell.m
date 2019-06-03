//
//  GVCommonCell.m
//  gamegl
//
//  Created by mac04 on 2019/5/21.
//  Copyright © 2019 game. All rights reserved.
//

#import "GVHeaderCell.h"
#import "SDCycleScrollView.h"
#define GVHeaderCellHeight 180
@interface GVHeaderCell()<SDCycleScrollViewDelegate>

@end
@implementation GVHeaderCell{
    SDCycleScrollView *_customCellScrollViewDemo;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setimageView];
    }
    return self;
}
-(void)setimageView{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    _customCellScrollViewDemo = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, w, GVHeaderCellHeight) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _customCellScrollViewDemo.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _customCellScrollViewDemo.currentPageDotColor = [UIColor whiteColor];
    [self addSubview:_customCellScrollViewDemo];
}

-(void)setImageArry:(NSArray *)imageArry{
    _imageArry = imageArry;
     _customCellScrollViewDemo.imageURLStringsGroup = imageArry;
}
+ (CGFloat)cellHeight{
    return GVHeaderCellHeight;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.myblock) {
        self.myblock(index);
    }
}

@end
