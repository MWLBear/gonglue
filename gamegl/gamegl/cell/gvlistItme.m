//
//  gvlistItme.m
//  gamegl
//
//  Created by mac04 on 2019/5/23.
//  Copyright © 2019 game. All rights reserved.
//

#import "gvlistItme.h"

@implementation gvlistItme
-(instancetype)initWith:(NSString*)title andTime:(NSString*)time andURL:(nonnull NSString *)url{
    
    if (self = [super init]) {
        self.title = title;
        self.time = time;
        self.url = url;
    }
    return self;
}
@end
