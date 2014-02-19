//
//  TapView.h
//  NCS Admin
//
//  Created by Mike Rose on 11/6/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TapViewDelegate;

@interface TapView : UIView

@property (weak, nonatomic) id <TapViewDelegate> delegate;

@property (strong, nonatomic) UIButton *button;

@end

@protocol TapViewDelegate
@optional
- (void)tapViewDidReceiveTap:(TapView *)tapView;
@end
