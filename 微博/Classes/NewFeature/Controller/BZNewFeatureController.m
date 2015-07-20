//
//  BZNewFeatureController.m
//  微博
//
//  Created by 白斌 on 15/7/19.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZNewFeatureController.h"
#import "BZTabBarcontroller.h"

@interface BZNewFeatureController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation BZNewFeatureController
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    for (int i = 0 ; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.frame = self.view.bounds;
        imageView.x = scrollView.width * i;
        [scrollView addSubview:imageView];
        if (i == 3) {
            [self setupLastImageView:imageView];
        }
    }
    scrollView.contentSize = CGSizeMake(scrollView.width * 4, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    //添加页面控制器
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.numberOfPages = 4;
//    pageControl.width = 100;
//    pageControl.height = 100;
    pageControl.center = CGPointMake(scrollView.width * 0.5, 500);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    [share setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [share setTitle:@"分享给大家" forState:UIControlStateNormal];
    [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    share.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    share.width = 200;
    share.height = 30;
    share.centerX = self.view.centerX;
    share.y = self.view.height * 0.6;
    [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:share];
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [start setTitle:@"开始微博" forState:UIControlStateNormal];
    start.size = start.currentBackgroundImage.size;
    start.centerX = self.view.centerX;
    start.y = self.view.height * 0.7;
    [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:start];
}

- (void)share:(UIButton *)button
{
    button.selected = !button.isSelected;
}

- (void)start
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[BZTabBarcontroller alloc] init];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / 320;
    //四舍五入计算页码
    self.pageControl.currentPage = (int)(page + 0.5);
    
}

@end
