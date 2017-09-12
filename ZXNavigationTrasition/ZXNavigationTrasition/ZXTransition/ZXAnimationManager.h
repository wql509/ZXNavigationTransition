//
//  ZXAnimationManager.h
//  ZXNavigationTrasition
//
//  Created by ziv on 2017/9/12.
//  Copyright © 2017年 Ziv. All rights reserved.
//

@import Foundation;
@import UIKit;
#import "ZXInteractiveTransition.h"

typedef NS_ENUM(NSUInteger, TransitionAnimationStyle) {
	TransitionAnimationStyleLocker,
	TransitionAnimationStyleCircleSpread
};

@interface ZXAnimationManager : NSObject <ZXInteractiveTransitionDelegate>

- (instancetype)initAnimation:(BOOL)isPush style:(TransitionAnimationStyle)style;
- (CGFloat)zx_animateDuration;
- (void)zx_animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;

@end
