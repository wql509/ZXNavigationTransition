//
// Transition.h
// test
//
// Created by Ziv on 16/7/13.
// Copyright © 2016年 haibara. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
#import "ZXAnimationManager.h"

@interface ZXTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, weak, readonly) id<ZXInteractiveTransitionDelegate> delegate;

- (instancetype)initTransition:(BOOL)isPush animationStyle:(TransitionAnimationStyle)style;
@end
