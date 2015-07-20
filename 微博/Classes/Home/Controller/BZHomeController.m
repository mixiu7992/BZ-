//
//  BZHomeController.m
//  微博
//
//  Created by 白斌 on 15/7/18.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZHomeController.h"
#import "UIBarButtonItem+Extention.h"
#import "BZDropDownMenu.h"

@implementation BZHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highlightImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highlightImage:@"navigationbar_pop_highlighted"];
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.backgroundColor = [UIColor lightGrayColor];
    titleBtn.titleLabel.backgroundColor = [UIColor redColor];
    titleBtn.imageView.backgroundColor = [UIColor blueColor];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 50);
    titleBtn.width = 100;
    titleBtn.height = 30;
    [titleBtn addTarget:self action:@selector(dropMenu:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

- (void)dropMenu:(UIButton *)button
{
    button.selected = !button.isSelected;
    BZDropDownMenu *menu = [BZDropDownMenu dropMenu];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake(0, 0, 200, 300);
    menu.contentView = btn;
    [menu showWith:button];
}

- (void)friendSearch
{
    NSLog(@"%s",__func__);
}

- (void)pop
{
    NSLog(@"%s",__func__);

}

@end
