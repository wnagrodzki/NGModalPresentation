//
//  SampleViewController.m
//  ModalPresentation
//
//  Created by Wojciech Nagrodzki on 04/10/2014.
//
//

#import "SampleViewController.h"

@interface SampleViewController ()

@property (strong, nonatomic, readonly) UILabel * label;

@end

@implementation SampleViewController

#pragma mark - Public Properties

- (void)setViewBackgroundColor:(UIColor *)viewBackgroundColor
{
    _viewBackgroundColor = viewBackgroundColor;
    self.view.backgroundColor = viewBackgroundColor;
}

#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods
#pragma mark - IBActions

- (void)dismissButtonTapped:(UIButton *)sender
{
    [self.delegate sampleViewControllerRequiredDismiss:self];
}

#pragma mark - Overridden

- (instancetype)init
{
    self = [super init];
    if (self) {
        _viewBackgroundColor = [UIColor colorWithRed:0.1882 green:0.6431 blue:0.8667 alpha:1.0000];
    }
    return self;
}

- (void)loadView
{
    UIView * view = [[UIView alloc] init];
    
    _label = [[UILabel alloc] init];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.numberOfLines = 0;
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:_label];
    
    NSDictionary * views = NSDictionaryOfVariableBindings(_label);
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_label]|" options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_label]|" options:0 metrics:nil views:views]];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:button];
    
    views = NSDictionaryOfVariableBindings(button);
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button]-|" options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-32-[button]" options:0 metrics:nil views:views]];
    
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = self.viewBackgroundColor;
    self.label.text = [NSString stringWithFormat:@"Sample View Controller\n"
                                                 @"Preferred Content Size: %@", NSStringFromCGSize(self.preferredContentSize)];
}

#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods
#pragma mark - Protocols
#pragma mark - Notifications

@end
