//
//  HomeViewNewsModel.m
//  02
//
//  Created by fzxa on 16/10/11.
//  Copyright © 2016年 fzxa. All rights reserved.
//

#import "HomeViewNewsModel.h"

@implementation HomeViewNewsModel


-(void) setNewsCreateTime:(NSString *)newsCreateTime
{
    //服务器返回时间数据
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[newsCreateTime intValue]];
    _newsCreateTime = [formatter stringFromDate:confromTimesp];
    
}

-(void) setPubTime:(NSInteger)pubTime
{
    NSString *pubTimeStr = [NSString stringWithFormat:@"%ld%@", pubTime, _newsCreateTime];
    _pubTime = [pubTimeStr integerValue];
}
@end
