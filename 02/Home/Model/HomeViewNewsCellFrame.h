//
//  HomeViewNewsCellFrame.h
//  02
//
//  Created by fzxa on 16/10/11.
//  Copyright © 2016年 fzxa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Common.h"

/**副标题颜色*/
#define kSubTitleColor SETCOLOR(137, 138, 142)

/**标题文字大小*/
#define kHomeViewNewsTitleFont [UIFont systemFontOfSize:16]

/**类型字体大小*/
#define kHomeViewNewsCategoryFont [UIFont systemFontOfSize:14]

/**评论蚊子大小*/
#define kHomeViewNewsCommentFont kHomeViewNewsCategoryFont

@class HomeViewNewsModel;

@interface HomeViewNewsCellFrame : NSObject


@property(nonatomic, strong) HomeViewNewsModel *homeViewNews;

/**父试图*/
@property (nonatomic, assign, readonly) CGRect homeViewNewsViewFrame;

/**新闻类别*/
@property (nonatomic, assign, readonly) CGRect categotyFrame;

/**新闻评论 image*/
@property (nonatomic, assign, readonly) CGRect commentViewFrame;

/**新闻评论*/
@property (nonatomic, assign, readonly) CGRect commentFrame;

/**新闻图片*/
@property (nonatomic, assign, readonly) CGRect newsImageFrame;

/**新闻标题*/
@property (nonatomic, assign, readonly) CGRect titleFrame;

/**新闻发布时间*/
@property (nonatomic, assign, readonly) CGRect pubTimeLabelFrame;

/**分割线*/
@property (nonatomic, assign, readonly) CGRect separatorViewFrame;

/**cell总高度*/
@property (nonatomic, assign, readonly) CGFloat cellHeight;


@end
