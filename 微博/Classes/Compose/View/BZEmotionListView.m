//
//  BZEmotionListView.m
//  微博
//
//  Created by 白斌 on 15/7/24.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZEmotionListView.h"
#import "BZEmotionPageVIew.h"

#define BZMaxIconsOfPage 20

@interface BZEmotionListView ()
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation BZEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    NSUInteger pageCount = (emotions.count + BZMaxIconsOfPage -1) / BZMaxIconsOfPage;
    
    for (int i = 0; i < pageCount; i ++) {
        BZEmotionPageVIew *pageView = [[BZEmotionPageVIew alloc] init];
//        pageView.backgroundColor = BZRandomColor;
        NSRange range;
        range.location = i * BZMaxIconsOfPage;
        if ((emotions.count - i * BZMaxIconsOfPage) > BZMaxIconsOfPage) {
            range.length = BZMaxIconsOfPage;
        }else{
            range.length = emotions.count - i * BZMaxIconsOfPage;
        }
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    self.scrollView.contentSize = CGSizeMake(screenW * pageCount, 0);
//    NSLog(@"%@",[self.scrollView.subviews[1] backgroundColor]);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.pageControl.height = 30;
    
    self.scrollView.height = self.height - self.pageControl.height;
    self.scrollView.width = screenW;
    self.scrollView.x = self.scrollView.y = 0;
    for (int i = 0 ; i < self.scrollView.subviews.count; i ++) {
        BZEmotionPageVIew *pageView = self.scrollView.subviews[i];
        pageView.width = screenW;
        pageView.height = self.height - self.pageControl.height;
        pageView.y = 0;
        pageView.x = screenW * i;
    }
}

@end
