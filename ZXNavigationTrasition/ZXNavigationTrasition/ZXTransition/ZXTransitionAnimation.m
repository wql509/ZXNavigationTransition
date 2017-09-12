//
// Transition.m
// test
//
// Created by Ziv on 16/7/13.
// Copyright © 2016年 haibara. All rights reserved.
//

#import "ZXTransitionAnimation.h"

@interface ZXTransitionAnimation () <CAAnimationDelegate>

@property (nonatomic, assign) BOOL isPush;
@property (nonatomic, assign) TransitionAnimationStyle style;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGFloat startRadius;
@property (nonatomic, assign) CGFloat toDuration;
@property (nonatomic, assign) CGFloat backDuration;
@property (nonatomic, strong) UIBezierPath *startPath;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation ZXTransitionAnimation

- (instancetype)initTransition:(BOOL)isPush animationStyle:(TransitionAnimationStyle)style {
	if ([super init]) {
		self.isPush = isPush;
		self.style = style;
		self.startPoint = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2, CGRectGetHeight([UIScreen mainScreen].bounds) / 2);
		self.startRadius = 20;
		self.toDuration = 0.5;
		self.backDuration = 0.5;
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
	
	CGRect finalToViewFrame = [transitionContext finalFrameForViewController:toVC];
	if (self.isPush) {
		if (self.style == TransitionAnimationStyleLocker) {
			UIView *fromShot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
			fromVC.view.hidden = YES;
			
			toVC.view.frame = CGRectMake(CGRectGetWidth(finalToViewFrame), 0, CGRectGetWidth(finalToViewFrame), CGRectGetHeight(finalToViewFrame));
			
			[containerView addSubview:fromShot];
			[containerView addSubview:toVC.view];
			
			[UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
				fromShot.transform = CGAffineTransformMakeScale(0.85, 0.85);
				toVC.view.frame = finalToViewFrame;
			} completion:^(BOOL finished) {
				[transitionContext completeTransition:YES];
			}];
		}else if (self.style == TransitionAnimationStyleCircleSpread) {
			toVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(finalToViewFrame), CGRectGetHeight(finalToViewFrame));
			[containerView addSubview:toVC.view];
			UIBezierPath *startCycle =  [UIBezierPath bezierPathWithArcCenter:self.startPoint radius:self.startRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
			CGFloat x = self.startPoint.x;
			CGFloat y = self.startPoint.y;
			CGFloat endX = MAX(x, containerView.frame.size.width - x);
			CGFloat endY = MAX(y, containerView.frame.size.height - y);
			CGFloat radius = sqrtf(pow(endX, 2) + pow(endY, 2));
			UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:self.startPoint radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
			CAShapeLayer *maskLayer = [CAShapeLayer layer];
			maskLayer.path = endCycle.CGPath;
			toVC.view.layer.mask = maskLayer;
			self.startPath = startCycle;
			self.maskLayer = maskLayer;
			self.containerView = containerView;
			CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
			maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
			maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
			maskLayerAnimation.duration = self.toDuration;
			maskLayerAnimation.delegate = self;
			[maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
			[maskLayer addAnimation:maskLayerAnimation forKey:@"xw_path"];
		}
	}
	else {
		if (self.style == TransitionAnimationStyleLocker) {
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
		}else if (self.style == TransitionAnimationStyleCircleSpread) {
			[containerView insertSubview:toVC.view atIndex:0];
			UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:self.startPoint radius:self.startRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
			CAShapeLayer *maskLayer = (CAShapeLayer *)fromVC.view.layer.mask;
			CGPathRef startPath = maskLayer.path;
			maskLayer.path = endCycle.CGPath;
			self.maskLayer = maskLayer;
			self.startPath = [UIBezierPath bezierPathWithCGPath:startPath];
			self.containerView = containerView;
			CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
			maskLayerAnimation.fromValue = (__bridge id)(startPath);
			maskLayerAnimation.toValue = (__bridge id)(endCycle.CGPath);
			maskLayerAnimation.duration = self.backDuration;
			maskLayerAnimation.delegate = self;
			[maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
			[maskLayer addAnimation:maskLayerAnimation forKey:@"xw_path"];
		}
	}
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
	id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
	[transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}

#pragma mark - ZXInteractiveTransitionDelegate

- (void)zx_finished {
	
}

- (void)zx_cacelled {
	_maskLayer.path = _startPath.CGPath;
}

@end
