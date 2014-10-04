//
//  NGModalAnimationController.m
//  ModalPresentation
//
//  Created by Wojciech Nagrodzki on 04/10/2014.
//
//

#import "NGModalAnimationController.h"


static NSTimeInterval const kTransitionDuration = 2;


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
        // using constraints instead coused a bug during device rotation on iOS 7
        toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        toView.frame = containerView.bounds;
        [containerView addSubview:toView];
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
