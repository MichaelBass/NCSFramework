//
//  TapView.m
//  NCS Admin
//
//  Created by Mike Rose on 11/6/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "TapView.h"
// instrument vars
#define CONFIRM_TOUCH_DURATION      0.75

@interface TapView ()
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UILongPressGestureRecognizer *pressGesture;
@end

@implementation TapView

- (id)init
{
    self = [super init];
    if (self) {
        
        NSLayoutConstraint *cnX;
        NSLayoutConstraint *cnY;
        NSLayoutConstraint *cnWidth;
        NSLayoutConstraint *cnHeight;
        
        // self
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        /*
        _pressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didPress:)];
        _pressGesture.minimumPressDuration = 0;
        [self addGestureRecognizer:_pressGesture];
        */
         
        // button
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _button.titleLabel.font = [UIFont boldSystemFontOfSize:26.0];
        [_button setTitle:@"Touch and hold here to continue" forState:UIControlStateNormal];
        [self addSubview:_button];
        
        [_button addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
        [_button addTarget:self action:@selector(buttonUp:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventTouchCancel|UIControlEventTouchDragOutside];
        
        _button.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:50.0];
        cnY = [NSLayoutConstraint constraintWithItem:_button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-50.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-50.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:50.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
    }
    return self;
}

#pragma mark - timer

- (void)buttonDown:(UIButton *)button
{
    // start timer
    _timer = [NSTimer scheduledTimerWithTimeInterval:CONFIRM_TOUCH_DURATION target:self selector:@selector(timerDidFinish) userInfo:nil repeats:NO];
}

- (void)buttonUp:(UIButton *)button
{
    // stop timer
    [_timer invalidate];
    _timer = nil;
}

- (void)timerDidFinish
{
    [_timer invalidate];
    _timer = nil;
    
    [_delegate tapViewDidReceiveTap:self];
}

- (void)didPress:(UILongPressGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            _button.highlighted = YES;
            break;
        case UIGestureRecognizerStateChanged:
            //
            break;
        case UIGestureRecognizerStateEnded:
            _button.highlighted = NO;
            [_delegate tapViewDidReceiveTap:self];
            break;
        case UIGestureRecognizerStateCancelled:
            //
        case UIGestureRecognizerStateFailed:
            //
        default:
            _button.highlighted = NO;
            break;
    }
}

- (void)dealloc
{
    [self removeGestureRecognizer:_pressGesture];
    _pressGesture = nil;
}

@end
