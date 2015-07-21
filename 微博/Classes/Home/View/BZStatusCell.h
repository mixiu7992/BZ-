//
//  BZStatusCell.h
//  微博
//
//  Created by 白斌 on 15/7/21.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BZStatusFrame;

@interface BZStatusCell : UITableViewCell

@property (nonatomic,strong) BZStatusFrame *statusFrame;

+ (instancetype)statusCellWithTableView:(UITableView *)tableView;

@end
