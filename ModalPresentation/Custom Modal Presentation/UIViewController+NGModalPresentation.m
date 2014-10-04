//
//  UIViewController+NGModalPresentation.m
//  ModalPresentation
//
//  Created by Wojciech Nagrodzki on 04/10/2014.
//
//

#import "UIViewController+NGModalPresentation.h"
#import "NGModalTransitioningDelegate.h"
#import <objc/runtime.h>


static void * const kTransitioningDelegateKey = (void *)&kTransitioningDelegateKey;


@implementation UIViewController (NGModalPresentation)

- (void)ng_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationCustom;
    viewControllerToPresent.transitioningDelegate = [self ng_modalTransitioningDelegate];
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (NGModalTransitioningDelegate *)ng_modalTransitioningDelegate
{
    NGModalTransitioningDelegate *delegate = objc_getAssociatedObject(self, kTransitioningDelegateKey);
    if (delegate == nil)
    {
        delegate = [[NGModalTransitioningDelegate alloc] init];
        objc_setAssociatedObject(self, kTransitioningDelegateKey, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}


@end
