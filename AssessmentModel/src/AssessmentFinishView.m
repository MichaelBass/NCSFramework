//
//  AssessmentFinishView.m
//  NCS Admin
//
//  Created by Mike Rose on 10/23/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "AssessmentFinishView.h"

@interface AssessmentFinishView ()
@property (strong, nonatomic) UIButton *finishButton;
@property (strong, nonatomic) UILabel *dispayInstructions;
@end

@implementation AssessmentFinishView

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
        
        // finish button
        _finishButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _finishButton.backgroundColor = self.tintColor;
        _finishButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        _finishButton.layer.cornerRadius = 6.0;
        [_finishButton setTitle:@"Finish" forState:UIControlStateNormal];
        [_finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_finishButton addTarget:self action:@selector(didFinish:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_finishButton];
        
        _finishButton.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_finishButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
        cnY = [NSLayoutConstraint constraintWithItem:_finishButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:100.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_finishButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.5 constant:-90.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_finishButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:60.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // instruction label
        _dispayInstructions = [[UILabel alloc] init];
        _dispayInstructions.font = [UIFont systemFontOfSize:26.0];
        _dispayInstructions.textAlignment = NSTextAlignmentCenter;
        _dispayInstructions.lineBreakMode = NSLineBreakByWordWrapping;
        _dispayInstructions.numberOfLines = 0;
        _dispayInstructions.text = @"Thank you for participating.";
        [self addSubview:_dispayInstructions];
        
        _dispayInstructions.translatesAutoresizingMaskIntoConstraints = NO;
        _dispayInstructions.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_dispayInstructions attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
        cnY = [NSLayoutConstraint constraintWithItem:_dispayInstructions attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_dispayInstructions attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-240.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_dispayInstructions attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_finishButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:-20.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
    }
    return self;
}

- (void)didFinish:(id)sender
{
    [_delegate assessmentFinishViewDidFinish:YES];
}

@end
