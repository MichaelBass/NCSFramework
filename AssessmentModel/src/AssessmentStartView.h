//
//  AssessmentStartView.h
//  NCS Admin
//
//  Created by Mike Rose on 10/23/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AssessmentStartViewDelegate;

@interface AssessmentStartView : UIView

@property (weak, nonatomic) id <AssessmentStartViewDelegate> delegate;

@end

@protocol AssessmentStartViewDelegate
@required
- (void)assessmentStartViewDidStart:(BOOL)start;
@end
