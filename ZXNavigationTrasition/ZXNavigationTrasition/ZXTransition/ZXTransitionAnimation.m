//
// Transition.m
// test
//
// Created by Ziv on 16/7/13.
// Copyright © 2016年 haibara. All rights reserved.
//

#import "ZXTransitionAnimation.h"

@interface ZXTransitionAnimation ()

@property (nonatomic, assign) BOOL isPush;

@end

@implementation ZXTransitionAnimation

- (instancetype)initTransition:(BOOL)isPush {
	if ([super init]) {
		self.isPush = isPush;
	}
	return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
	return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
	UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIView *containerView = [transitionContext containerView];
	if (self.isPush) {
		UIView *fromShot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
		fromVC.view.hidden = YES;

		CGRect finalToViewFrame = [transitionContext finalFrameForViewController:toVC];
		toVC.view.frame = CGRectMake(CGRectGetWidth(finalToViewFrame), 0, CGRectGetWidth(finalToViewFrame), CGRectGetHeight(finalToViewFrame));

		[containerView addSubview:fromShot];
		[containerView addSubview:toVC.view];

		[UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
			fromShot.transform = CGAffineTransformMakeScale(0.85, 0.85);
			toVC.view.frame = finalToViewFrame;
		} completion:^(BOOL finished) {
			[transitionContext completeTransition:YES];
		}];
	}
	else {
		UIView *toShot = containerView.subviews.firstObject;
		CGRect initFromViewFrame = [transitionContext initialFrameForViewController:fromVC];
		[UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
			toShot.transform = CGAffineTransformIdentity;
			fromVC.view.frame = CGRectMake(CGRectGetWidth(initFromViewFrame), 0, CGRectGetWidth(initFromViewFrame), CGRectGetHeight(initFromViewFrame));
		} completion:^(BOOL finished) {
			if ([transitionContext transitionWasCancelled]) {
				[transitionContext completeTransition:NO];
			}
			else {
				[transitionContext completeTransition:YES];
				toVC.view.hidden = NO;
				[toShot removeFromSuperview];
				[containerView insertSubview:toVC.view atIndex:0];
			}
		}];
	}
}

@end
