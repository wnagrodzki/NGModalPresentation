//
//  UIViewController+NGModalPresentation.h
//  ModalPresentation
//
//  Created by Wojciech Nagrodzki on 04/10/2014.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (NGModalPresentation)

/**
  Presents a view controller modally.
  @param viewControllerToPresent The view controller to display over the current view controller’s content.
  @param flag Pass YES to animate the presentation; otherwise, pass NO.
  @param completion The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
 */
- (void)ng_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;

@end
