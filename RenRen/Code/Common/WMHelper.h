//
//  WMHelper.h
//  Storyboard.XYZD
//
//  Created by kyjun on 15/6/23.
//  Copyright (c) 2015年 完美网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
/**
 *  工具类
 */
@interface WMHelper : NSObject
/**
 *  归档路径当前用户
 *
 *  @return NSString 当前用户的归档信息
 */
+(NSString *)archiverPath;

/**
 *  用户当前定位的商圈归档路径
 *
 *  @return NSString 当前定位的商圈归档路径
 */
+(NSString *)archiverLocationCirclePath;
/**
 *  搜索结果归档路径
 *
 *  @return NSString 搜索关键词归档路径
 */
+(NSString *)searchArchiverPath;
/**
 *  当前定位信息(类似于美团)
 *
 *  @return NSString 当前定位的商圈的基本信息
 */
+(NSString *)archiverMapLocationPath;

@end

@interface WMHelper(Image)
/**
 *  拍照旋转
 *
 *  @param image UIImage
 *
 *  @return UIImage
 */
+(UIImage *)scaleAndRotateImage:(UIImage *)image;
/**
 *  图像通过缩放和裁切尺寸为
 *
 *  @param targetSize CGSize 目标尺寸
 *
 *  @return UImage
 */
+(UIImage*)imageByScalingAndCroppingForSize:(UIImage*)image targetSize:(CGSize)targetSize;

+(UIImage*)makeImageWithColor:(UIColor*)color width:(CGFloat)width height:(CGFloat)height;

@end

@interface WMHelper(EmptyData)
+(void)tableVieBackground:(UITableView*)tableView;

+(UIButton *)createButton:(NSString *)norImage highlighted:(NSString *)higImage title:(NSString*)title insets:(UIEdgeInsets)insets;

@end

@interface WMHelper(Date)
/**
 *  日期转换成日期字符串
 *
 *  @param dates NSDate 日期
 *
 *  @return NSString 日期字符 串
 */
+ (NSString *)convertToStringWithDate:(NSDate *)date;
/**
 *  日期转换成指定的格式
 *
 *  @param date  NSDate 日期
 *  @param format NSString 日期格式 
 *  可传nil即按照默认的转换方式
 *
 *  @return NSString 转换成指定的日期字符串
 */
+(NSString*)convertToStringWithDate:(NSDate *)date format:(NSString*)format;

/**
 *  返回当前日期字符串
 *
 *  @return NSString 当前日期字符串
 */
+ (NSString *)currentDate;
/**
 *  返回当前日期的字符串
 *
 *  @param format NSString 格式字符串
 *
 *  @return NSString 日前字符串
 */
+(NSString*)currentDateWithFormat:(NSString*)format;
/**
 *  根据字符放回日期
 *
 *  @param dateStr NSString 日期 字符串
 *
 *  @return NSDate 日期
 */
+ (NSDate*) convertToDateWithStr:(NSString*)dateStr;
/**
 *  日期字符串转换成指定格式的日期字符串
 *
 *  @param dataStr NSString 日期 字符串
 *  @param format NSString 格式字符串
 *  可传nil即按照默认的格式转换
 *
 *  @return NSDate 日期
 */
+ (NSDate*) convertToDateWithStr:(NSString*)dateStr format:(NSString*)format;
/**
 *  日期字符串转换成中文格式 ex: 昨天 今天 或者 更早
 *
 *  @param dateStr NSString 日期字符串
 *
 *  @return NSString 日期字符串
 */
+(NSString*)convertToChineseFormat:(NSString*)dateStr;
/**
 *  根据日期字符串返回当前星期几
 *
 *  @param str NSString 日期字符串
 *
 *  @return NSString 星期几
 */
+ (NSString*)weekDays:(NSString *)dateStr;
/**
 *  时间戳装换成时间字符串
 *
 *  @param timeStamp NSString 时间戳字符
 *
 *  @return 返回指定格式的日期字符串
 */
+(NSString*)timeStampConvertToDateString:(NSString*)timeStamp;
/**
 *  时间戳装换成时间字符串
 *
 *  @param timeStamp NSString 时间戳字符
 *  @param formate   NSString 日期字符格式
 *
 *  @return 返回指定格式的日期字符串
 */
+(NSString*)timeStampConvertToDateString:(NSString*)timeStamp formate:(NSString*)formate;
@end

@interface WMHelper (Str)
/**
 *  验证邮箱
 *
 *  @param email NSString 邮箱地址
 *
 *  @return BOOL YES 是有效邮箱地址 否则为NO
 */
+(BOOL)isValidateEmail:(NSString *)email;
/**
 *  验证手机号
 *
 *  @param mobile NSString 手机号码
 *
 *  @return BOOL YES 是有效手机号 否则为NO
 */
+(BOOL) isValidateMobile:(NSString *)mobile;
/**
 *  判断当前字符是否为NSNULL 空类型、空对象、空字符(或仅包含空格)
 *
 *  @param string NSString 字符串
 *
 *  @return BOOL 返回YES 标示是空字符串 否则为NO
 */
+ (BOOL) isEmptyOrNULLOrnil:(NSString *)string;
/**
 *  验证字符串中是否包含指定字符串
 *
 *  @param string         NSString 字符串
 *  @param containsString NSString 部分字符串
 *
 *  @return BOOL YES 包含部分字符串 否则为NO
 */
+ (BOOL)stingContainsString:(NSString *)string withString:(NSString*)containsString;
/**
 *  判断当前对象是否为空或空类型
 *
 *  @param sender id 动态类型对象
 *
 *  @return Boolean YES 对象为空或空类型 否则为NO
 */
+(Boolean)isNULLOrnil:(id)sender;

/**
 *  NSInteger 转化成 NSString
 *
 *  @param num NSInteger 数字类型
 *
 *  @return NSString 返回转换成功的字符串
 */
+(NSString*)integerConvertToString:(NSInteger)num;
/**
 *  int 转化成 NSString
 *
 *  @param num int 数字类型
 *
 *  @return NSString 返回转换成功的字符串
 */
+(NSString*)intConvertToString:(int)num;

/**
 *  计算文本的高度根据制定的字体大小和文本宽度
 *
 *  @param str NSString 要计算的文本字符串
 *  @param font   UIFont 文本显示的字体大小
 *  @param width  float 文本的宽度
 *
 *  @return float 文本的高度
 */
+ (float)calculateTextHeight:(NSString*)str font:(UIFont *)font width:(float)width;
/**
 *  计算属性字符的高度 根据指定的宽度
 *
 *  @param str    NSAttributeString 属性字符串
 *  @param width float 文本宽度
 *
 *  @return float 文本的高度
 */
+(float)calculateAttributeStrHeight:(NSAttributedString*)str width:(float)width;
/**
 *  计算属性字符的高度 根据指定的字体大小和宽度
 *
 *  @param str   NSAttributeString 属性字符串
 *  @param font  UIFont 字体大小
 *  @param width float 文本宽度
 *
 *  @return float 文本的高度
 */
+(float)calculateAttributeStrHeight:(NSAttributedString*)str font:(UIFont*)font width:(float)width;
/**
 *  计算文本的宽度根据指定的字体大小和文本的高度
 *
 *  @param str    NSString 要计算的文本字符串
 *  @param font   UIFont 文本显示的字体大小
 *  @param height float 文本的高度
 *
 *  @return float 文本的宽度
 */
+ (float)calculateTextWidth:(NSString*)str font:(UIFont *)font  height:(float)height;
+ (float)calculateTextWidth:(NSString*)str font:(UIFont *)font;
/**
 *  计算字符串中图片的 高宽
 *
 *  @param str    NSString 要计算的文本字符串
 *  @param widht  CGFloat  文本的宽度
 *
 *  @return 新德字符串
 */
+(NSString*)calculateContent:(NSString*)str width:(CGFloat)width;

+ (NSString *)chantag:(NSString *)tag WithTag:(NSString *)tag2 html:(NSString *)html;

+ (NSString *)removeTag:(NSString *)tag html:(NSString *)html;

 

/**
 *  将文本转换成json 字符输出
 *
 *  @param sender id json 格式的对象
 *

 */
+ (void)outPutJsonString:(id)sender;
@end
 
