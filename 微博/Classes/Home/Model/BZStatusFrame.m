//
//  BZStatusFrame.m
//  微博
//
//  Created by 白斌 on 15/7/21.
//  Copyright (c) 2015年 BZ. All rights reserved.
//



#import "BZStatusFrame.h"


@implementation BZStatusFrame

- (void)setStatus:(BZStatus *)status
{
    _status = status;
    BZUser *user = status.user;
    CGFloat padding = 10;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width ;
    /**  头像  */
    CGFloat iconW = 35;
    CGFloat iconH = iconW;
    CGFloat iconX = padding;
    CGFloat iconY = padding;
    CGRect iconViewF = CGRectMake(iconX, iconY, iconW, iconH);
    self.iconViewF = iconViewF;
    /**  昵称  */
    CGFloat nameX = CGRectGetMaxX(iconViewF) + padding;
    CGFloat nameY = padding;
    NSMutableDictionary *nameAttrs = [NSMutableDictionary dictionary];
    nameAttrs[NSFontAttributeName] = BZCellNameFont;
    CGSize nameSize = [user.name sizeWithAttributes:nameAttrs];
    CGRect nameLabelF = {{nameX,nameY},nameSize};
    self.nameLabelF = nameLabelF;
    /**  vip  */
    CGFloat vipW = 20;
    CGFloat vipH = vipW;
    CGFloat vipY = padding;
    CGFloat vipX = CGRectGetMaxX(nameLabelF) + padding;
    CGRect vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    self.vipViewF = vipViewF;
    /**  时间  */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(nameLabelF) + padding;
    NSMutableDictionary *timeAttrs = [NSMutableDictionary dictionary];
    timeAttrs[NSFontAttributeName] = BZCellTimeFont;
    CGSize timeSize = [status.created_at sizeWithAttributes:timeAttrs];
    CGRect timeLableF = {{timeX,timeY},timeSize};
    self.timeLableF = timeLableF;
    /**  来自  */
    CGFloat fromX = CGRectGetMaxX(timeLableF) + padding;
    CGFloat fromY = timeY;
    NSMutableDictionary *fromAttrs = [NSMutableDictionary dictionary];
    fromAttrs[NSFontAttributeName] = BZCellFormFont;
    CGSize fromSize = [status.source sizeWithAttributes:fromAttrs];
    CGRect fromLableF = {{fromX,fromY},fromSize};
    self.fromLableF = fromLableF;
    /**  内容  */
    
    NSMutableDictionary *contentAttrs = [NSMutableDictionary dictionary];
    contentAttrs[NSFontAttributeName] = BZCellContentFont;
    
    CGRect contentF = [status.text boundingRectWithSize:CGSizeMake(screenW - 2*padding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:contentAttrs context:nil];
    contentF.origin.x = padding;
    contentF.origin.y = MAX(CGRectGetMaxY(iconViewF), CGRectGetMaxY(timeLableF)) + padding;

    CGRect contentLableF = contentF;
    self.contentLableF = contentLableF;
    /**  配图  */
    CGFloat photoW = 50;
    CGFloat photoH = photoW;
    CGFloat photoX = padding;
    CGFloat photoY = CGRectGetMaxY(contentLableF) + padding;
    CGRect photoViewF = CGRectMake(photoX, photoY, photoW, photoH);
    self.photoViewF = photoViewF;
    /**  原创微博  */
    CGRect orginalViewF;
    if (self.status.thumbnail_pic) {
        orginalViewF = CGRectMake(0, 0, screenW, CGRectGetMaxY(photoViewF) + padding);
    }else{
        orginalViewF = CGRectMake(0, 0, screenW, CGRectGetMaxY(contentF) + padding);
    }
    self.orginalViewF = orginalViewF;
    
    self.cellHeight = CGRectGetMaxY(orginalViewF);
    
}

@end
