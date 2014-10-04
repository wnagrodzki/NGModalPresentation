//
//  NGPresentationViewController.m
//  ModalPresentation
//
//  Created by Wojciech Nagrodzki on 04/10/2014.
//
//

#import "NGPresentationViewController.h"


@interface NGPresentationViewController ()

@property (strong, nonatomic, readonly) UIViewController * containedViewController;

@end


@implementation NGPresentationViewController

#pragma mark - Public Instance Methods

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _containedViewController = presentedViewController;
        [self addChildViewController:presentedViewController];
        [presentedViewController didMoveToParentViewController:self];
    }
    return self;
}

#pragma mark - Overridden

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    UIView * view = self.containedViewController.view;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view];
    
    NSDictionary * views = NSDictionaryOfVariableBindings(view);
    NSDictionary * metrics = @{
                               @"width"  : @(self.containedViewController.preferredContentSize.width),
                               @"height" : @(self.containedViewController.preferredContentSize.height),
                               };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(width)]" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(height)]" options:0 metrics:metrics views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
}

@end
