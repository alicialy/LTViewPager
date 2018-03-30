//
//  ViewControllerEnlarge.m
//  LTViewPager
//
//  Created by Alicia on 16/10/10.
//  Copyright © 2016年 leafteam. All rights reserved.
//

#import "ViewControllerEnlarge.h"
#import "ChildTableViewController.h"

@interface ViewControllerEnlarge ()

@end

@implementation ViewControllerEnlarge

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupSubViews];
    
    self.titleTintColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)p_setupSubViews {
    NSInteger count = 8;
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        ChildTableViewController *childController  = [[ChildTableViewController alloc] init];
        childController.title = [NSString stringWithFormat:@"Enlarge%ld", i];
        [tempArray addObject:childController];
    }
    
    self.controllerArray = [tempArray copy];
}


@end
