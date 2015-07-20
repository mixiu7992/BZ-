//
//  BZDropDownMenu.h
//  微博
//
//  Created by 白斌 on 15/7/20.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BZDropDownMenu : UIView

@property (nonatomic,strong) UIView *contentView;

+ (instancetype)dropMenu;

- (void)showWith:(UIView *)view;
- (void)dismiss;

@end
