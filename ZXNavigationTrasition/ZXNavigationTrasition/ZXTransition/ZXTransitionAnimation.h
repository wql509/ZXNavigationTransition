//
// Transition.h
// test
//
// Created by Ziv on 16/7/13.
// Copyright © 2016年 haibara. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
#import "ZXInteractiveTransition.h"

typedef NS_ENUM(NSUInteger, TransitionAnimationStyle) {
	TransitionAnimationStyleLocker,
	TransitionAnimationStyleCircleSpread
};

@interface ZXTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning, ZXInteractiveTransitionDelegate>
- (instancetype)initTransition:(BOOL)isPush animationStyle:(TransitionAnimationStyle)style;
@end
