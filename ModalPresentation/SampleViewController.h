//
//  SampleViewController.h
//  ModalPresentation
//
//  Created by Wojciech Nagrodzki on 04/10/2014.
//
//

#import <UIKit/UIKit.h>

@class SampleViewController;


@protocol SampleViewControllerDelegate <NSObject>

- (void)sampleViewControllerRequiredDismiss:(SampleViewController *)sampleViewController;

@end


@interface SampleViewController : UIViewController

@property (strong, nonatomic) UIColor * viewBackgroundColor;
@property (weak, nonatomic) id <SampleViewControllerDelegate> delegate;

@end
