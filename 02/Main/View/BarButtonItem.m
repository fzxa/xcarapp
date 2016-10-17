//
//  BarButtonItem.m
//  02
//
//  Created by fzxa on 16/10/13.
//  Copyright © 2016年 fzxa. All rights reserved.
//

#import "BarButtonItem.h"
#import "Common.h"

#define TSEBarButtonButtonImageRatio 0.9

#pragma mark class TSEBarButton
@interface TSEBarButton : UIButton

@end

@implementation TSEBarButton

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = contentRect.size.height * TSEBarButtonButtonImageRatio;
    CGFloat titleW = contentRect.size.width + 30;
    CGFloat titleH = contentRect.size.height * TSEBarButtonButtonImageRatio;
    CGFloat titleY = 0.0;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end


#pragma mark class BarButtonItem
@interface  BarButtonItem()

@end

@implementation BarButtonItem


+ (UIBarButtonItem *)barButtonWithImage:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action
{
    TSEBarButton *barButton = [[TSEBarButton alloc]init];
    
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:SETCOLOR(81, 165, 192) forState:UIControlStateNormal];
    [barButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    barButton.bounds = (CGRect){CGPointZero, barButton.currentImage.size};
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}

+ (UIBarButtonItem *)barButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *barButton = [[UIButton alloc] init];
    [barButton setTitle:title forState:UIControlStateNormal];
    [barButton setTitleColor:SETCOLOR(81, 165, 192) forState:UIControlStateNormal];
    [barButton addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    barButton.bounds = CGRectMake(0.0, 0.0, 40.0, 40.0);
    return [[UIBarButtonItem alloc] initWithCustomView:barButton];
}


@end
