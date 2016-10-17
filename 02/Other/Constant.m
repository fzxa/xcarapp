//
//  Constant.m
//  02
//
//  Created by fzxa on 16/10/11.
//  Copyright © 2016年 fzxa. All rights reserved.
//

#import "Constant.h"

@implementation Constant


CGFloat const kHomeViewNewsCellMargin = 6.0f;
CGFloat const kHomeViewNewsTableViewMargin = 1.0f;

CGFloat const kTableViewContentInset = 100.0f;


//新闻列表
NSString * kGetCarNewsURL = @"http://a.xcar.com.cn/interface/6.0/getNewsList.php";
/** 0.1 刷新的新闻数量 （必须是整10的数，比如10，20，30等等，不然不会返回数据）*/
NSString *  kLimit = @"limit";
/** 0.2 刷新状态 0 为刷新最新的新闻 10 为刷新之前的新闻 每加10则加载更久之前的新闻 */
NSString *  kOffset = @"offset";
/** 0.3 新闻的类型 1为最新新闻（大杂烩） 2（国内外新车） 3（评测） 4（导购） 5（行情）*/
NSString *  kType = @"type";
/** 0.4 version? 传不传没影响 */
NSString *  kVer = @"ver";
@end
