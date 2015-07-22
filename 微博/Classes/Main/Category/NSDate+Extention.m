//
//  NSDate+Extention.m
//  微博
//
//  Created by 白斌 on 15/7/23.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "NSDate+Extention.h"

@implementation NSDate (Extention)

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowcps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return cps.year == nowcps.year;
}

@end
