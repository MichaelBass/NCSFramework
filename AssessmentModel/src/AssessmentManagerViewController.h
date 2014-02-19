//
//  AssessmentManagerViewController.h
//  NCS Admin
//
//  Created by Mike Rose on 10/22/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "Instruments.h"

#import "AssessmentStartView.h"
#import "AssessmentFinishView.h"
//#import "NCSAssessmentAdminLoginViewController.h"

#import "User.h"
#import "Assessment.h"
#import "InstrumentView.h"


@protocol AssessmentManagerViewControllerDelegate;

@interface AssessmentManagerViewController : UIViewController <InstrumentViewDataSource, InstrumentViewDelegate, AssessmentStartViewDelegate, AssessmentFinishViewDelegate>

@property (weak, nonatomic) id <AssessmentManagerViewControllerDelegate> delegate;

//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Assessment *assessment;

- (id)initWithUser:(User *)user andAssessment:(Assessment *)assessment;

- (void)logOut;
- (void)startAssessment;
@end

@protocol AssessmentManagerViewControllerDelegate
@required
- (void)assessmentManagerViewControllerDidFinish:(AssessmentManagerViewController *)viewController;
- (void)assessmentManagerViewControllerUserDidLogOutDuringAssessment:(AssessmentManagerViewController *)viewController;

- (void)assessmentManagerViewControllerUserDidStartInstrument:(Instrument *)instrument;
- (void)assessmentManagerViewControllerUserDidFinishInstrument:(Instrument *)instrument;
- (void)assessmentManagerViewControllerUserDidSaveItem:(Instrument *)instrument itemData:(ItemData *)itemData;
@end

