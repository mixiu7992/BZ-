//
//  BZStatusToolBar.m
//  微博
//
//  Created by 白斌 on 15/7/22.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZStatusToolBar.h"
#import "BZStatus.h"
#define BZStatusBtnCount 3

@interface BZStatusToolBar ()
@property (nonatomic,strong) NSArray *btnArray;
@property (nonatomic,strong) NSArray *deviderArray;
@property (nonatomic,weak) UIButton *retweet;
@property (nonatomic,weak) UIButton *comment;
@property (nonatomic,weak) UIButton *unlike;

@end

@implementation BZStatusToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        UIButton *retweet = [self addBtnWithTitle:@"转发" image:@"timeline_icon_retweet"];
        self.retweet = retweet;
        UIButton *comment = [self addBtnWithTitle:@"评论" image:@"timeline_icon_comment"];
        self.comment = comment;
        UIButton *unlike = [self addBtnWithTitle:@"赞" image:@"timeline_icon_unlike"];
        self.unlike = unlike;
        self.btnArray = @[retweet,comment,unlike];
        UIImageView *devider = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"]];
        devider.contentMode = UIViewContentModeCenter;
        [self addSubview:devider];
        UIImageView *devider1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"]];
        devider1.contentMode = UIViewContentModeCenter;
        [self addSubview:devider1];
        self.deviderArray = @[devider,devider1];
        
    }
    return self;
}

/**  添加按钮  */
- (UIButton *)addBtnWithTitle:(NSString *)title image:(NSString *)image
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:btn];
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat BtnW = screenW / BZStatusBtnCount;
    CGFloat BtnH = self.height;
    for (int i = 0 ; i < self.btnArray.count; i++) {
        UIButton *btn = self.btnArray[i];
        btn.frame = CGRectMake(BtnW * i, 0, BtnW, BtnH);
    }
    for (int i = 0; i < self.deviderArray.count; i++) {
        UIImageView *devider = self.deviderArray[i];
        devider.x = BtnW * (i + 1);
        devider.height = self.height * 0.8;
        devider.y = self.height * 0.1;
    }
}

- (void)setStatus:(BZStatus *)status
{
    _status = status;
    //10001  11020 3001
    [self setBtn:self.retweet Title:@"转发" count:status.reposts_count];
    [self setBtn:self.comment Title:@"评论" count:status.comments_count];
    [self setBtn:self.unlike Title:@"赞" count:status.attitudes_count];
}

- (void)setBtn:(UIButton *)btn Title:(NSString *)title count:(int)count
{
    if (count) {
        if (count > 10000) {
            double wan = count / 10000.0;
            
            title = [NSString stringWithFormat:@"%.1f万",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{
            title = [NSString stringWithFormat:@"%d",count];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
    
}

@end
