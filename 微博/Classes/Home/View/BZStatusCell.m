//
//  BZStatusCell.m
//  微博
//
//  Created by 白斌 on 15/7/21.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import "BZStatusCell.h"
#import "BZStatusFrame.h"
#import "UIImageView+WebCache.h"
@interface BZStatusCell ()

/**  原创微博  */

@property (nonatomic,weak) UIView *orginalView;


/**  头像  */
@property (nonatomic,weak) UIImageView *iconView;
/**  昵称  */
@property (nonatomic,weak) UILabel *nameLabel;
/**  vip  */
@property (nonatomic,weak) UIImageView *vipView;
/**  时间  */
@property (nonatomic,weak) UILabel *timeLable;
/**  来自  */
@property (nonatomic,weak) UILabel *fromLable;
/**  内容  */
@property (nonatomic,weak) UILabel *contentLable;
/**  配图  */
@property (nonatomic,weak) UIImageView *photoView;

@end

@implementation BZStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /**  原创微博  */
        UIView *orginalView = [[UIView alloc] init];
        [self.contentView addSubview:orginalView];
        self.orginalView = orginalView;
        /**  头像  */
        UIImageView *iconView = [[UIImageView alloc] init];
        [orginalView addSubview:iconView];
        self.iconView = iconView;
        /**  昵称  */
        UILabel *nameLabel = [[UILabel alloc] init];
        [orginalView addSubview:nameLabel];
        nameLabel.numberOfLines = 0;
        nameLabel.font = BZCellNameFont;
        self.nameLabel = nameLabel;
        /**  vip  */
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [orginalView addSubview:vipView];
        self.vipView = vipView;
        /**  时间  */
        UILabel *timeLable = [[UILabel alloc] init];
        timeLable.font = BZCellTimeFont;
        [orginalView addSubview:timeLable];
        self.timeLable = timeLable;
        /**  来自  */
        UILabel *fromLable = [[UILabel alloc] init];
        fromLable.font = BZCellFormFont;
        [orginalView addSubview:fromLable];
        self.fromLable = fromLable;
        /**  内容  */
        UILabel *contentLable = [[UILabel alloc] init];
        contentLable.numberOfLines = 0;
        contentLable.font = BZCellContentFont;
        [orginalView addSubview:contentLable];
        self.contentLable = contentLable;
        /**  配图  */
        UIImageView *photoView = [[UIImageView alloc] init];
        [orginalView addSubview:photoView];
        self.photoView = photoView;
    }
    return self;
}

+ (instancetype)statusCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    BZStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BZStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void)setStatusFrame:(BZStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    BZStatus *status = statusFrame.status;
    BZUser *user = status.user;
    self.orginalView.frame = statusFrame.orginalViewF;
    
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    if (user.isVip) {
        self.vipView.hidden = NO;
        NSString *vipImageName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipImageName];
        self.vipView.frame = statusFrame.vipViewF;
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    self.timeLable.frame = statusFrame.timeLableF;
    self.timeLable.text = status.created_at;
    
    self.fromLable.frame = statusFrame.fromLableF;
    self.fromLable.text = status.source;
    
    self.contentLable.frame = statusFrame.contentLableF;
    self.contentLable.text = status.text;
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        self.photoView.frame = statusFrame.photoViewF;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"album"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    }else{
        self.photoView.hidden = YES;
    }
}


@end
