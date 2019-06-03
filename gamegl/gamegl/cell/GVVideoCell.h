//
//  GVVideoCell.h
//  gamegl
//
//  Created by mac04 on 2019/5/21.
//  Copyright © 2019 game. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define GVVideoCell_MemberCell @"GVVideoCell"

@interface GVVideoCell : UITableViewCell
@property(nonatomic,strong)void (^myblock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
