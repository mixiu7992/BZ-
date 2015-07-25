//
//  BZEmotionPageVIew.m
//  微博
//
//  Created by 白斌 on 15/7/25.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZEmotionPageVIew.h"
#import "BZEmotion.h"

@interface BZEmotionPageVIew ()
@property (nonatomic,weak) UIButton *lastBtn;

@end

@implementation BZEmotionPageVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    for (int i = 0; i < emotions.count; i ++) {
        UIButton *btn = [[UIButton alloc] init];
//        btn.backgroundColor = BZRandomColor;
        [btn addTarget:self action:@selector(clickEmotion:) forControlEvents:UIControlEventTouchUpInside];
    
        BZEmotion *emotion = emotions[i];
        if (emotion.png) {
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
            btn.titleLabel.text = emotion.chs;
            btn.titleLabel.hidden = YES;
        }else{
            [btn setTitle:[emotion.code emoji] forState:UIControlStateNormal];
            btn.titleLabel.font  = [UIFont systemFontOfSize:32];
        }
        [self addSubview:btn];
    }
    UIButton *lastBtn = [[UIButton alloc] init];
    [lastBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    [lastBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
    [self addSubview:lastBtn];
    self.lastBtn = lastBtn;
    //这个按钮不用设置尺寸了  下面遍历的时候就可以直接添加进去了
    
}

- (void)clickEmotion:(UIButton *)emotion
{
    if ([self.delegate respondsToSelector:@selector(emotionPageView:DidClickEmotion:)]) {
        [self.delegate emotionPageView:self DidClickEmotion:emotion];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW = (self.width - 2 * padding) / 7;
    CGFloat btnH = (self.height - 2 * padding) / 3;
    for (int i = 0; i < self.subviews.count ; i ++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = padding + (i % 7) * btnW;
        btn.y = padding + (i / 7) * btnH;
     }

}

@end
