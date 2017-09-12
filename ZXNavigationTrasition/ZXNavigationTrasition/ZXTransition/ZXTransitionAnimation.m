//
// Transition.m
// test
//
// Created by Ziv on 16/7/13.
// Copyright © 2016年 haibara. All rights reserved.
//

#import "ZXTransitionAnimation.h"

@interface ZXTransitionAnimation ()
@property (nonatomic, strong) ZXAnimationManager* manager;
@end

@implementation ZXTransitionAnimation

- (instancetype)initTransition:(BOOL)isPush animationStyle:(TransitionAnimationStyle)style {
	if ([super init]) {
		self.manager = [[ZXAnimationManager alloc] initAnimation:isPush style:style];
	}
	return self;
}

#pragma mark - Protect

- (id<ZXInteractiveTransitionDelegate>)delegate {
	return _manager;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
	return [self.manager zx_animateDuration];
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
	[self.manager zx_animateTransition:transitionContext];
}

@end
