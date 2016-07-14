//
// InteractiveTransition.m
// test
//
// Created by Ziv on 16/7/13.
// Copyright © 2016年 haibara. All rights reserved.
//

#import "ZXInteractiveTransition.h"

@interface ZXInteractiveTransition ()
@property (nonatomic, strong) UIViewController *viewController;
@end

@implementation ZXInteractiveTransition

#pragma mark - Public

- (void)addGestureForViewController:(UIViewController *)viewController {
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
	self.viewController = viewController;
	[viewController.view addGestureRecognizer:pan];
}

#pragma mark - Private

- (void)handleGesture:(UIPanGestureRecognizer *)panGesture {
	CGFloat persent = 0;
	CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
	persent = transitionX / panGesture.view.frame.size.width;
	switch (panGesture.state) {
		case UIGestureRecognizerStateBegan:
		{
			self.isActive = YES;
			[self.viewController.navigationController popViewControllerAnimated:YES];
			break;
		}

		case UIGestureRecognizerStateChanged:
		{
			[self updateInteractiveTransition:persent];
			break;
		}

		case UIGestureRecognizerStateEnded:
		{
			self.isActive = NO;
			if (persent > 0.5) {
				[self finishInteractiveTransition];
			}
			else {
				[self cancelInteractiveTransition];
			}
			break;
		}

		default:
			break;
	}
}

@end
