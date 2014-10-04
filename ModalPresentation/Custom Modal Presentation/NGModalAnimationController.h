//
//  NGModalAnimationController.h
//  ModalPresentation
//
//  Created by Wojciech Nagrodzki on 04/10/2014.
//
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, NGModalAnimationControllerMode) {
    NGModalAnimationControllerModePresentation,
    NGModalAnimationControllerModeDismissal
};


@interface NGModalAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithMode:(NGModalAnimationControllerMode)mode;

@end
