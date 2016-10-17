//
//  Common.h
//  02
//
//  Created by fzxa on 16/9/14.
//  Copyright © 2016年 fzxa. All rights reserved.
//




#ifndef Common_h
#define Common_h

#import "Constant.h"

// 设置颜色
#define SETCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define SETACOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenWidth5S 320
#define ScreenWidth6 375
#define ScreenWidth6plus 414


#endif /* Common_h */
