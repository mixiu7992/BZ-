//
//  BZTabBar.h
//  微博
//
//  Created by 白斌 on 15/7/19.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BZTabBar;
@protocol BZTarBarDelegate <UITabBarDelegate>

@optional
- (void)tarBarDidClickPlusBtn:(BZTabBar *)tabBar;

@end

@interface BZTabBar : UITabBar

@property (nonatomic,weak) id<BZTarBarDelegate> delegate;

@end
