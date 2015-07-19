//
//  BZNewFeatureController.m
//  微博
//
//  Created by 白斌 on 15/7/19.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZNewFeatureController.h"

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / 320;
    //四舍五入计算页码
    self.pageControl.currentPage = (int)(page + 0.5);
    
}

@end
