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

- (void)selectedLabel:(UILabel *)label {
    [super selectedLabel:label];
    
    if (self.underLineView.jk_width == 0) {
        self.underLineView.jk_width = label.jk_width;
        self.underLineView.jk_centerX = label.jk_centerX;
    } else {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.underLineView.jk_width = label.jk_width;
            self.underLineView.jk_centerX = label.jk_centerX;
        }];
    }
}


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
