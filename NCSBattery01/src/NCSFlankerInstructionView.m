//
//  NCSFlankerInstructionView.m
//  NCS Admin
//
//  Created by Mike Rose on 10/30/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "NCSFlankerInstructionView.h"

@implementation NCSFlankerInstructionView

- (UIImage*) getImage: (NSString*) name {
    
    NSBundle *staticBundle =[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Flanker" ofType:@"bundle"]];
    NSString *fileStr2 = [[staticBundle resourcePath] stringByAppendingPathComponent: name ];
    return [UIImage imageWithContentsOfFile: fileStr2 ];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSLayoutConstraint *cnX;
        NSLayoutConstraint *cnY;
        NSLayoutConstraint *cnWidth;
        NSLayoutConstraint *cnHeight;
        
        // image view
        //_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"RightFish.jpg"]];
        _imageView = [[UIImageView alloc] initWithImage:[self getImage:@"RightFish.jpg"]];
        [self addSubview:_imageView];
        
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:160.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:160.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // left label
        _leftLabel = [[UILabel alloc] init];
        //_leftLabel.backgroundColor = [UIColor yellowColor];
        _leftLabel.font = [UIFont boldSystemFontOfSize:26.0];
        _leftLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_leftLabel];
    
        _leftLabel.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_leftLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-25.0];
        cnY = [NSLayoutConstraint constraintWithItem:_leftLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_leftLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:25.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_leftLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // right label
        _rightLabel = [[UILabel alloc] init];
        // _rightLabel.backgroundColor = [UIColor yellowColor];
        _rightLabel.font = [UIFont boldSystemFontOfSize:26.0];
        _rightLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_rightLabel];
        
        _rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_rightLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:25.0];
        cnY = [NSLayoutConstraint constraintWithItem:_rightLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_rightLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-25.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_rightLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_imageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
    }
    return self;
}

@end
