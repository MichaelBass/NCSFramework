//
//  AssessmentFinishView.h
//  NCS Admin
//
//  Created by Mike Rose on 10/23/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AssessmentFinishViewDelegate;

@interface AssessmentFinishView : UIView

@property (weak, nonatomic) id <AssessmentFinishViewDelegate> delegate;

@end

@protocol AssessmentFinishViewDelegate
@required
- (void)assessmentFinishViewDidFinish:(BOOL)finish;
@end
