//
//  BZTabBarcontroller.m
//  微博
//
//  Created by 白斌 on 15/7/18.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZTabBarcontroller.h"
#import "BZHomeController.h"
#import "BZNavigationController.h"
#import "BZMessageCenterController.h"
#import "BZDiscoverController.h"
#import "BZProfileController.h"
#import "BZTabBar.h"
#import "BZTestController.h"

@interface BZTabBarcontroller ()<BZTarBarDelegate>

@end

@implementation BZTabBarcontroller

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    
    BZHomeController *home = [[BZHomeController alloc] init];
    [self addchildVCWith:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    BZMessageCenterController *messageCenter = [[BZMessageCenterController alloc] init];
    [self addchildVCWith:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    BZDiscoverController *discover = [[BZDiscoverController alloc] init];
    [self addchildVCWith:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    BZProfileController *profile = [[BZProfileController alloc] init];
    [self addchildVCWith:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
   
   
    BZTabBar *tabBar = [[BZTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    
}

#pragma mark - 代理方法bztabbar
- (void)tarBarDidClickPlusBtn:(BZTabBar *)tabBar
{
    BZTestController *test = [[BZTestController alloc] init];
    [self presentViewController:test animated:YES completion:nil];
}


- (void)addchildVCWith:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
//    childVC.tabBarItem.title = title;
//    childVC.navigationItem.title = title;
    childVC.title = title;
    NSMutableDictionary *titleDict = [NSMutableDictionary dictionary];
    titleDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [childVC.tabBarItem setTitleTextAttributes:titleDict forState:UIControlStateNormal];
    NSMutableDictionary *slectedTitleDict = [NSMutableDictionary dictionary];
    slectedTitleDict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:slectedTitleDict forState:UIControlStateSelected];
    childVC.tabBarItem.image = [UIImage imageNamed:image ];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    BZNavigationController *nav = [[BZNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

@end
