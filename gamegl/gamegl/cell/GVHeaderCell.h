//
//  GVCommonCell.h
//  gamegl
//
//  Created by mac04 on 2019/5/21.
//  Copyright © 2019 game. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define GVHeaderCell_MemberCell @"GVHeaderCell"
@interface GVHeaderCell : UITableViewCell
@property(nonatomic,strong)NSArray*imageArry;
@property(nonatomic,strong)void (^myblock)(NSInteger index);
+(CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
