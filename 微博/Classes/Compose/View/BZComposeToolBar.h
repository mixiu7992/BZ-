//
//  BZComposeToolBar.h
//  微博
//
//  Created by 白斌 on 15/7/24.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BZComposeToolBarButtonTypeCarema,
    BZComposeToolBarButtonTypePhoto,
    BZComposeToolBarButtonTypeMention,
    BZComposeToolBarButtonTypeTrend,
    BZComposeToolBarButtonTypeEmotion
} BZComposeToolBarButtonType;
@class BZComposeToolBar;
@protocol BZComposeToolBarDelegate <NSObject>

@optional

- (void)toolBar:(BZComposeToolBar *)toolBar DidClinkButtonType:(BZComposeToolBarButtonType)buttonType;

@end

@interface BZComposeToolBar : UIView

@property (nonatomic,weak) id<BZComposeToolBarDelegate> delegate;

@end
