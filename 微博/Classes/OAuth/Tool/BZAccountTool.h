//
//  BZAccountTool.h
//  微博
//
//  Created by 白斌 on 15/7/20.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZAccount.h"

@interface BZAccountTool : NSObject
+ (void)saveAccount:(BZAccount *)account;
+ (BZAccount *)account;
@end
