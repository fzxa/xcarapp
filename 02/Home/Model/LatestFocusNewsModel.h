//
//  LatestFocusNewsModel.h
//  02
//
//  Created by fzxa on 16/10/13.
//  Copyright © 2016年 fzxa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LatestFocusNewsModel : NSObject

/**图片链接*/
@property (nonatomic, copy) NSString *imgURL;
/**新闻标题*/
@property (nonatomic, copy) NSString *title;
/**详细新闻链接*/
@property (nonatomic, copy) NSString *newsLink;
@end
