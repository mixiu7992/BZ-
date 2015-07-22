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
@implementation BZStatusPhotoView
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
}

@end
