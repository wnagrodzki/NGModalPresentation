//
//  NGModalAnimationController.m
//  ModalPresentation
//
//  Created by Wojciech Nagrodzki on 04/10/2014.
//
//

#import "NGModalAnimationController.h"


static NSTimeInterval const kTransitionDuration = 0.5;


@interface NGModalAnimationController ()

@property (assign, nonatomic, readonly) NGModalAnimationControllerMode mode;

@end


@implementation NGModalAnimationController

#pragma mark - Public Instance Methods

- (instancetype)initWithMode:(NGModalAnimationControllerMode)mode
{
    self = [super init];
    if (self) {
        _mode = mode;
    }
    return self;
}

#pragma mark - Private Instance Methods

- (void)centerView:(UIView *)toView withSize:(CGSize)toViewSize inView:(UIView *)inView
{
    toView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [inView addConstraint:[NSLayoutConstraint constraintWithItem:toView
                                                       attribute:NSLayoutAttributeCenterX
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:inView
                                                       attribute:NSLayoutAttributeCenterX
                                                      multiplier:1
                                                        constant:0]];
    
    [inView addConstraint:[NSLayoutConstraint constraintWithItem:toView
                                                       attribute:NSLayoutAttributeCenterY
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:inView
                                                       attribute:NSLayoutAttributeCenterY
                                                      multiplier:1
                                                        constant:0]];
    
    // iOS 7 applies a transform to presented view controller's view depending on device rotation
    // Thus we need to swap width and height constraints so presented view controler can have a proper size when in landscape
    CGFloat width = toViewSize.width;
    CGFloat height = toViewSize.height;
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
    {
        if (CGAffineTransformEqualToTransform(toView.transform, CGAffineTransformIdentity)           == NO &&
            CGAffineTransformEqualToTransform(toView.transform, CGAffineTransformMakeRotation(M_PI)) == NO)
        {
            width = toViewSize.height;
            height = toViewSize.width;
        }
    }
    
    [inView addConstraint:[NSLayoutConstraint constraintWithItem:toView
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:0
                                                        constant:width]];
    
    [inView addConstraint:[NSLayoutConstraint constraintWithItem:toView
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:0
                                                        constant:height]];
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return kTransitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // get view controllers participating in the transition
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // get views participating in the transition
    UIView * containerView = [transitionContext containerView];
    UIView * fromView;
    UIView * toView;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)
    {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView   = [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    else
    {
        fromView = fromViewController.view;
        toView   = toViewController.view;
    }
    
    // add toView into the view hierarchy when presenting
    if (self.mode == NGModalAnimationControllerModePresentation)
    {
        [containerView addSubview:toView];
        [self centerView:toView withSize:toViewController.preferredContentSize inView:containerView];
    }
    
    // find the presented view controller's view
    UIView * presentedViewControllerView = self.mode == NGModalAnimationControllerModePresentation ? toView : fromView;
    CGFloat initialPresentedViewAlpha    = self.mode == NGModalAnimationControllerModePresentation ? 0 : 1;
    CGFloat finalPresentedViewAAlpha     = self.mode == NGModalAnimationControllerModePresentation ? 1 : 0;

    // animate fade transition
    presentedViewControllerView.alpha = initialPresentedViewAlpha;
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         presentedViewControllerView.alpha = finalPresentedViewAAlpha;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

@end
