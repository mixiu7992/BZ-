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
#import "BZStatusToolBar.h"
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

/**  转发微博retweeted_status  */
@property (nonatomic,weak) UIView *retweetView;
/**  内容加昵称  */
@property (nonatomic,weak) UILabel *retweetContentLable;
/**  转发微博配图  */
@property (nonatomic,weak) UIImageView *retweetPhotoView;
/**  工具条  */
@property (nonatomic,weak) BZStatusToolBar *toolBar;
@end

@implementation BZStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        /**  原创微博  */
        [self setupOrginal];
        /**  转发微博  */
        [self setupRetweet];
        
        [self setupToolBar];
    }
    return self;
}

- (void)setupToolBar
{
    BZStatusToolBar *toolBar = [[BZStatusToolBar alloc] init];
//    toolBar.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
}

- (void)setupRetweet
{
    /**  转发微博retweeted_status  */
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = [UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    /**  内容加昵称  */
    UILabel *retweetContentLable = [[UILabel alloc] init];
    retweetContentLable.font = BZCellContentFont;
    retweetContentLable.numberOfLines = 0;
    [retweetView addSubview:retweetContentLable];
    self.retweetContentLable = retweetContentLable;
    /**  转发微博配图  */
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
    

}

- (void)setupOrginal
{
    UIView *orginalView = [[UIView alloc] init];
    orginalView.backgroundColor = [UIColor whiteColor];
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
    timeLable.textColor = [UIColor orangeColor];
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
    BZStatus *retweet = statusFrame.status.retweeted_status;
    BZUser *retweedUser = retweet.user;
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
    
    /**  时间  */
    //由于往回拖的时候有时候时间的长度会变化
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + padding;
    NSMutableDictionary *timeAttrs = [NSMutableDictionary dictionary];
    timeAttrs[NSFontAttributeName] = BZCellTimeFont;
    CGSize timeSize = [status.created_at sizeWithAttributes:timeAttrs];
    CGRect timeLableF = {{timeX,timeY},timeSize};
    
    self.timeLable.frame = timeLableF;
    self.timeLable.text = status.created_at;
    /**  来自  */
    CGFloat fromX = CGRectGetMaxX(timeLableF) + padding;
    CGFloat fromY = timeY;
    NSMutableDictionary *fromAttrs = [NSMutableDictionary dictionary];
    fromAttrs[NSFontAttributeName] = BZCellFormFont;
    CGSize fromSize = [status.source sizeWithAttributes:fromAttrs];
    CGRect fromLableF = {{fromX,fromY},fromSize};
    
    self.fromLable.frame = fromLableF;
    self.fromLable.text = status.source;
    
    self.contentLable.frame = statusFrame.contentLableF;
    self.contentLable.text = status.text;
    if (status.pic_urls.count) {
        self.photoView.hidden = NO;
        self.photoView.frame = statusFrame.photoViewF;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:[status.pic_urls[0] thumbnail_pic]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    }else{
        self.photoView.hidden = YES;
    }
    
    //转发微博
    if (retweet) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        self.retweetContentLable.frame =statusFrame.retweetContentLableF;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@:%@",retweedUser.name,retweet.text];
        self.retweetContentLable.text = retweetContent;
        if (retweet.pic_urls) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = statusFrame.retweePhotoF;
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:[[retweet.pic_urls firstObject] thumbnail_pic]]  placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
        }else{
            self.retweetPhotoView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
    self.toolBar.status = status;
    self.toolBar.frame = statusFrame.toolBarF;
}


@end
