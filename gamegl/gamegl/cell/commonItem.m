//
//  commonItem.m
//  gamegl
//
//  Created by mac04 on 2019/5/22.
//  Copyright © 2019 game. All rights reserved.
//

#import "commonItem.h"

@implementation commonItem

-(instancetype)initWith:(NSString *)title andImage:(UIImage *)image{
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
    }
    return self;
}
@end


