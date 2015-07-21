//
//  UIWindow+Extension.m
//  微博
//
//  Created by 白斌 on 15/7/20.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "BZNewFeatureController.h"
#import "BZTabBarcontroller.h"

@implementation UIWindow (Extension)

- (void)changeRootViewController
{
    NSString *currentVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleVersion"];
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
    NSString *newVersion = dict[@"CFBundleVersion"];
    if ([currentVersion isEqualToString:newVersion]) {
        self.rootViewController = [[BZTabBarcontroller alloc] init];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:newVersion forKey:@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.rootViewController = [[BZNewFeatureController alloc] init];
    }
}

@end
