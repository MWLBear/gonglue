//
//  GVCommonCell.h
//  gamegl
//
//  Created by mac04 on 2019/5/21.
//  Copyright © 2019 game. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commonItem.h"

NS_ASSUME_NONNULL_BEGIN
#define GVCommonCell_MemberCell @"GVCommonCell"

@interface GVCommonCell : UITableViewCell
@property(nonatomic,strong)NSArray*itemA;
@property(nonatomic,strong)void (^myblock)(NSInteger index);

+(CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
