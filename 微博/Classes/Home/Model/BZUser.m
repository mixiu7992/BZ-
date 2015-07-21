//
//  BZUser.m
//  微博
//
//  Created by 白斌 on 15/7/21.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZUser.h"

@implementation BZUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    if (mbtype > 2) {
        self.vip = YES;
    }
}

@end
