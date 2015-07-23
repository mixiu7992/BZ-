//
//  BZIconView.m
//  微博
//
//  Created by 白斌 on 15/7/23.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZIconView.h"
#import "UIImageView+WebCache.h"
#import "BZUser.h"

@interface BZIconView ()
@property (nonatomic,weak) UIImageView *verifiedView;

@end
@implementation BZIconView

- (UIImageView *)verifiedView
{
    if (_verifiedView == nil) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setUser:(BZUser *)user
{
    _user = user;
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    switch (user.verified_type) {
        case BZUserVerifiedPersonal:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case BZUserVerifiedDaren:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        case BZUserVerifiedOrgEnterprice:
        case BZUserVerifiedOrgMedia:
        case BZUserVerifiedOrgWebsite:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        default:
            self.verifiedView.hidden = YES;
            break;
    }
    

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.verifiedView.size = self.verifiedView.image.size;
    self.verifiedView.x = self.width - self.verifiedView.width * 0.7;
    self.verifiedView.y = self.height - self.verifiedView.height * 0.7;
    
}

@end
