//
//  BZEmotionKeyboard.m
//  微博
//
//  Created by 白斌 on 15/7/24.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZEmotionKeyboard.h"
#import "BZEmotionListView.h"
#import "BZEmotionToolBar.h"
#import "BZEmotion.h"
#import "MJExtension.h"

@interface BZEmotionKeyboard ()<BZEmotionToolBarDelegate>

@property (nonatomic,weak) BZEmotionToolBar *toolBar;
@property (nonatomic,strong) BZEmotionListView *recentListView;
@property (nonatomic,strong) BZEmotionListView *defaultListView;
@property (nonatomic,strong) BZEmotionListView *emojiListView;
@property (nonatomic,strong) BZEmotionListView *lxhListView;

@property (nonatomic,strong) BZEmotionListView *listView;
@end

@implementation BZEmotionKeyboard

- (BZEmotionToolBar *)toolBar
{
    if (_toolBar == nil) {
        BZEmotionToolBar *toolBar = [[BZEmotionToolBar alloc] init];
        toolBar.delegate = self;
        [self addSubview:toolBar];
        self.toolBar = toolBar;
    }
    return _toolBar;
}

- (BZEmotionListView *)recentListView
{
    if (_recentListView == nil) {
        BZEmotionListView *listView = [[BZEmotionListView alloc] init];
//        listView.backgroundColor = BZRandomColor;
        self.recentListView = listView;
    }
    return _recentListView;
}

- (BZEmotionListView *)defaultListView
{
    if (_defaultListView == nil) {
        BZEmotionListView *listView = [[BZEmotionListView alloc] init];
//        listView.backgroundColor = BZRandomColor;
        NSArray *emotions = [NSArray arrayWithContentsOfFile:[[NSBundle  mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil]];
        listView.emotions = [BZEmotion objectArrayWithKeyValuesArray:emotions];
        self.defaultListView = listView;
    }
    return _defaultListView;
}

- (BZEmotionListView *)emojiListView
{
    if (_emojiListView == nil) {
        BZEmotionListView *listView = [[BZEmotionListView alloc] init];
//        listView.backgroundColor = BZRandomColor;
        NSArray *emotions = [NSArray arrayWithContentsOfFile:[[NSBundle  mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil]];
        listView.emotions = [BZEmotion objectArrayWithKeyValuesArray:emotions];
        self.emojiListView = listView;
    }
    return _emojiListView;
}
- (BZEmotionListView *)lxhListView
{
    if (_lxhListView == nil) {
        BZEmotionListView *listView = [[BZEmotionListView alloc] init];
//        listView.backgroundColor = BZRandomColor;
        NSArray *emotions = [NSArray arrayWithContentsOfFile:[[NSBundle  mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil]];
        listView.emotions = [BZEmotion objectArrayWithKeyValuesArray:emotions];
        self.lxhListView = listView;
    }
    return _lxhListView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}




- (void)layoutSubviews
{
    [super layoutSubviews];
    self.toolBar.x = 0;
    self.toolBar.y = self.height - self.toolBar.height;
    self.listView.height = self.toolBar.y;
    self.listView.x = 0;
    self.listView.width = self.width;
    self.listView.y = 0;
}

#pragma mark - toolbar的代理方法
- (void)emotionToolBar:(BZEmotionToolBar *)toolBar DidClickButtonType:(BZEmotionToolBarButtonType)type
{
    [self.listView removeFromSuperview];
    switch (type) {
        case BZEmotionToolBarButtonTypeRecent:{
            self.listView = self.recentListView;
            break;}
        case BZEmotionToolBarButtonTypeDefaule:{
            self.listView = self.defaultListView;
            break;}
        case BZEmotionToolBarButtonTypeEmoji:{
            self.listView = self.emojiListView;
            break;}
        case BZEmotionToolBarButtonTypeLxh:{
            self.listView = self.lxhListView;
            break;}
    }
    [self addSubview:self.listView];
}

@end
