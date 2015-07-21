//
//  BZDropDownMenu.h
//  微博
//
//  Created by 白斌 on 15/7/20.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BZDropDownMenu;
@protocol BZDropDownMenuDelegate <NSObject>

@optional
- (void)dropDownMenuDidFinishShow:(BZDropDownMenu *)menu;
- (void)dropDownMenuDidFinishDimiss:(BZDropDownMenu *)menu;

@end

@interface BZDropDownMenu : UIView

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,weak) id<BZDropDownMenuDelegate> delegate;

+ (instancetype)dropMenu;

- (void)showWith:(UIView *)view;
- (void)dismiss;

@end
