//
//  BZComposeToolBar.m
//  微博
//
//  Created by 白斌 on 15/7/24.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZComposeToolBar.h"

@implementation BZComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self addBtnWithImage:@"compose_camerabutton_background" highlighted:@"compose_camerabutton_background_highlighted" buttonType:BZComposeToolBarButtonTypeCarema];
        [self addBtnWithImage:@"compose_toolbar_picture" highlighted:@"compose_toolbar_picture_highlighted" buttonType:BZComposeToolBarButtonTypePhoto];
        [self addBtnWithImage:@"compose_mentionbutton_background" highlighted:@"compose_mentionbutton_background_highlighted" buttonType:BZComposeToolBarButtonTypeMention];
        [self addBtnWithImage:@"compose_trendbutton_background" highlighted:@"compose_trendbutton_background_highlighted" buttonType:BZComposeToolBarButtonTypeTrend];
        [self addBtnWithImage:@"compose_emoticonbutton_background" highlighted:@"compose_emoticonbutton_background_highlighted" buttonType:BZComposeToolBarButtonTypeEmotion];
    }
    return self;
}

- (void)addBtnWithImage:(NSString *)image highlighted:(NSString *)highlightedImage buttonType:(BZComposeToolBarButtonType)buttonType
{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = buttonType;
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(clinkButoon:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)clinkButoon:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(toolBar:DidClinkButtonType:)]) {
        [self.delegate toolBar:self DidClinkButtonType:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW = self.width / self.subviews.count;
    for (int i = 0; i < self.subviews.count; i ++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = self.height;
    }
}
@end
