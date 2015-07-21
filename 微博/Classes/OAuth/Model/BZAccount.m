//
//  BZAccount.m
//  微博
//
//  Created by 白斌 on 15/7/20.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZAccount.h"

@implementation BZAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    BZAccount *account = [[BZAccount alloc] init];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    account.access_token = dict[@"access_token"];
    return account;
}

- (void)encodeWithCoder:(NSCoder *)enCoder
{
    [enCoder encodeObject:self.uid forKey:@"uid"];
    [enCoder encodeObject:self.access_token forKey:@"access_token"];
    [enCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [enCoder encodeObject:self.creatDate forKey:@"creatDate"];
    [enCoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.creatDate = [decoder decodeObjectForKey:@"creatDate"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
