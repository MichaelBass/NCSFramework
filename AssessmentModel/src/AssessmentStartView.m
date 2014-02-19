//
//  NCSAssessmentStartView.m
//  NCS Admin
//
//  Created by Mike Rose on 10/23/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "AssessmentStartView.h"

@interface AssessmentStartView ()
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *startButton;
@property (strong, nonatomic) UILabel *dispayInstructions;
@end

@implementation AssessmentStartView

- (id)init
{
    self = [super init];
    if (self) {
        
        NSLayoutConstraint *cnX;
        NSLayoutConstraint *cnY;
        NSLayoutConstraint *cnWidth;
        NSLayoutConstraint *cnHeight;
        
        // self
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        // self.layer.cornerRadius = 10.0;
        
        // cancel button
        _cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _cancelButton.backgroundColor = self.tintColor;
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        _cancelButton.layer.cornerRadius = 6.0;
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(didCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelButton];
        
        _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_cancelButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-30.0];
        cnY = [NSLayoutConstraint constraintWithItem:_cancelButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:100.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_cancelButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:60.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_cancelButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:60.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // start button
        _startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _startButton.backgroundColor = self.tintColor;
        _startButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        _startButton.layer.cornerRadius = 6.0;
        [_startButton setTitle:@"Start" forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_startButton addTarget:self action:@selector(didStart:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_startButton];
        
        _startButton.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_startButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:30.0];
        cnY = [NSLayoutConstraint constraintWithItem:_startButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:100.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_startButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-60.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_startButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:60.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // instruction label
        _dispayInstructions = [[UILabel alloc] init];
        _dispayInstructions.font = [UIFont systemFontOfSize:26.0];
        _dispayInstructions.textAlignment = NSTextAlignmentCenter;
        _dispayInstructions.lineBreakMode = NSLineBreakByWordWrapping;
        _dispayInstructions.numberOfLines = 0;
        _dispayInstructions.text = @"Assessment will now begin, please select the Start button and hand the iPad to the participant.";
        [self addSubview:_dispayInstructions];
        
        _dispayInstructions.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_dispayInstructions attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
        cnY = [NSLayoutConstraint constraintWithItem:_dispayInstructions attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_dispayInstructions attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-240.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_dispayInstructions attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_startButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:-20.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
    }
    return self;
}

- (void)didCancel:(id)sender
{
    [_delegate assessmentStartViewDidStart:NO];
}

- (void)didStart:(id)sender
{
    [_delegate assessmentStartViewDidStart:YES];
}

@end
