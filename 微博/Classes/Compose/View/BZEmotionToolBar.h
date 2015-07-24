//
//  BZEmotionToolBar.h
//  微博
//
//  Created by 白斌 on 15/7/24.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    BZEmotionToolBarButtonTypeRecent,
    BZEmotionToolBarButtonTypeDefaule,
    BZEmotionToolBarButtonTypeEmoji,
    BZEmotionToolBarButtonTypeLxh
    
}BZEmotionToolBarButtonType;
@class BZEmotionToolBar;
@protocol BZEmotionToolBarDelegate <NSObject>

@optional

- (void)emotionToolBar:(BZEmotionToolBar *)toolBar DidClickButtonType:(BZEmotionToolBarButtonType)type;

@end

@interface BZEmotionToolBar : UIView

@property (nonatomic,weak) id<BZEmotionToolBarDelegate> delegate;
@end
