//
//  BZComposeTextView.m
//  微博
//
//  Created by 白斌 on 15/7/24.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZComposeTextView.h"

@interface BZComposeTextView ()
@property (nonatomic,weak) UILabel *placeholderLabel;

@end

@implementation BZComposeTextView

- (UILabel *)placeholderLabel
{
    if (_placeholderLabel == nil) {
        UILabel *lable = [[UILabel alloc] init];
        lable.text = self.placeholder;
        lable.font = self.font;
        lable.textColor = BZColor(220, 220, 220);
        [self addSubview:lable];
        self.placeholderLabel = lable;
        
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:17];
        [BZNotificationCenter addObserver:self selector:@selector(textChange ) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    [BZNotificationCenter removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.width = self.width;
    self.placeholderLabel.height = 30;
    self.placeholderLabel.x = 5;
    self.placeholderLabel.y = 3;
}

- (void)textChange
{
    self.placeholderLabel.hidden = self.hasText;
}

@end
