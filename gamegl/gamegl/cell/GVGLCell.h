//
//  GVGLCell.h
//  gamegl
//
//  Created by mac04 on 2019/5/21.
//  Copyright © 2019 game. All rights reserved.
//

#import <UIKit/UIKit.h>
#define GVGLCell_MemberCell @"GVGLCell"

NS_ASSUME_NONNULL_BEGIN

@interface GVGLCell : UITableViewCell
@property(nonatomic,strong)void (^myblock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
