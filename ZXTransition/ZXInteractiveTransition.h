//
// InteractiveTransition.h
// test
//
// Created by Ziv on 16/7/13.
// Copyright © 2016年 haibara. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ZXInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL isActive;

- (void)addGestureForViewController:(UIViewController *)viewController;

@end
