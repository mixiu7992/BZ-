//
//  BZAccount.h
//  微博
//
//  Created by 白斌 on 15/7/20.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BZAccount : NSObject<NSCoding>

/**  uid  当前授权用户的UID。*/
@property (nonatomic,copy) NSString *uid;
/**  expires_in access_token的生命周期，单位是秒数。 */
@property (nonatomic,copy) NSString *expires_in;
/**  access_token  */
@property (nonatomic,copy) NSString *access_token;
/**  授权时间  */
@property (nonatomic,strong) NSDate *creatDate;
/**  当前用户昵称  */
@property (nonatomic,copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
