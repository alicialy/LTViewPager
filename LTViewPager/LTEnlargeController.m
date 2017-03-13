//
//  LTEnlargeController.m
//  LTViewPager
//
//  Created by Alicia on 16/10/10.
//  Copyright © 2016年 leafteam. All rights reserved.
//

#import "LTEnlargeController.h"

static const CGFloat kEnlargeScale = 0.2;

@interface LTEnlargeController ()

@end

@implementation LTEnlargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.enlargeScale = kEnlargeScale;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectedLabel:(UILabel *)label {
    self.selectedLabel.transform = CGAffineTransformIdentity;
    
    [super selectedLabel:label];
    
    CGFloat scale = 1.0 + self.enlargeScale;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        label.transform = CGAffineTransformMakeScale(scale, scale);
    }];
}


@end
