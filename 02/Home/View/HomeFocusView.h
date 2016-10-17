//
//  HomeFocusView.h
//  02
//
//  Created by fzxa on 16/10/14.
//  Copyright © 2016年 fzxa. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HomeFocusView;
@protocol HomeFocusViewDelegate <NSObject>
-(void)loopViewDidSelectedImage:(HomeFocusView *)loopView index:(int)index;
@end


@interface HomeFocusView : UIView

@property (nonatomic, weak) id<HomeFocusViewDelegate> delegate;
@property (nonatomic, assign) BOOL autoPlay;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) NSArray *images;

-(instancetype) initWithFrame:(CGRect)frame images:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval *)timeInterval;

- (void)setLoopViewImages:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;

@end
