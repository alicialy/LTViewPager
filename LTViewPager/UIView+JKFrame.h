//
//  UIView+JKFrame.h
//  LTViewPager
//
//  Created by Alicia on 16/10/8.
//  Copyright © 2016年 leafteam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JKFrame)

// shortcuts for frame properties
@property (nonatomic, assign) CGPoint jk_origin;
@property (nonatomic, assign) CGSize jk_size;

// shortcuts for positions
@property (nonatomic) CGFloat jk_centerX;
@property (nonatomic) CGFloat jk_centerY;


@property (nonatomic) CGFloat jk_top;
@property (nonatomic) CGFloat jk_bottom;
@property (nonatomic) CGFloat jk_right;
@property (nonatomic) CGFloat jk_left;

@property (nonatomic) CGFloat jk_width;
@property (nonatomic) CGFloat jk_height;


@end
