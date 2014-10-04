//
//  ViewController.m
//  ModalPresentation
//
//  Created by Wojciech Nagrodzki on 04/10/2014.
//
//

#import "ViewController.h"
#import "SampleViewController.h"


@interface ViewController () <SampleViewControllerDelegate>

@end


@implementation ViewController

#pragma mark - IBActions

- (IBAction)presentModalViewControllerButtonTapped:(id)sender
{
    SampleViewController * sampleViewController = [[SampleViewController alloc] init];
    sampleViewController.delegate = self;
    [self presentViewController:sampleViewController animated:YES completion:nil];
}

#pragma mark - SampleViewControllerDelegate

- (void)sampleViewControllerRequiredDismiss:(SampleViewController *)sampleViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
