//
//  BZEmotionToolBar.m
//  微博
//
//  Created by 白斌 on 15/7/24.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZEmotionToolBar.h"
#import "BZEmotionToolBarButton.h"

@interface BZEmotionToolBar ()
@property (nonatomic,strong) BZEmotionToolBarButton *slectedBtn;

@end

@implementation BZEmotionToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.height = 37;
        self.width = screenW;
        
        [self addBtnWithTitle:@"最近" Image:@"compose_emotion_table_left_normal" selectedImage:@"compose_emotion_table_left_selected" buttonType:BZEmotionToolBarButtonTypeRecent];
        [self addBtnWithTitle:@"默认" Image:@"compose_emotion_table_mid_normal" selectedImage:@"compose_emotion_table_mid_selected" buttonType:BZEmotionToolBarButtonTypeDefaule];
        [self addBtnWithTitle:@"Emoji" Image:@"compose_emotion_table_mid_normal" selectedImage:@"compose_emotion_table_mid_selected" buttonType:BZEmotionToolBarButtonTypeEmoji];
        [self addBtnWithTitle:@"浪小花" Image:@"compose_emotion_table_right_normal" selectedImage:@"compose_emotion_table_right_selected" buttonType:BZEmotionToolBarButtonTypeLxh];
    }
    return self;
}

- (void)addBtnWithTitle:(NSString *)title Image:(NSString *)image selectedImage:(NSString *)selectedImage buttonType:(BZEmotionToolBarButtonType)type
{
    BZEmotionToolBarButton *btn = [[BZEmotionToolBarButton alloc] init];
//    btn.titleLabel.text = title;
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    btn.tag = type;
    [btn setTitle:title forState:UIControlStateNormal];
    if (type == BZEmotionToolBarButtonTypeDefaule) {
        btn.selected = YES;
        self.slectedBtn = btn;
        [self clickBtn:btn];
    }
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
}

- (void)setDelegate:(id<BZEmotionToolBarDelegate>)delegate
{
    _delegate = delegate;
    if (delegate) {
        [self clickBtn:self.slectedBtn];
    }
}

- (void)clickBtn:(BZEmotionToolBarButton *)button
{
    self.slectedBtn.selected = NO;
    button.selected = YES;
    self.slectedBtn = button;
    if ([self.delegate respondsToSelector:@selector(emotionToolBar:DidClickButtonType:)]) {
        [self.delegate emotionToolBar:self DidClickButtonType:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW = self.width / 4;
    for (int i = 0; i < self.subviews.count; i ++) {
        BZEmotionToolBarButton *btn = self.subviews[i];
        btn.height = self.height;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.y = 0;
    }
}
@end
