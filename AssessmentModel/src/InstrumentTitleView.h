//
//  InstrumentTitleView.h
//  NCS Admin
//
//  Created by Mike Rose on 12/20/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TapView.h"

@interface InstrumentTitleView : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) TapView *tapView;

@end
