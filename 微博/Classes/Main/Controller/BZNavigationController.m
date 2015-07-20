//
//  BZNavigationController.m
//  微博
//
//  Created by 白斌 on 15/7/18.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZNavigationController.h"

@implementation BZNavigationController

+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    NSMutableDictionary *navBarAttri = [NSMutableDictionary dictionary];
    navBarAttri[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17];
    [navBar setTitleTextAttributes:navBarAttri];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *normal = [NSMutableDictionary dictionary];
    normal[NSForegroundColorAttributeName] = [UIColor orangeColor];
    normal[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:normal forState:UIControlStateNormal];
#warning //以后可能要设置不能用的状态
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highlightImage:@"navigationbar_back_highlighted"];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highlightImage:@"navigationbar_more_highlighted"];
    }
    [super pushViewController:viewController animated:animated];

    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}
@end
