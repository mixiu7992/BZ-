//
//  BZProfileController.m
//  微博
//
//  Created by 白斌 on 15/7/18.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZProfileController.h"

@implementation BZProfileController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
}

- (void)setting
{
    BZLog(@"%s",__func__);
}

@end
