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

//Thu Jul 23 01:22:20 +0800 2015
// 设置日期格式（声明字符串里面每个数字和单词的含义）
// E:星期几
// M:月份
// d:几号(这个月的第几天)
// H:24小时制的小时
// m:分钟
// s:秒
// y:年
- (NSString *)created_at
{
//    NSLog(@"%@",_created_at);
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    [fmt setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *creatDate = [fmt dateFromString:_created_at];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents * cpts = [calendar components:unit  fromDate:creatDate toDate:now options:0];
    if ([creatDate isThisYear]) {//今年
        if ([calendar isDateInToday:creatDate]) {//今天
            if (cpts.hour > 0) {
                return [NSString stringWithFormat:@"%ld小时前",(long)cpts.hour];
            }else if (cpts.minute > 0){
                return [NSString stringWithFormat:@"%ld分钟前",(long)cpts.minute];
            }else{
                return @"刚刚";
            }
            
        }else{//非今天
            if ([calendar isDateInYesterday:creatDate]) {//昨天
                fmt.dateFormat = @"HH:mm";
                return [NSString stringWithFormat:@"昨天 %@",[fmt stringFromDate:creatDate]];
            }
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:creatDate];
        }
    }else{//非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:creatDate];
    }
}

//<a href="http://app.weibo.com/t/feed/3j6BDx" rel="nofollow">孔明社交管理</a>
- (void)setSource:(NSString *)source
{
    NSRange startRange = [source rangeOfString:@">"];
    NSRange endRange = [source rangeOfString:@"<" options:NSBackwardsSearch];
    NSRange range = {startRange.location + 1,endRange.location - startRange.location - 1};
    _source = [NSString stringWithFormat:@"来自于%@",[source substringWithRange:range]];
}



@end
