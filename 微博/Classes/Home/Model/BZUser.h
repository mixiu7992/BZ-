//
//  BZUser.h
//  微博
//
//  Created by 白斌 on 15/7/21.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BZUser : NSObject
/** string	字符串型的用户UID */
@property (nonatomic,copy) NSString *idstr;
/** string	友好显示名称 */
@property (nonatomic,copy) NSString *name;
/** string	用户头像地址（中图），50×50像素 */
@property (nonatomic,copy) NSString *profile_image_url;
/**  vip类型 >2代表是vip  */
@property (nonatomic,assign) int mbtype;
/**  vip等级  */
@property (nonatomic,assign) int mbrank;
/**  是否是VIP  */
@property (nonatomic,assign,getter=isVip) BOOL vip;

@end
