//
//  WMHelper.m
//  Storyboard.XYZD
//
//  Created by kyjun on 15/6/23.
//  Copyright (c) 2015年 完美网络科技有限公司. All rights reserved.
//

#import "WMHelper.h"
#import <CoreText/CoreText.h>

@implementation WMHelper

+(NSString *)archiverPath{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0] stringByAppendingPathComponent:@"user.archiver"];
}
+(NSString *)archiverLocationCirclePath{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0] stringByAppendingPathComponent:@"mlocation.archiver"];
}

+(NSString *)searchArchiverPath{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0] stringByAppendingPathComponent:@"searchHistory.archiver"];
}

+(NSString*)archiverMapLocationPath{
    NSArray *array =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[array objectAtIndex:0] stringByAppendingPathComponent:@"mapLocation.archiver"];
}

@end

@implementation WMHelper(Image)

+(UIImage *)scaleAndRotateImage:(UIImage *)image
{
    int kMaxResolution = 600; //PUT YOUR DESIRED RESOLUTION HERE
    
    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}


+(UIImage*)imageByScalingAndCroppingForSize:(UIImage*)image targetSize:(CGSize)targetSize
{
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
        {
            scaleFactor = widthFactor; // scale to fit height
        }
        else
        {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
        {
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
    {
        //NSLog(@"could not scale image");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(UIImage *)makeImageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height{
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end


@implementation WMHelper(EmptyData)

+(void)tableVieBackground:(UITableView *)tableView{
    UIView* backgroundView = [[UIView alloc]initWithFrame:tableView.bounds];
    UIImage* image =[UIImage imageNamed:@"ex_4@2x"];
    UIImageView* photo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [backgroundView addSubview:photo];
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, tableView.frame.size.height,tableView.frame.size.width,tableView.frame.size.height/2)];
    messageLabel.text = @"No data is currently available. Please pull down to refresh.";
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
    [messageLabel sizeToFit];
    [backgroundView addSubview:messageLabel];
    
    tableView.backgroundView = photo;
}
+ (UIButton *)createButton:(NSString *)norImage highlighted:(NSString *)higImage title:(NSString*)title insets:(UIEdgeInsets)insets
{
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = CGRectMake(0, 0, 44, 44);
    b.contentEdgeInsets = insets;
    if (title) {
        if (norImage)
            [b setBackgroundImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
        if (higImage)
            [b setBackgroundImage:[UIImage imageNamed:higImage] forState:UIControlStateHighlighted];
        
        [b setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        if (norImage)
            [b setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
        if (higImage)
            [b setImage:[UIImage imageNamed:higImage] forState:UIControlStateHighlighted];
    }
    b.contentMode = UIViewContentModeScaleAspectFit;
    return b;
}
@end

@implementation WMHelper (Date)

+(NSString *)convertToStringWithDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)convertToStringWithDate:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+(NSString *)currentDate{
    NSDate *today=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:today];
    return destDateString;
}

+(NSString *)currentDateWithFormat:(NSString *)format{
    NSDate *today=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:today];
    return destDateString;
}
+(NSDate *)convertToDateWithStr:(NSString *)dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:dateStr];
    return date;
}
+ (NSDate*) convertToDateWithStr:(NSString*)dateStr format:(NSString*)format{
    if(!format)
        [self convertToDateWithStr:dateStr];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    NSDate *date=[formatter dateFromString:dateStr];
    return date;
}

+(NSString *)convertToChineseFormat:(NSString *)dateStr
{
    NSDate *timedate=[self convertToDateWithStr:dateStr];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HH:mm"];
    NSString *showtimeString = [dateFormatter1 stringFromDate:timedate];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
    NSString *showDateString=[dateFormatter2 stringFromDate:timedate];
    NSTimeInterval timeValue = [timedate timeIntervalSince1970];
    NSDate *today=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:today];
    destDateString=[destDateString stringByAppendingString:@" 00:00"];
    NSDate *todayDate=[self convertToDateWithStr:destDateString];
    NSTimeInterval todayDateValue = [todayDate timeIntervalSince1970];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *earlyDate=[todayDate dateByAddingTimeInterval:-secondsPerDay];
    NSTimeInterval earlyDateValue = [earlyDate timeIntervalSince1970];
    if((long long int)todayDateValue < (long long int)timeValue)
    {
        showtimeString=[NSString stringWithFormat:@"今天 %@",showtimeString];
    }
    
    else if((long long int)earlyDateValue < (long long int)timeValue && (long long int)todayDateValue > (long long int)timeValue )
    {
        showtimeString=[NSString stringWithFormat:@"昨天 %@",showtimeString];
    }
    else{
        showtimeString=[NSString stringWithFormat:@"%@",showDateString];
    }
    return showtimeString;
}

+(NSString*)weekDays:(NSString *)dateStr
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *dates=[self convertToDateWithStr:dateStr];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps  = [calendar components:unitFlags fromDate:dates];
    NSInteger  week = [comps weekday];
    switch (week) {
        case 1:
            return @"星期日";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        default:
            return @"星期六";
            break;
    }
}

+(NSString *)timeStampConvertToDateString:(NSString *)timeStamp{
    double lastactivityInterval = [timeStamp doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
+(NSString *)timeStampConvertToDateString:(NSString *)timeStamp formate:(NSString *)formate{
    if(!formate)
        [self timeStampConvertToDateString:timeStamp];
    double lastactivityInterval = [timeStamp doubleValue];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formate];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

@end

@implementation WMHelper (Str)


+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL) isValidateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
+ (BOOL) isEmptyOrNULLOrnil:(NSString *)string {
    if ([WMHelper isNULLOrnil:string]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
+ (BOOL)stingContainsString:(NSString *)string withString:(NSString*)containsString
{
    BOOL ret = YES;
    do {
        NSRange range = [string rangeOfString:containsString];
        if (range.location ==NSNotFound)
        {
            ret = NO;
        }
    } while (0);
    return ret;
}

+(Boolean)isNULLOrnil:(id)sender{
    if (((NSNull *)sender == [NSNull null])||(sender==nil))
        return YES;
    return NO;
}

+(NSString *)integerConvertToString:(NSInteger)num{
    return [NSString stringWithFormat:@"%ld",(long)num];
}

+(NSString *)intConvertToString:(int)num{
    return [NSString stringWithFormat:@"%d",num];
}

+ (float)calculateTextHeight:(NSString*)str font:(UIFont *)font width:(float)width{
    CGSize constraint = CGSizeMake(width, CGFLOAT_MAX);
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:str attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    CGSize size = rect.size;
    return size.height;
}
+(float)calculateAttributeStrHeight:(NSAttributedString*)str width:(float)width{
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)str);
    CGRect drawingRect = CGRectMake(0, 0, width, 1000);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 1000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
}
+(float)calculateAttributeStrHeight:(NSAttributedString *)str font:(UIFont *)font width:(float)width
{
    float total_height = 0.f;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)str);
    CGRect drawingRect = CGRectMake(0, 0, width, 1000);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    float line_y = (int) origins[[linesArray count] -1].y;
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    total_height = 1000 - line_y + (int) descent;
    CFRelease(textFrame);
    return total_height;
    
}

+ (float)calculateTextWidth:(NSString*)str font:(UIFont *)font  height:(float)height{
    CGSize constraint = CGSizeMake(CGFLOAT_MAX, height);
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:str   attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint  options:NSStringDrawingUsesLineFragmentOrigin  context:nil];
    CGSize size = rect.size;
    return size.width;
}

+ (float)calculateTextWidth:(NSString*)str font:(UIFont *)font{
    CGSize size =[str sizeWithAttributes:@{NSFontAttributeName:font}];
    return size.width;
}


+(NSString *)calculateContent:(NSString *)str width:(CGFloat)width{
    NSUInteger length = [str length];
    NSRange range = NSMakeRange(0, length);
    NSString* empty =nil;
    while(range.location != NSNotFound)
    {
        //获取特定字符位置
        range = [str rangeOfString: @"w='288' h='" options:0 range:range];
        
        if(range.location != NSNotFound)
        {
            //从自定位置开始截取字符
            empty = [str substringWithRange:NSMakeRange(range.location+range.length,str.length-(range.location+range.length))];
            
            // range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            //找到下一个特定字符
            NSRange  emptyRange = [empty rangeOfString: @"'"];
            
          //  NSLog(@"%@",NSStringFromRange(emptyRange));
            //找到高度字符串
            NSString* newStr = [empty substringWithRange:NSMakeRange(0, emptyRange.location)];
            CGFloat width = 288.f;
            CGFloat height = [newStr floatValue];
           // NSLog(@"%@",newStr);
            
            CGFloat newWidth = width;
            CGFloat newHeight = height*newWidth/width;
            //创建替换字符的位置
            NSRange subRang = NSMakeRange(range.location, range.length+emptyRange.location+1);
            //创建替换字符
            NSString* subStr =[NSString stringWithFormat:@"width ='%.2f' height='%.2f'",newWidth,newHeight];
            //替换字符 返回新字符串
            str = [str stringByReplacingCharactersInRange:subRang withString:subStr];
            
            length  =str.length;
            range = NSMakeRange(0, length);
            
        }
    }
    return str;
}


+ (NSString *)chantag:(NSString *)tag WithTag:(NSString *)tag2 html:(NSString *)html {
    NSString* pattern = [NSString stringWithFormat:@"<%@[^>]*>", tag];
    NSString* pattern2 = [NSString stringWithFormat:@"</?%@[^>]*>", tag];
    
    NSRegularExpression *removeTagExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *matchs = [removeTagExpression matchesInString:html options:0 range:NSMakeRange(0, html.length)];
    
    
    NSInteger rangeOffset = 0;
    
    for (NSTextCheckingResult *match in matchs) {
        
        NSRange tagRange = NSMakeRange(match.range.location + rangeOffset, match.range.length);
        
        html = [html stringByReplacingCharactersInRange:tagRange withString:[NSString stringWithFormat:@"<%@>",tag2]];
        NSLog(@"%@",@(match.range.location));
        rangeOffset -= (tagRange.length-[NSString stringWithFormat:@"<%@>",tag2].length);
    }
    
    rangeOffset = 0;
    NSRegularExpression *removeTagExpression2 = [NSRegularExpression regularExpressionWithPattern:pattern2 options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *matchs2 = [removeTagExpression2 matchesInString:html options:0 range:NSMakeRange(0, html.length)];
    
    for (NSTextCheckingResult *match in matchs2) {
        
        NSRange tagRange = NSMakeRange(match.range.location + rangeOffset, match.range.length);
        
        html = [html stringByReplacingCharactersInRange:tagRange withString:[NSString stringWithFormat:@"<%@>",tag2]];
        
        rangeOffset -= (tagRange.length-[NSString stringWithFormat:@"<%@>",tag2].length);
    }
    
    
    return html;
}

+ (NSString *)removeTag:(NSString *)tag html:(NSString *)html {
    NSString* pattern = [NSString stringWithFormat:@"</?\\s*%@[^>]*>", tag];
    NSRegularExpression *removeTagExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *matchs = [removeTagExpression matchesInString:html options:0 range:NSMakeRange(0, html.length)];
    
    NSInteger rangeOffset = 0;
    for (NSTextCheckingResult *match in matchs) {
        NSRange tagRange = NSMakeRange(match.range.location + rangeOffset, match.range.length);
        html = [html stringByReplacingCharactersInRange:tagRange withString:@""];
       // NSLog(@"%@",@(match.range.location));
        rangeOffset -= tagRange.length;
    }
    
    return html;
}

+(void)outPutJsonString:(id)sender{
#if DEBUG
    if ([NSJSONSerialization isValidJSONObject:sender])
    {
        NSLog(@"========================================================");
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sender options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"json data:\n  %@",json);
        NSLog(@"========================================================");
    }else{
         NSLog(@"json 格式错误");
    }
#endif
}

@end

 
