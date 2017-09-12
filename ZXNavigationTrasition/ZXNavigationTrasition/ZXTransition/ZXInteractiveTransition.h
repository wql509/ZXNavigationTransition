//
// InteractiveTransition.h
// test
//
// Created by Ziv on 16/7/13.
// Copyright © 2016年 haibara. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@protocol ZXInteractiveTransitionDelegate <NSObject>

@required
- (void)zx_finished;
- (void)zx_cacelled;

@end

@interface ZXInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL isActive;

@property (nonatomic, weak) id<ZXInteractiveTransitionDelegate> delegate;

- (void)addGestureForViewController:(UIViewController *)viewController;

@end
