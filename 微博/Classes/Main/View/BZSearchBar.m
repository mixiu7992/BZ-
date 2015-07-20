//
//  BZSearchBar.m
//  微博
//
//  Created by 白斌 on 15/7/19.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZSearchBar.h"

@implementation BZSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.height = 30;
        searchIcon.width = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

@end
