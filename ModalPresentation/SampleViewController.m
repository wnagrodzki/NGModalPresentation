//
//  SampleViewController.m
//  ModalPresentation
//
//  Created by Wojciech Nagrodzki on 04/10/2014.
//
//

#import "SampleViewController.h"
#import "UIViewController+NGModalPresentation.h"

@interface SampleViewController () <SampleViewControllerDelegate>

@property (strong, nonatomic, readonly) UILabel * label;

@end

@implementation SampleViewController

#pragma mark - Public Properties

- (void)setViewBackgroundColor:(UIColor *)viewBackgroundColor
{
    _viewBackgroundColor = viewBackgroundColor;
    self.view.backgroundColor = viewBackgroundColor;
}

#pragma mark - IBActions

- (void)dismissButtonTapped:(UIButton *)sender
{
    [self.delegate sampleViewControllerRequiredDismiss:self];
}

- (void)presentButtonTapped:(UIButton *)sender
{
    SampleViewController * sampleViewController = [[SampleViewController alloc] init];
    sampleViewController.preferredContentSize = CGSizeMake(self.preferredContentSize.width + 40, self.preferredContentSize.height + 80);
    sampleViewController.viewBackgroundColor = [self colorByDarkeningColor:self.viewBackgroundColor];
    sampleViewController.delegate = self;
    [self ng_presentViewController:sampleViewController animated:YES completion:nil];
}

#pragma mark - Overridden

- (instancetype)init
{
    self = [super init];
    if (self) {
        _viewBackgroundColor = [UIColor colorWithRed:0.9373 green:0.9373 blue:0.9373 alpha:1.0000];
    }
    return self;
}

- (void)loadView
{
    UIView * view = [[UIView alloc] init];
    view.layer.borderColor = [[UIColor blackColor] CGColor];
    view.layer.borderWidth = 1;
    
    _label = [[UILabel alloc] init];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.numberOfLines = 0;
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:_label];
    
    NSDictionary * views = NSDictionaryOfVariableBindings(_label);
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_label]|" options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_label]|" options:0 metrics:nil views:views]];
    
    UIButton * dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismissButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:dismissButton];
    
    views = NSDictionaryOfVariableBindings(dismissButton);
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[dismissButton]-|" options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-32-[dismissButton]" options:0 metrics:nil views:views]];
    
    UIButton * presentButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [presentButton setTitle:@"Present" forState:UIControlStateNormal];
    [presentButton addTarget:self action:@selector(presentButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    presentButton.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:presentButton];
    
    views = NSDictionaryOfVariableBindings(presentButton, _label);
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[presentButton]-|" options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[presentButton]-|" options:0 metrics:nil views:views]];
    
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = self.viewBackgroundColor;
    self.label.text = [NSString stringWithFormat:@"%@\n"
                                                 @"Preferred Content Size: %@", self, NSStringFromCGSize(self.preferredContentSize)];
}

#pragma mark - Private Instance Methods

- (UIColor *)colorByDarkeningColor:(UIColor *)color
{
    CGFloat r, g, b, a;
    if ([color getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r * 0.8, 0.0)
                               green:MAX(g * 0.8, 0.0)
                                blue:MAX(b * 0.8, 0.0)
                               alpha:a];
    return nil;
}

#pragma mark - SampleViewControllerDelegate

- (void)sampleViewControllerRequiredDismiss:(SampleViewController *)sampleViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
