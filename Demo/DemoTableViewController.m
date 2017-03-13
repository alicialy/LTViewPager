//
//  DemoTableViewController.m
//  LTViewPager
//
//  Created by Alicia on 16/10/9.
//  Copyright © 2016年 leafteam. All rights reserved.
//

#import "DemoTableViewController.h"

static NSString * const kDemoReuseId = @"DemoCell";

@interface DemoTableViewController ()

@property (nonatomic, strong) NSArray *viewsArray;

@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Demo";
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDemoReuseId];
    self.viewsArray = @[@"ViewControllerViewPager",
                        @"ViewControllerUnderLine",
                        @"ViewControllerEnlarge"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDemoReuseId forIndexPath:indexPath];

    cell.textLabel.text = self.viewsArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.viewsArray[indexPath.row];
    id class = [[NSClassFromString(className) alloc] init];
    if (![class isKindOfClass:[UIViewController class]]) {
        NSLog(@"Error: %@ - is not a view controller", self.viewsArray[indexPath.row]);
        return;
    }
    UIViewController *controller = class;
    controller.title = className;
    controller.view.backgroundColor = self.view.backgroundColor;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
