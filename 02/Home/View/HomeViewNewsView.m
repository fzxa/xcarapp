//
//  HomeViewNewsView.m
//  02
//
//  Created by fzxa on 16/10/11.
//  Copyright © 2016年 fzxa. All rights reserved.
//

#import "HomeViewNewsView.h"
#import "HomeViewNewsCellFrame.h"
#import "HomeViewNewsModel.h"

#import <UIImageView+WebCache.h>
#import "Common.h"


@interface HomeViewNewsView ()


/**新闻类别*/
@property (nonatomic, weak) UILabel *categoryLabel;

/**新闻评论 */
@property (nonatomic, weak) UILabel *commentLabel;

/**新闻评论image*/
@property(nonatomic, weak) UIImageView *commentView;

/**新闻图片 */
@property(nonatomic, weak) UIImageView *newsImageView;

/**新闻标题*/
@property (nonatomic, weak) UILabel *titleLable;

/**新闻发布时间*/
@property (nonatomic, weak) UILabel *pubTimeLabel;

/**分割线*/
@property (nonatomic, weak) UIView *separatorView;


@end

@implementation HomeViewNewsView


-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupHomeViewNewsView];
        [self setBackgroundColor:SETCOLOR(251, 251, 251)];
    }
    
    return self;
}

/**
 *  添加主页新闻的各控件
 */
-(void) setupHomeViewNewsView
{
    //新闻标题
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:kHomeViewNewsTitleFont];
    titleLabel.numberOfLines = 0; //不限制行数
    [self addSubview:titleLabel];
    self.titleLable = titleLabel;
    
    //新闻图片
    UIImageView *newsImageView = [[UIImageView alloc]init];
    newsImageView.layer.masksToBounds = YES;
    newsImageView.layer.cornerRadius = 5.0;
    newsImageView.contentMode = UIViewContentModeScaleAspectFit;//保持图片比例
    [self addSubview:newsImageView];
    self.newsImageView = newsImageView;
    
    /**新闻类别*/
    UILabel * categroyLabel = [[UILabel alloc]init];
    [categroyLabel setFont:kHomeViewNewsCategoryFont];
    categroyLabel.textColor = kSubTitleColor;
    [self addSubview: categroyLabel];
    self.categoryLabel = categroyLabel;
    
    /**新闻评论 image*/
    UIImageView *commentView = [[UIImageView alloc]init];
    [self addSubview:commentView];
    self.commentView = commentView;
    

    
    /**评论*/
    UILabel *commentLabel = [[UILabel alloc]init];
    commentLabel.textColor = kSubTitleColor;
    [commentLabel setFont:kHomeViewNewsCommentFont];
    [self addSubview:commentLabel];
    self.commentLabel = commentLabel;
    
    /**新闻发布时间*/
    UILabel *pubTimeLabel = [[UILabel alloc]init];
    pubTimeLabel.textColor = kSubTitleColor;
    [pubTimeLabel setFont:kHomeViewNewsCategoryFont];
    [self addSubview:pubTimeLabel];
    self.pubTimeLabel = pubTimeLabel;
    
    /**分割线*/
    UIView * separatorView = [[UIView alloc]init];
    [separatorView setBackgroundColor:SETCOLOR(226, 226, 226)];
    [self addSubview:separatorView];
    self.separatorView = separatorView;

}


/**
 * 根据cellframe 对各控件进行赋值
 */

-(void)setHomeViewNewsCellFrame:(HomeViewNewsCellFrame *)homeViewNewsCellFrame
{
    
    
    _homeViewNewsCellFrame = homeViewNewsCellFrame;
    
    HomeViewNewsModel *news = homeViewNewsCellFrame.homeViewNews;
    
    /**新闻标题*/
    self.titleLable.frame = homeViewNewsCellFrame.titleFrame;
    [self.titleLable setText:news.newsTitle];
    
    //新闻图片
    self.newsImageView.frame = homeViewNewsCellFrame.newsImageFrame;
    NSURL *newsImageURL = [NSURL URLWithString:news.newsImage];
    [self.newsImageView sd_setImageWithURL:newsImageURL placeholderImage:[UIImage imageNamed:@"zhanwei2_1"]];
   
    //新闻类型
    if (news.newsCategory) {
        self.categoryLabel.frame = homeViewNewsCellFrame.categotyFrame;
        [self.categoryLabel setText:news.newsCategory];
    }
    
    //新闻评论image
    if (news.commentCount) {
        self.commentView.frame = homeViewNewsCellFrame.commentViewFrame;
        [self.commentView setImage:[UIImage imageNamed:@"6.0baitian_pinglun_old"]];
    }
    
    
    //新闻评论
    if (news.commentCount) {
        self.commentLabel.frame = homeViewNewsCellFrame.commentFrame;
        NSString *comment =[ NSString stringWithFormat:@"%ld" , news.commentCount];
        [self.commentLabel  setText:comment];
    }
    
    //发布时间
    self.pubTimeLabel.frame = homeViewNewsCellFrame.pubTimeLabelFrame;
    self.pubTimeLabel.text = news.newsCreateTime;
    
    //分割线
    self.separatorView.frame = homeViewNewsCellFrame.separatorViewFrame;
}
@end
