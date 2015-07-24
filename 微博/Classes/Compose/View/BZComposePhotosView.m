//
//  BZComposePhotosView.m
//  微博
//
//  Created by 白斌 on 15/7/24.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZComposePhotosView.h"

@implementation BZComposePhotosView

- (void)saveImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageWH = 70;
    for (int i = 0; i < self.subviews.count; i ++) {
        int col = i % 3;
        int row = i / 3;
        UIImageView *imageView = self.subviews[i];
        imageView.x = padding + col * (imageWH + padding);
        imageView.y = padding + row * (imageWH + padding);
        imageView.height = imageWH;
        imageView.width = imageWH;
    }
}

@end
