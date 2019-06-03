//
//  gvlistItme.h
//  gamegl
//
//  Created by mac04 on 2019/5/23.
//  Copyright © 2019 game. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface gvlistItme : NSObject
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*time;
@property(nonatomic,strong)NSString*url;
-(instancetype)initWith:(NSString*)title andTime:(NSString*)time andURL:(NSString*)url;
@end

NS_ASSUME_NONNULL_END
