//
//  BZUser.h
//  微博
//
//  Created by 白斌 on 15/7/21.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BZUserVerifiedTypeNone = -1, // 没有任何认证
    
    BZUserVerifiedPersonal = 0,  // 个人认证
    
    BZUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    BZUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    BZUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    BZUserVerifiedDaren = 220 // 微博达人
} BZUserVerifiedType;

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
/**  是否是加v用户  */
@property (nonatomic,assign) BZUserVerifiedType verified_type;

@end
