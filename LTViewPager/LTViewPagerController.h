//
//  LTViewPagerController.h
//  LTViewPager
//
//  Created by Alicia on 16/9/30.
//  Copyright © 2016年 leafteam. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat kAnimationDuration = 0.25;

@interface LTViewPagerController : UIViewController

// Title height, default is 40.0
@property (nonatomic, assign) CGFloat titleHeight;

// Title width, use title string width if not set
@property (nonatomic, assign) CGFloat titleWidth;

// Title inset, default is 10.0, not supported when titleWidth is set
@property (nonatomic, assign) CGFloat titleInset;

// Title color, default is black
@property (nonatomic, strong) UIColor *titleColor;

// Title tint color, default is black
@property (nonatomic, strong) UIColor *titleTintColor;

// Tilte Font, default is system font, font size is 15.0
@property (nonatomic, strong) UIFont *titleFont;

// Set tab controllers to this array
@property (nonatomic, strong) NSArray *controllerArray;


@property (nonatomic, weak) UILabel *selectedLabel;

@property (nonatomic, strong) UIScrollView *titleScrollView;


@property (nonatomic, assign, readonly) BOOL isDragging;

@property (nonatomic, assign, readonly) CGFloat lastOffsetX;

- (void)selectedLabel:(UILabel *)label animated:(BOOL)animated;


- (void)didEndDecelerating:(UIScrollView *)scrollView;
- (void)didEndScrollingAnimation:(UIScrollView *)scrollView;
- (void)didScroll:(UIScrollView *)scrollView;
- (void)willBeginDragging:(UIScrollView *)scrollView;

@end
