//
//  BZStatusFrame.h
//  微博
//
//  Created by 白斌 on 15/7/21.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#define BZCellNameFont [UIFont systemFontOfSize:15]
#define BZCellTimeFont [UIFont systemFontOfSize:13]
#define BZCellFormFont [UIFont systemFontOfSize:13]
#define BZCellContentFont [UIFont systemFontOfSize:17]

#import <Foundation/Foundation.h>
#import "BZStatus.h"

@interface BZStatusFrame : NSObject
/**  原创微博  */
@property (nonatomic,assign) CGRect orginalViewF;
/**  头像  */
@property (nonatomic,assign) CGRect iconViewF;
/**  昵称  */
@property (nonatomic,assign) CGRect nameLabelF;
/**  vip  */
@property (nonatomic,assign) CGRect vipViewF;
/**  时间  */
@property (nonatomic,assign) CGRect timeLableF;
/**  来自  */
@property (nonatomic,assign) CGRect fromLableF;
/**  内容  */
@property (nonatomic,assign) CGRect contentLableF;
/**  配图  */
@property (nonatomic,assign) CGRect photoViewF;
/**  cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;
/**  转发微博retweeted_status  */
@property (nonatomic,assign) CGRect retweetViewF;
/**  内容加昵称  */
@property (nonatomic,assign) CGRect retweetContentLableF;
/**  转发微博配图  */
@property (nonatomic,assign) CGRect retweePhotoF;
/**  工具条  */
@property (nonatomic,assign) CGRect toolBarF;
/**  status模型  */
@property (nonatomic,strong) BZStatus *status;

@end
