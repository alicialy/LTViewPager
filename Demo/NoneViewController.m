//
//  NoneViewController.m
//  LTViewPager
//
//  Created by alicia on 2018/12/21.
//  Copyright © 2018 leafteam. All rights reserved.
//

#import "NoneViewController.h"
#import "ChildTableViewController.h"

@interface NoneViewController ()

@end

@implementation NoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addControls];
    
}

- (void)addControls {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(50, 100, CGRectGetWidth(self.view.bounds) - 100, 30)];
    [button setTitle:@"Next" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark - Actions
- (void)nextAction:(id)sender {
    ChildTableViewController *childController = [[ChildTableViewController alloc] init];
    [self.parentViewController.navigationController pushViewController:childController animated:YES];
}


@end
