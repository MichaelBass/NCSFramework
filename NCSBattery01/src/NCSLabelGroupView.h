//
//  NCSLabelGroupView.h
//  NCS Admin
//
//  Created by Mike Rose on 10/30/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCSLabelGroupView : UIView

@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;
@property (strong, nonatomic) UILabel *label3;
@property (strong, nonatomic) UILabel *label4;
@property (strong, nonatomic) UILabel *label5;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSLayoutConstraint *imageViewCnX;

@property (strong, nonatomic) UIColor *textColor;

- (id)initWithTextColor:(UIColor *)color;

@end
