//
//  NCSFlankerImageGroupView.m
//  NCS Admin
//
//  Created by Mike Rose on 10/28/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "NCSFlankerImageGroupView.h"

#define IMAGE_ANIMATION_TIME    0.3
#define IMAGE_DELAY_TIME        0.1

@interface NCSFlankerImageGroupView ()
@property (strong, nonatomic) NSArray *imageViews;
@end

@implementation NCSFlankerImageGroupView

- (id)initWithImageViewCount:(NSInteger)count
{
    self = [super init];
    if (self) {
        
        NSLayoutConstraint *cnX;
        NSLayoutConstraint *cnY;
        NSLayoutConstraint *cnWidth;
        NSLayoutConstraint *cnHeight;
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:count];
        for (NSInteger i = 0; i < count; i++) {
            UIImageView *imageView = [self createImageView];
            imageView.tag = i;

            if (i > 0) {
                UIView *previousView = array[i - 1];
                cnX = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:previousView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
            } else {
                cnX = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
            }
            cnY = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
            cnWidth = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0/count constant:0];
            cnHeight = [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
            [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
            
            [array addObject:imageView];
        }
        
        _imageViews = array;
    }
    return self;
}

- (void)clearImages
{
    for (UIImageView *imageView in _imageViews) {
        imageView.image = nil;
    }
}

- (void)setImages:(NSArray *)images
{
    if (images.count != _imageViews.count) return;
    _images = images;
    
    for (NSInteger i = 0; i < _imageViews.count; i++) {
        
        UIImage *image = _images[i];
        
        UIImageView *imageView = _imageViews[i];
        imageView.alpha = 0;
        imageView.image = image;
        
        NSTimeInterval delay = (i == 2) ? IMAGE_DELAY_TIME : 0;
        [UIView animateWithDuration:IMAGE_ANIMATION_TIME delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
            imageView.alpha = 1.0;
        } completion:^(BOOL finished) {
            //
        }];
    }
}

- (UIImageView *)createImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    // imageView.backgroundColor = [UIColor yellowColor];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:imageView];
    
    return imageView;
}

@end
