//
//  BZStatus.m
//  微博
//
//  Created by 白斌 on 15/7/21.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZStatus.h"
#import "MJExtension.h"

@implementation BZStatus


+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[BZPicUrl class]};
}



@end
