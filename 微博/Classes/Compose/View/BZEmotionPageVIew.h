//
//  BZEmotionPageVIew.h
//  微博
//
//  Created by 白斌 on 15/7/25.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BZEmotionPageVIew;
@protocol BZEmotionPageViewDelegate <NSObject>

@optional

- (void)emotionPageView:(BZEmotionPageVIew *)pageView DidClickEmotion:(UIButton *)emotion;

@end

@interface BZEmotionPageVIew : UIView

@property (nonatomic,weak) id<BZEmotionPageViewDelegate> delegate;

@property (nonatomic,strong) NSArray *emotions;

@end
