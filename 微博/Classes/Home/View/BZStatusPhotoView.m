//
//  BZStatusPhotoView.m
//  微博
//
//  Created by 白斌 on 15/7/23.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZStatusPhotoView.h"
#import "BZPicUrl.h"
#import "UIImageView+WebCache.h"

@interface BZStatusPhotoView ()
@property (nonatomic,weak) UIImageView *gifViw;

@end

@implementation BZStatusPhotoView

- (UIImageView *)gifViw
{
    if (_gifViw == nil) {
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifViw = gifView;
    }
    return _gifViw;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (void)setPicUrl:(BZPicUrl *)picUrl
{
    _picUrl = picUrl;
    [self sd_setImageWithURL:[NSURL URLWithString:picUrl.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.gifViw.hidden = ![picUrl.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifViw.x = self.width - self.gifViw.width;
    self.gifViw.y = self.height - self.gifViw.height;
}

@end
