//
//  BZStatus.h
//  微博
//
//  Created by 白斌 on 15/7/21.
//  Copyright (c) 2015年 BZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZUser.h"

@interface BZStatus : NSObject
/** 	string	微博创建时间 */
@property (nonatomic,copy) NSString *created_at;
/** 	int64	微博MID */
@property (nonatomic,assign) int64_t mid;
/** 	string	字符串型的微博ID */
@property (nonatomic,copy) NSString *idstr;
/** 	string	微博信息内容 */
@property (nonatomic,copy) NSString *text;
/** 	string	微博来源 */
@property (nonatomic,copy) NSString *source;
/** 	string	缩略图片地址，没有时不返回此字段 */
@property (nonatomic,copy) NSString *thumbnail_pic;
/** 	string	中等尺寸图片地址，没有时不返回此字段 */
@property (nonatomic,copy) NSString *bmiddle_pic;
/** original_pic	string	原始图片地址，没有时不返回此字段 */
@property (nonatomic,copy) NSString *original_pic;
/** 模型user */
@property (nonatomic,strong) BZUser *user;

@end
