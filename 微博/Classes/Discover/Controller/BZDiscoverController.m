//
//  BZDiscoverController.m
//  微博
//
//  Created by 白斌 on 15/7/18.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZDiscoverController.h"
#import "BZSearchBar.h"

@implementation BZDiscoverController
- (void)viewDidLoad
{
    [super viewDidLoad];
    BZSearchBar *searchBar = [BZSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
}

@end
