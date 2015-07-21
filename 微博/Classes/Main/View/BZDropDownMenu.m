//
//  BZDropDownMenu.m
//  微博
//
//  Created by 白斌 on 15/7/20.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZDropDownMenu.h"

@interface BZDropDownMenu ()
@property (nonatomic,weak) UIImageView *content;

@end

@implementation BZDropDownMenu

- (UIImageView *)content
{
    if (_content == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        [imageView setImage:[UIImage imageNamed:@"popover_background"]];
        imageView.size = imageView.image.size;
        [self addSubview:imageView];
        self.content = imageView;
    }
    return _content;
}

- (void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    contentView.x = 10;
    contentView.y = 15;
    self.content.width = CGRectGetMaxX(contentView.frame) + 10;
    self.content.height = CGRectGetMaxY(contentView.frame) + 10;
    [self.content addSubview:contentView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

+ (instancetype)dropMenu
{
    return [[self alloc] init];
}

- (void)showWith:(UIView *)view
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = window.bounds;
    //这里要转换坐标系
    CGRect newFrame = [view.superview convertRect:view.frame toView:window];
    self.content.centerX = CGRectGetMidX(newFrame);
    self.content.y = CGRectGetMaxY(newFrame);
    
    [window addSubview:self];
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidFinishShow:)]) {
        [self.delegate dropDownMenuDidFinishShow:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

- (void)dismiss
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidFinishDimiss:)]) {
        [self.delegate dropDownMenuDidFinishDimiss:self];
    }
}

@end
