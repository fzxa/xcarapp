//
//  HomeViewNewsCell.m
//  02
//
//  Created by fzxa on 16/9/27.
//  Copyright © 2016年 fzxa. All rights reserved.
//

#import "HomeViewNewsCell.h"
#import "HomeViewNewsModel.h"
#import "HomeViewNewsView.h"
#import "HomeViewNewsCellFrame.h"


@interface HomeViewNewsCell ()

@property (nonatomic, weak) HomeViewNewsView  *homeViewNewsView;

@end


@implementation HomeViewNewsCell


static NSString * const kCellIdentifier = @"HomeViewNews";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+(instancetype) cellWithTableView:(UITableView *)tableView
{
    HomeViewNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (cell == nil) {
        cell = [[HomeViewNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
    }
    
    return cell;
}



-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        //设置新闻主页frame
        [self setupHomeViewNewsView];
        
    }
    return self;
}

//setter
-(void)setupHomeViewNewsView {
    //父视图
    HomeViewNewsView *homeViewNewsView = [[HomeViewNewsView alloc]init];
    [self.contentView addSubview:homeViewNewsView];
    self.homeViewNewsView = homeViewNewsView;
    
}


-(void)setHomeViewNewsCellFrame:(HomeViewNewsCellFrame *)homeViewNewsCellFrame
{
    _homeViewNewsCellFrame = homeViewNewsCellFrame;
    
    //设置主页新闻数据
    [self setupHomeViewNewsData];
}


//设置主页新闻数据
-(void)setupHomeViewNewsData
{
    self.homeViewNewsView.homeViewNewsCellFrame = self.homeViewNewsCellFrame;
    self.homeViewNewsView.frame = self.homeViewNewsCellFrame.homeViewNewsViewFrame;
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = kHomeViewNewsCellMargin;
    frame.origin.y += kHomeViewNewsCellMargin;
    frame.size.width -=kHomeViewNewsCellMargin;
    frame.size.height -=kHomeViewNewsCellMargin;
    [super setFrame:frame];
}

@end
