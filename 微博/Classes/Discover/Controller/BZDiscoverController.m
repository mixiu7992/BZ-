//
//  BZDiscoverController.m
//  微博
//
//  Created by 白斌 on 15/7/18.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZDiscoverController.h"

@implementation BZDiscoverController
- (void)viewDidLoad
{
    [super viewDidLoad];
    UITextField *searchBar = [[UITextField alloc] init];
    searchBar.background = [UIImage imageNamed:@"searchbar_textfield_background"];
    searchBar.width = 300;
    searchBar.height = 30;
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    searchIcon.height = 30;
    searchIcon.width = 30;
    searchIcon.contentMode = UIViewContentModeCenter;
    searchBar.leftView = searchIcon;
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    self.navigationItem.titleView = searchBar;
}

@end
