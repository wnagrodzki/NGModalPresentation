//
//  NGModalTransitioningDelegate.m
//  ModalPresentation
//
//  Created by Wojciech Nagrodzki on 04/10/2014.
//
//

#import "NGModalTransitioningDelegate.h"
#import "NGModalAnimationController.h"

@implementation NGModalTransitioningDelegate

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source
{
    return [[NGModalAnimationController alloc] initWithMode:NGModalAnimationControllerModePresentation];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[NGModalAnimationController alloc] initWithMode:NGModalAnimationControllerModeDismissal];
}

@end
