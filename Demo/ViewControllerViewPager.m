//
//  ViewControllerViewPager.m
//  LTViewPager
//
//  Created by Alicia on 16/10/10.
//  Copyright © 2016年 leafteam. All rights reserved.
//

#import "ViewControllerViewPager.h"
#import "ChildTableViewController.h"

@interface ViewControllerViewPager ()

@end

@implementation ViewControllerViewPager

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupSubViews];
    
    self.titleColor = [UIColor lightGrayColor];
    self.titleTintColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)p_setupSubViews {
    ChildTableViewController *childController1  = [[ChildTableViewController alloc] init];
    childController1.title = @"Normal1";
    [self addChildViewController:childController1];
    
    ChildTableViewController *childController2  = [[ChildTableViewController alloc] init];
    childController2.title = @"Normal2";
    [self addChildViewController:childController2];
}

@end
