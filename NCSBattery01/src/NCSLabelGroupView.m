//
//  NCSLabelGroupView.m
//  NCS Admin
//
//  Created by Mike Rose on 10/30/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "NCSLabelGroupView.h"

@interface NCSLabelGroupView ()

@end

@implementation NCSLabelGroupView

- (id)initWithTextColor:(UIColor *)textColor
{
    self = [super init];
    if (self) {
        
        NSLayoutConstraint *cnX;
        NSLayoutConstraint *cnY;
        NSLayoutConstraint *cnWidth;
        NSLayoutConstraint *cnHeight;
        
        _textColor = textColor;
        
        // labels
        _label1 = [self createLabel];
        [self addSubview:_label1];
        
        cnX = [NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_label1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.2 constant:0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        _label2 = [self createLabel];
        [self addSubview:_label2];
        
        cnX = [NSLayoutConstraint constraintWithItem:_label2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_label2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_label1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_label2 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_label2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.2 constant:0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        _label3 = [self createLabel];
        [self addSubview:_label3];
        
        cnX = [NSLayoutConstraint constraintWithItem:_label3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_label3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_label2 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_label3 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_label3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.2 constant:0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        _label4 = [self createLabel];
        [self addSubview:_label4];
        
        cnX = [NSLayoutConstraint constraintWithItem:_label4 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_label4 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_label3 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_label4 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_label4 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.2 constant:0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        _label5 = [self createLabel];
        [self addSubview:_label5];
        
        cnX = [NSLayoutConstraint constraintWithItem:_label5 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_label5 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_label4 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_label5 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_label5 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.2 constant:0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // image view
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageViewCnX = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_label2 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_label2 attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-3.0];
        [self addConstraints:@[ _imageViewCnX, cnY ]];
         
    }
    return self;
}

- (UILabel *)createLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:26.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textColor = _textColor;
    
    return label;
}

@end
