//
//  BZStatusPhotosView.h
//  微博
//
//  Created by 白斌 on 15/7/23.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BZStatusPhotosView : UIView

@property (nonatomic,strong) NSArray *photos;
+ (CGSize)sizeWithCount:(int)count;
@end
