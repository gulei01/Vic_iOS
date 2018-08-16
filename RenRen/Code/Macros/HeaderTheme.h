//
//  HeaderTheme.h
//  XYRR
//
//  Created by kyjun on 15/10/15.
//
//

#ifndef HeaderTheme_h
#define HeaderTheme_h



#define theme_Color(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define theme_Color_alpha(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/1.0f]

#define COLORRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define theme_default_color [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]

#define theme_navigation_color  [UIColor colorWithRed:255/255.0 green:37/255.0 blue:68/255.0 alpha:1.0]

#define theme_line_color [UIColor colorWithRed:231/255.0f green:231/255.0f blue:231/255.0f alpha:1.0f]

#define theme_title_color [UIColor colorWithRed:50/255.0f green:50/255.0f blue:50/255.0f alpha:1.0f]

#define theme_price_color [UIColor colorWithRed:231/255.0f green:67/255.0f blue:72/255.0f alpha:1.0f]

#define theme_Fourm_color [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f]

#define theme_table_bg_color [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f]

#define theme_dropdown_bg_color  [UIColor colorWithRed:250/255.0f green:250/255.0f blue:250/255.0f alpha:1.0f]

#endif /* HeaderTheme_h */
