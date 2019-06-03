//
//  GVBossCell.h
//  gamegl
//
//  Created by mac04 on 2019/5/21.
//  Copyright © 2019 game. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonBtn.h"

NS_ASSUME_NONNULL_BEGIN
#define GVBossCell_MemberCell @"GVBossCell"

@interface GVBossCell : UITableViewCell
@property(nonatomic,strong)void (^myblock)(NSInteger index,NSArray*titles);
@property(nonatomic,strong)NSArray*imageA;
@property(nonatomic,strong)NSArray*titleArr;
@end

NS_ASSUME_NONNULL_END
