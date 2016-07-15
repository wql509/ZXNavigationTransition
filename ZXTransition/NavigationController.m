//
// NavigationController.m
// ZXNavigationTrasition
//
// Created by Ziv on 16/7/14.
// Copyright © 2016年 Ziv. All rights reserved.
//

#import "NavigationController.h"
#import "ZXTransitionAnimation.h"
#import "ZXInteractiveTransition.h"

@interface NavigationController ()
@property (nonatomic, strong) ZXTransitionAnimation *push;
@property (nonatomic, strong) ZXTransitionAnimation *pop;
@property (nonatomic, strong) ZXInteractiveTransition *interTransition;
@end

@implementation NavigationController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	if ([super initWithCoder:aDecoder]) {
		self.push = [[ZXTransitionAnimation alloc] initTransition:YES];
		self.pop = [[ZXTransitionAnimation alloc] initTransition:NO];
		self.interTransition = [[ZXInteractiveTransition alloc] init];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.delegate = self;
}

#pragma mark - Override

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
	[super pushViewController:viewController animated:animated];
	[self.interTransition addGestureForViewController:viewController];
}

#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
	interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController {
	return self.interTransition.isActive ? self.interTransition : nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
	animationControllerForOperation:(UINavigationControllerOperation)operation
	fromViewController:(UIViewController *)fromVC
	toViewController:(UIViewController *)toVC {
	if (operation == UINavigationControllerOperationPush) {
		return self.push;
	}
	else if (operation == UINavigationControllerOperationPop) {
		return self.pop;
	}
	return nil;
}

@end
