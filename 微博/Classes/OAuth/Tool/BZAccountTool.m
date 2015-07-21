//
//  BZAccountTool.m
//  微博
//
//  Created by 白斌 on 15/7/20.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#define BZAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archiver"]

#import "BZAccountTool.h"

@implementation BZAccountTool

+ (void)saveAccount:(BZAccount *)account
{
    
    [NSKeyedArchiver archiveRootObject:account toFile:BZAccountPath];
}

+ (BZAccount *)account
{
    BZAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:BZAccountPath];
    NSDate *now = [NSDate date];
    NSDate *OutOfDate = [account.creatDate dateByAddingTimeInterval:account.expires_in.longLongValue];
    NSComparisonResult result = [now compare:OutOfDate];
    //NSOrderedAscending 升序= -1L, NSOrderedSame, NSOrderedDescending降序
    if (result == NSOrderedDescending) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithFile:BZAccountPath];
}

@end
