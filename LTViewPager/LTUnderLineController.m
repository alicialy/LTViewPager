//
//  LTUnderLineController.m
//  LTViewPager
//
//  Created by Alicia on 16/10/10.
//  Copyright © 2016年 leafteam. All rights reserved.
//

#import "LTUnderLineController.h"
#import "UIView+JKFrame.h"


static const CGFloat kTitleUnderLineHeight = 2.0;

@interface LTUnderLineController ()

@property (nonatomic, strong) UIView *underLineView;
@property (nonatomic, assign) CGFloat lastUnderLineOffsetX;
@property (nonatomic, assign) NSUInteger continuousDragIndex;

@end

@implementation LTUnderLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.underLineColor = [UIColor redColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public Method
- (void)selectedLabel:(UILabel *)label animated:(BOOL)animated {
    [super selectedLabel:label animated:animated];
    
//    CGFloat labelWidth = (self.underLineWidth == 0) ? [label sizeThatFits:CGSizeZero].width : self.underLineWidth;

    CGFloat labelWidth = [label sizeThatFits:CGSizeZero].width;
    
    if (animated) {
        if (self.underLineView.jk_width == 0) {
            self.underLineView.jk_width = labelWidth;
            self.underLineView.jk_centerX = label.jk_centerX;
        } else {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.underLineView.jk_width = labelWidth;
                self.underLineView.jk_centerX = label.jk_centerX;
                
                self.lastUnderLineOffsetX = self.underLineView.jk_centerX - labelWidth / 2;
            }];
        }
    } else {
        self.underLineView.jk_width = labelWidth;
        self.underLineView.jk_centerX = label.jk_centerX;
        
        self.lastUnderLineOffsetX = label.center.x - (labelWidth )  / 2 ;
    }

}

- (void)willBeginDragging:(UIScrollView *)scrollView {
    self.continuousDragIndex += 1;
}

- (void)didScroll:(UIScrollView *)scrollView {
    if (!self.isDragging) {
        return;
    }
    CGFloat movingOffsetX = scrollView.contentOffset.x - self.lastOffsetX;
    [self p_moveSelectedLineByScrollWithOffsetX:movingOffsetX];
}

- (void)didEndDecelerating:(UIScrollView *)scrollView {
    self.continuousDragIndex = 0;
}

#pragma mark - Private Method
- (void)p_moveSelectedLineByScrollWithOffsetX:(CGFloat)offsetX {
    CGFloat lastUnderLineOffsetX = self.lastUnderLineOffsetX;
    NSInteger buttonCount = [self.controllerArray count];
    CGFloat tabMargin = 0;
    CGFloat textGap = (self.view.jk_width - tabMargin * 2 - self.underLineView.jk_width * buttonCount) / (buttonCount * 2) ;

    CGFloat speed = 50;
    CGFloat moveDistance = lastUnderLineOffsetX + (offsetX * (textGap + self.underLineView.jk_width + speed)) / [UIScreen mainScreen].bounds.size.width;
    
    CGFloat underLineMaxOffsetX = lastUnderLineOffsetX + textGap * 2 + self.underLineView.jk_width;
    CGFloat underLineMinOffsetX = lastUnderLineOffsetX - textGap * 2 - self.underLineView.jk_width;
    CGFloat underLineOffsetX = 0;
    
    BOOL isContinuousDrag = self.continuousDragIndex > 1 ? YES : NO;
    if (moveDistance > underLineMaxOffsetX && !isContinuousDrag) {
        underLineOffsetX = underLineMaxOffsetX;
    } else if (moveDistance < underLineMinOffsetX && !isContinuousDrag) {
        underLineOffsetX = underLineMinOffsetX;
    } else {
        if (isContinuousDrag) {
            if (moveDistance > self.view.jk_width - (tabMargin + textGap + self.underLineView.jk_width)) {
                underLineOffsetX = self.view.jk_width - (tabMargin + textGap + self.underLineView.jk_width);
            } else if (moveDistance < tabMargin + textGap) {
                underLineOffsetX = tabMargin + textGap;
            } else {
                underLineOffsetX = moveDistance;
            }
        } else {
            underLineOffsetX = moveDistance;
        }
    }
    
    [self.underLineView setFrame:CGRectMake(underLineOffsetX, self.underLineView.jk_top, self.underLineView.jk_width, self.underLineView.jk_height)];
}

#pragma mark - Getters
- (UIView *)underLineView {
    if (_underLineView) {
        return _underLineView;
    }
    _underLineView = [[UIView alloc] init];
    _underLineView.backgroundColor = self.underLineColor;
    _underLineView.frame = CGRectMake(0, self.titleHeight - kTitleUnderLineHeight, 0, kTitleUnderLineHeight);
    [self.titleScrollView addSubview:_underLineView];
    return _underLineView;
}

@end
