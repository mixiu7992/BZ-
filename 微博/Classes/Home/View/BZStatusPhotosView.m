//
//  BZStatusPhotosView.m
//  微博
//
//  Created by 白斌 on 15/7/23.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZStatusPhotosView.h"
#import "BZStatusPhotoView.h"
@implementation BZStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    long long count = photos.count;
    while (self.subviews.count < count) {
        BZStatusPhotoView *photoView = [[BZStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    for (int i = 0 ; i < self.subviews.count; i ++) {
        BZStatusPhotoView *photoView = self.subviews[i];
        if (i < photos.count) {
            photoView.hidden = NO;
            photoView.picUrl = photos[i];
        }else{
            photoView.hidden = YES;
        }
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.subviews.count; i ++) {
        int col = i % 3;
        int row = i / 3;
        BZStatusPhotoView *photoView = self.subviews[i];
        photoView.width = BZStatusPhotoWH;
        photoView.height = BZStatusPhotoWH;
        photoView.x = (BZStatusPhotoWH + padding) * col;
        photoView.y = (BZStatusPhotoWH + padding) * row;
    }
    
}

+ (CGSize)sizeWithCount:(int)count
{
    
    int cols = count < 3? count : 3;
    int rows = (count + 3 - 1) / 3;
    CGFloat width = BZStatusPhotoWH * cols + (cols - 1) *padding;
    CGFloat height = BZStatusPhotoWH *rows + (rows - 1) *padding;
    return CGSizeMake(width, height);
}

@end
