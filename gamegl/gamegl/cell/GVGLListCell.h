//
//  GVGLListCell.h
//  gamegl
//
//  Created by mac04 on 2019/5/23.
//  Copyright © 2019 game. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gvlistItme.h"

NS_ASSUME_NONNULL_BEGIN
#define GVGLListCell_MemberCell @"GVGLListCell"

@interface GVGLListCell : UITableViewCell
@property(nonatomic,strong)gvlistItme*item;
@end

NS_ASSUME_NONNULL_END
