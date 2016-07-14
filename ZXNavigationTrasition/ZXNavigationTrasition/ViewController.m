//
// ViewController.m
// ZXNavigationTrasition
//
// Created by Ziv on 16/7/14.
// Copyright © 2016年 Ziv. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Trasition";
}

- (IBAction)push:(UIButton *)sender {
	NextViewController *viewController = [[NextViewController alloc] init];
	[self.navigationController pushViewController:viewController animated:YES];
}

@end
