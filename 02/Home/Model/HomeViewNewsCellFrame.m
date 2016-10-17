//
//  HomeViewNewsCellFrame.m
//  02
//
//  Created by fzxa on 16/10/11.
//  Copyright © 2016年 fzxa. All rights reserved.
//

#import "HomeViewNewsCellFrame.h"
#import "HomeViewNewsModel.h"
#import <UIView+SDAutoLayout.h>
#import "Common.h"


@implementation HomeViewNewsCellFrame


-(void)setHomeViewNews:(HomeViewNewsModel *)homeViewNews
{
    _homeViewNews = homeViewNews;
    
    CGFloat cellWith = ScreenWidth - 2 * kHomeViewNewsCellMargin;
    
    //父视图
    CGFloat homeViewNewsViewX = 7.0;
    CGFloat homeViewNewsViewY = 0.0;
    CGFloat homeViewNewsViewW = cellWith - 2* kHomeViewNewsCellMargin;
    CGFloat homeViewNewsViewH = 0.0;
    
    //新闻图片
    CGFloat newsImageX = kHomeViewNewsCellMargin;
    CGFloat newsImageY = kHomeViewNewsCellMargin;
    CGSize newsImageSize = CGSizeMake(90.0, 70.0);
    _newsImageFrame = (CGRect){{newsImageX,newsImageY},newsImageSize};
    
    //新闻标题
    CGFloat newsTitleX = CGRectGetMaxX(_newsImageFrame) + kHomeViewNewsCellMargin;
    CGFloat newsTitleY = kHomeViewNewsCellMargin;
    CGFloat newsTitleW = homeViewNewsViewW - newsImageSize.width - 4 * kHomeViewNewsCellMargin;

    NSDictionary *newsTitleAttrs = @{NSFontAttributeName:kHomeViewNewsTitleFont};
    CGSize newsTitleSize = [homeViewNews.newsTitle sizeWithAttributes:newsTitleAttrs];
    NSInteger rows = ceil(newsTitleSize.width / newsTitleW + 0.5);
    CGFloat newsTitleH = newsTitleSize.height * rows;
    _titleFrame = CGRectMake(newsTitleX, newsTitleY, newsTitleW, newsTitleH);
    
    
    //发布时间
    CGFloat pubTimeX = newsTitleX;
    CGFloat pubTimeY = CGRectGetMaxY(_newsImageFrame) - 3 * kHomeViewNewsCellMargin;
    NSString *punTime = homeViewNews.newsCreateTime;
    NSDictionary *pubTimeAttrs = @{NSFontAttributeName:kHomeViewNewsCategoryFont};
    CGSize pubTimeSize = [punTime sizeWithAttributes:pubTimeAttrs];
    _pubTimeLabelFrame = (CGRect){{pubTimeX,pubTimeY},pubTimeSize};
    
    /** 新闻评论(image) */
    CGFloat commentViewX = CGRectGetMaxX(_pubTimeLabelFrame);
    CGFloat commentViewH = 11.0;
    CGFloat commentViewY = pubTimeY + commentViewH / 2.7;
    CGFloat commentViewW = 11.0;
    if (ScreenWidth == ScreenWidth5S) {
        _commentViewFrame = CGRectMake(commentViewX, commentViewY, commentViewW, commentViewH);
    } else if (ScreenWidth == ScreenWidth6) {
        _commentViewFrame = CGRectMake(commentViewX + 3 * kHomeViewNewsCellMargin, commentViewY, commentViewW, commentViewH);
    } else if (ScreenWidth == ScreenWidth6plus) {
        _commentViewFrame = CGRectMake(commentViewX + 5 * kHomeViewNewsCellMargin, commentViewY, commentViewW, commentViewH);
    }
    
    //新闻评论
    CGFloat commentX = CGRectGetMaxX(_commentViewFrame) + kHomeViewNewsCellMargin;
    CGFloat commentY = pubTimeY;
    
    NSDictionary *commentAttrs = @{NSFontAttributeName:kHomeViewNewsCommentFont};
    NSString *comment = [NSString stringWithFormat:@"%ld", homeViewNews.commentCount];
    CGSize commentSize = [comment sizeWithAttributes:commentAttrs];
    if (homeViewNews.commentCount) {
        _commentFrame = CGRectMake(commentX, commentY, commentSize.width, pubTimeSize.height);
    }
    
    
    //新闻类别
    CGFloat categotyX = 0.0;
    if (ScreenWidth == ScreenWidth5S) {
        categotyX = commentX + commentSize.width / 2 + kHomeViewNewsCellMargin * 3;
    } else if (ScreenWidth == ScreenWidth6) {
        categotyX = commentX + commentSize.width / 2 + kHomeViewNewsCellMargin * 11;
    } else if (ScreenWidth == ScreenWidth6plus) {
        categotyX = commentX + commentSize.width / 2 + kHomeViewNewsCellMargin * 11;
    }
    CGFloat categotyY = commentY;
    NSDictionary *categotyAttrs = @{NSFontAttributeName : kHomeViewNewsCategoryFont};
    CGSize categotySize = [homeViewNews.newsCategory sizeWithAttributes:categotyAttrs];
    if (![homeViewNews.newsCreateTime isEqualToString:@""]) {
        _categotyFrame = (CGRect){{categotyX, categotyY}, categotySize};
    }
    
    //分割线
    CGFloat separatorViewFrameX = homeViewNewsViewX - kHomeViewNewsCellMargin;
    CGFloat separatorViewFrameY = CGRectGetMaxY(_categotyFrame) + 2 * kHomeViewNewsCellMargin;
    CGFloat separatorViewFrameW = homeViewNewsViewW - kHomeViewNewsCellMargin;
    CGFloat separatorViewFrameH = 1;
    _separatorViewFrame = CGRectMake(separatorViewFrameX, separatorViewFrameY, separatorViewFrameW, separatorViewFrameH);
    
    /**父视图高度*/
    homeViewNewsViewH = CGRectGetMaxY(_separatorViewFrame);
    _homeViewNewsViewFrame = CGRectMake(homeViewNewsViewX,homeViewNewsViewY, homeViewNewsViewW, homeViewNewsViewH);
    
    /**cell高度*/
    _cellHeight = CGRectGetMaxY(_homeViewNewsViewFrame) + kHomeViewNewsCellMargin;
}

@end
