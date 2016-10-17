//
//  HomeViewNewsCell.h
//  02
//
//  Created by fzxa on 16/9/27.
//  Copyright © 2016年 fzxa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewNewsCellFrame;

@interface HomeViewNewsCell : UITableViewCell

@property (nonatomic, strong) HomeViewNewsCellFrame * homeViewNewsCellFrame;

+(instancetype) cellWithTableView:(UITableView *)tableView;

@end
