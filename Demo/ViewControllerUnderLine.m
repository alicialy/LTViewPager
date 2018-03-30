//
//  ViewController.m
//  LTViewPager
//
//  Created by Alicia on 16/9/23.
//  Copyright © 2016年 leafteam. All rights reserved.
//

#import "ViewControllerUnderLine.h"
#import "ChildTableViewController.h"
#import "LTViewPagerHeader.h"

@interface ViewControllerUnderLine ()

@end

@implementation ViewControllerUnderLine


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.titleTintColor = [UIColor redColor];
    self.titleWidth = SCREEN_WIDTH / 2;
    [self p_setupSubViews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)p_setupSubViews {
    ChildTableViewController *childController1  = [[ChildTableViewController alloc] init];
    childController1.title = @"UnderLine1";
    
    ChildTableViewController *childController2  = [[ChildTableViewController alloc] init];
    childController2.title = @"UnderLine2";
    
    self.controllerArray = @[childController1, childController2];
}


@end
