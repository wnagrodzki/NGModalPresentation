//
//  ViewController.m
//  ModalPresentation
//
//  Created by Wojciech Nagrodzki on 04/10/2014.
//
//

#import "ViewController.h"
#import "SampleViewController.h"
#import "UIViewController+NGModalPresentation.h"


@interface ViewController () <SampleViewControllerDelegate>

@end


@implementation ViewController

#pragma mark - IBActions

- (IBAction)presentModalViewControllerButtonTapped:(id)sender
{
    SampleViewController * sampleViewController = [[SampleViewController alloc] init];
    sampleViewController.preferredContentSize = CGSizeMake(320, 640);
    sampleViewController.delegate = self;
    [self ng_presentViewController:sampleViewController animated:YES completion:nil];
}

#pragma mark - SampleViewControllerDelegate

- (void)sampleViewControllerRequiredDismiss:(SampleViewController *)sampleViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
