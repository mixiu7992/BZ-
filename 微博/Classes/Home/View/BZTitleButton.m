//
//  BZTitleButton.m
//  微博
//
//  Created by 白斌 on 15/7/20.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZTitleButton.h"

@implementation BZTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
#warning 没有下面这两句8.3中文字刚启动位置会变 setFrame 后也可以解决
//        self.titleLabel.backgroundColor = [UIColor clearColor];
//        self.imageView.backgroundColor = [UIColor clearColor];
//        
        

    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    frame.size.width += 10;
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.x = self.imageView.x;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 10;
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
