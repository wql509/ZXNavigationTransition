//
// Transition.h
// test
//
// Created by Ziv on 16/7/13.
// Copyright © 2016年 haibara. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ZXTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
- (instancetype)initTransition:(BOOL)isPush;
@end
