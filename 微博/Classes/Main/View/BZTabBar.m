//
//  BZTabBar.m
//  微博
//
//  Created by 白斌 on 15/7/19.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZTabBar.h"

@interface BZTabBar ()
@property (nonatomic,weak) UIButton *plusBtn;

@end

@implementation BZTabBar
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(clickPlusBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
        
        
    }
    return self;
}

- (void)clickPlusBtn
{
    if ([self.delegate respondsToSelector:@selector(tarBarDidClickPlusBtn:)]) {
        [self.delegate tarBarDidClickPlusBtn:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    int count = 5;
    int index = 0;
    CGFloat averageW = self.width / count;
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[class class]]) {
            view.x = averageW * index;
            index++;
            if (index == 2) {
                index++;
            }
        }
    }
}

@end
