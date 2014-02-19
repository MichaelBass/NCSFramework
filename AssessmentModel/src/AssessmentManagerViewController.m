//
//  AssessmentManagerViewController.m
//  NCS Admin
//
//  Created by Mike Rose on 10/22/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "AssessmentManagerViewController.h"

#import "Item.h"
#import "ItemData.h"
#import "Instrument.h"
#import "InstrumentView.h"
#import "Engine.h"
#import "Parser.h"

@interface AssessmentManagerViewController ()

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) AssessmentStartView *startView;
@property (strong, nonatomic) AssessmentFinishView *finishView;
//@property (strong, nonatomic) NCSAssessmentAdminLoginViewController *adminViewController;

@property (strong, nonatomic) UIRotationGestureRecognizer *rotationGesturesRecognizer;

@property (strong, nonatomic) NSArray *instruments;
@property (strong, nonatomic) NSMutableArray *instrumentViews;

@property (nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) UIView *currentView;

@end

@implementation AssessmentManagerViewController

- (id)initWithUser:(User *)user andAssessment:(Assessment *)assessment
{
    self = [super init];
    if (self) {
        
        _user = user;
        _assessment = assessment;
        
        // set the current admin giving the assessment
        //_assessment.admin = APP_DELEGATE.currentAdmin;
        
        // instruments (data)
        NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES]];
        _instruments = [_assessment.instruments sortedArrayUsingDescriptors:sortDescriptors];
        
        _currentIndex = -1; // allows current index to be set to 0
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLayoutConstraint *cnX;
    NSLayoutConstraint *cnY;
    NSLayoutConstraint *cnWidth;
    NSLayoutConstraint *cnHeight;
    
    // self
    self.view.backgroundColor = [UIColor blackColor];
    
    // content view
    _contentView = [[UIView alloc] init];
    [self.view addSubview:_contentView];
    
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    cnX = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    cnY = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    cnWidth = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:.95 constant:0];
    cnHeight = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:.95 constant:0];
    [self.view addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
    
    // start view
    _startView = [[AssessmentStartView alloc] init];
    _startView.delegate = self;
    [_contentView addSubview:_startView];
    
    _startView.translatesAutoresizingMaskIntoConstraints = NO;
    cnX = [NSLayoutConstraint constraintWithItem:_startView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    cnY = [NSLayoutConstraint constraintWithItem:_startView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    cnWidth = [NSLayoutConstraint constraintWithItem:_startView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    cnHeight = [NSLayoutConstraint constraintWithItem:_startView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self.view addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
 
    
    // finish view

    _finishView = [[AssessmentFinishView alloc] init];
    _finishView.delegate = self;
    _finishView.hidden = YES;
    [_contentView addSubview:_finishView];
    
    _finishView.translatesAutoresizingMaskIntoConstraints = NO;
    cnX = [NSLayoutConstraint constraintWithItem:_finishView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    cnY = [NSLayoutConstraint constraintWithItem:_finishView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    cnWidth = [NSLayoutConstraint constraintWithItem:_finishView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    cnHeight = [NSLayoutConstraint constraintWithItem:_finishView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self.view addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
 
    
    // admin view
    /*
    _adminViewController = [[NCSAssessmentAdminLoginViewController alloc] init];
    _adminViewController.delegate = self;
    _adminViewController.view.hidden = YES;
    
    [self addChildViewController:_adminViewController];
    [_contentView addSubview:_adminViewController.view];
    [_adminViewController didMoveToParentViewController:self];
    
    _adminViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    cnX = [NSLayoutConstraint constraintWithItem:_adminViewController.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    cnY = [NSLayoutConstraint constraintWithItem:_adminViewController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    cnWidth = [NSLayoutConstraint constraintWithItem:_adminViewController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    cnHeight = [NSLayoutConstraint constraintWithItem:_adminViewController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self.view addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

#pragma mark - admin managemnt

- (void)didRotate:(UIRotationGestureRecognizer *)gr
{
    switch (gr.state) {
        case UIGestureRecognizerStateChanged: {
            if (gr.rotation > 1.25 || gr.rotation < -1.25) {
                //[self showAdmin];
            }
            break;
        }
        default: {
            //
            break;
        }
    }
}

/*
- (void)showAdmin
{
    _rotationGesturesRecognizer.enabled = NO;
    
    NSString *instrumentTitle;
    if ([_currentView isKindOfClass:[NCSInstrumentView class]]) {
        NCSInstrumentView *instrumentView = (NCSInstrumentView *)_currentView;
        instrumentTitle = instrumentView.instrumentTitle;
    } else {
        instrumentTitle = @"NCS Administration";
    }
    _adminViewController.titleLabel.text = [NSString stringWithFormat:@"%@", instrumentTitle];
    
    // admin wants to pause/cancel the assessment
    [UIView transitionWithView:_contentView duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        _currentView.hidden = YES;
        _adminViewController.view.hidden = NO;
    } completion:^(BOOL finished) {
        [_adminViewController showKeyboard];
    }];
}
*/
#pragma mark - instrument management

- (void)startAssessment
{
    int startingPoint = 0;
    
    // init all instrument views
    _instrumentViews = [[NSMutableArray alloc] initWithCapacity:_instruments.count];
    for (Instrument *instrument in _instruments) {

        // create the instrument view
        [_instrumentViews addObject:[self createInstrumentView:instrument]];
        
        // skip the instrument if it's already finished
        if (instrument.dateFinishedString.length > 0) {
            startingPoint +=1;
        }
    }
    
    // move finish view the top of the stack
    [_contentView insertSubview:_finishView atIndex:_contentView.subviews.count-1];
    
    // add rotation gesture recognizer
    _rotationGesturesRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(didRotate:)];
    [self.view addGestureRecognizer:_rotationGesturesRecognizer];
     
    self.currentIndex = startingPoint;
}

- (void)stopAssessment
{
    // remove rotation gesture recognizer
    [self.view removeGestureRecognizer:_rotationGesturesRecognizer];
    _rotationGesturesRecognizer = nil;
    
    [_delegate assessmentManagerViewControllerDidFinish:self];
}

- (void)logOut
{
    // remove rotation gesture recognizer
    [self.view removeGestureRecognizer:_rotationGesturesRecognizer];
    _rotationGesturesRecognizer = nil;
     
    [_delegate assessmentManagerViewControllerUserDidLogOutDuringAssessment:self];
}

- (NSMutableArray *)mergeSavedDataIntoItemList:(NSMutableArray *)itemList
{
    NSMutableArray* rtn = itemList;
    Instrument *instrument = _instruments[_currentIndex];
    
    for (ItemData* itemData in rtn) {
        for (Item *item in instrument.items) {
            if([item.formItemOID isEqualToString:itemData.FormItemOID]) {
                itemData.ItemDataOID = item.itemDataOID;
                itemData.ItemResponseOID = item.itemResponseOID;
                itemData.ResponseTime = [item.responseTime stringValue];
                itemData.Position = [item.position stringValue];
                itemData.Response = item.response;
            }
        }
    }
    
    return rtn;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex == _currentIndex) return;
    _currentIndex = currentIndex;
    
    if (_currentIndex < 0) {
        _currentIndex = 0;
    } else if (_currentIndex > _instruments.count) {
        _currentIndex = _instruments.count ;
    }
    
    [self loadViewAtIndex:_currentIndex];
}

- (void)loadViewAtIndex:(NSInteger)index
{
    // from view
    UIView *fromView;
    
    
    if (index == 0) {
        fromView = _startView;
    } else {
        fromView = _instrumentViews[index-1]; 
    }
    
    // to view
    UIView *toView;
    if (_currentIndex == _instruments.count) {
        toView = _finishView;
    } else {
        toView = _instrumentViews[index];
    }
    
    _currentView = toView;
    
    // FIXME: hack to smooth out the transition from picture vocab practice > picture vocab
    NSInteger transition =  UIViewAnimationOptionTransitionCurlUp;
    NSTimeInterval duration = 1.0;
    
    /*
    if ([fromView isKindOfClass:[NCSPictureVocabularyPracticeInstrumentView class]]) {
        transition = UIViewAnimationOptionTransitionNone;
        duration = 0;
    }
    */
    
    [UIView transitionWithView:_contentView duration:duration options:transition animations:^{
        fromView.hidden = YES;
        toView.hidden = NO;
    } completion:^(BOOL finished) {
        
        // if the to view is an instrument view, start the instrument
        if ([toView isKindOfClass:[InstrumentView class]]) {
            InstrumentView *instrumentView = (InstrumentView *)toView;
            [instrumentView start];
        }
        
    }];
    
}

- (InstrumentView *)createInstrumentView:(Instrument *)instrument
{
    NSLayoutConstraint *cnX;
    NSLayoutConstraint *cnY;
    NSLayoutConstraint *cnWidth;
    NSLayoutConstraint *cnHeight;
    
    InstrumentView *instrumentView;
    
    instrumentView = [[NSClassFromString(instrument.view) alloc] init];
    /*
    switch (instrument.type.integerValue) {
        case NCSInstrumentTypeDCCS: {
            NCSDCCSInstrumentView *dccsInstrumentView = [[NCSDCCSInstrumentView alloc] init];
            dccsInstrumentView.playRepetitiveSounds = (_user.age.integerValue > 11) ? NO : YES;
            instrumentView = dccsInstrumentView;
            break;
        }
        case NCSInstrumentTypeFlanker: {
            NCSFlankerInstrumentView *flankerInstrumentView = [[NCSFlankerInstrumentView alloc] init];
            flankerInstrumentView.playRepetitiveSounds = (_user.age.integerValue > 11) ? NO : YES;
            instrumentView = flankerInstrumentView;
            break;
        }
        case NCSInstrumentTypePSM: {
            NCSPSMInstrumentView *psmInstrumentView = [[NCSPSMInstrumentView alloc] init];
            instrumentView = psmInstrumentView;
            break;
        }
        case NCSInstrumentTypePictureVocab: {
            NCSPictureVocabularyInstrumentView *vocabInstrumentView = [[NCSPictureVocabularyInstrumentView alloc] init];
            instrumentView = vocabInstrumentView;
            break;
        }
        case NCSInstrumentTypePictureVocabPractice: {
            NCSPictureVocabularyPracticeInstrumentView *vocabPracticeInstrumentView = [[NCSPictureVocabularyPracticeInstrumentView alloc] init];
            instrumentView = vocabPracticeInstrumentView;
            break;
        }
    }
    */
    instrumentView.dataSource = self;
    instrumentView.delegate = self;
    //instrumentView.type = instrument.type.integerValue;
    instrumentView.tag = instrument.index.integerValue;
    instrumentView.hidden = YES;
    [_contentView addSubview:instrumentView];
    
    instrumentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    cnX = [NSLayoutConstraint constraintWithItem:instrumentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    cnY = [NSLayoutConstraint constraintWithItem:instrumentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    cnWidth = [NSLayoutConstraint constraintWithItem:instrumentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    cnHeight = [NSLayoutConstraint constraintWithItem:instrumentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
    
    return instrumentView;
}

#pragma mark - assessment start view delegate

- (void)assessmentStartViewDidStart:(BOOL)start
{
    if (start) {
        [self startAssessment];
    } else {
        [self stopAssessment];
    }
}

#pragma mark - assessment finish view delegate

- (void)assessmentFinishViewDidFinish:(BOOL)finish
{
    [self stopAssessment];
}

#pragma mark - assessment admin delegate

- (void)assessmentAdminDidResumeInstrument
{
    [UIView transitionWithView:_contentView duration:1.0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        _currentView.hidden = NO;
       // _adminViewController.view.hidden = YES;
    } completion:^(BOOL finished) {
        _rotationGesturesRecognizer.enabled = YES;
    }];
}

- (void)assessmentAdminDidSkipInstrument
{
    _rotationGesturesRecognizer.enabled = YES;
    
    NSInteger index = _currentView.tag;
    
    // FIXME: hack to skip picture vocab if they're skipping picture vocab practice
    //if ([_currentView isKindOfClass:[NCSPictureVocabularyPracticeInstrumentView class]]) {
    //    self.currentIndex = index + 2;
    //} else {
        self.currentIndex = index + 1;
    //}
}

- (void)assessmentAdminDidStopAssessment
{
    _rotationGesturesRecognizer.enabled = YES;
    
    self.currentIndex = _instruments.count;
}

#pragma mark - instrument view data source


- (id<Engine>)engineForInstrumentView:(InstrumentView *)instrumentView
{
    
    id<Parser> myParser = [[NSClassFromString(instrumentView.parserName) alloc] init];

    
    NSMutableDictionary *paramList = [[NSMutableDictionary alloc] init];
    [myParser loadData:nil params:paramList];
    
    id myEngine = [[NSClassFromString(instrumentView.engineName) alloc] initwithParameterDictionary:paramList];
    
    [((id<Engine>)myEngine) setUser:_user];
    
    NSMutableArray* myFiles =  [NSClassFromString(instrumentView.parserName) parseFormFile];
    
    ((id<Engine>)myEngine).ItemList = [self mergeSavedDataIntoItemList:myFiles];
    
    return myEngine;

}
/*
- (id<Engine>)engineForInstrumentView:(NCSInstrumentView *)instrumentView
{
    id <Engine> engine;
    switch (instrumentView.type) {
        case NCSInstrumentTypeDCCS: {
            
            DCCSDataParser *parser = [[DCCSDataParser alloc] init];
            NSMutableDictionary *paramList = [[NSMutableDictionary alloc] init];
            [parser loadData:nil params:paramList];
             
            ProgressiveSectionalEngine *progressiveSectionalEngine = [[ProgressiveSectionalEngine alloc] initwithParameterDictionary:paramList];
            progressiveSectionalEngine.user = _user;
            
            progressiveSectionalEngine.ItemList = [self mergeSavedDataIntoItemList:[DCCSDataParser parseFormFile]];
            engine = progressiveSectionalEngine;
            
            break;
            
        }
        case NCSInstrumentTypeFlanker: {
        
            FlankerDataParser *parser = [[FlankerDataParser alloc] init];
            NSMutableDictionary *paramList = [[NSMutableDictionary alloc] init];
            [parser loadData:nil params:paramList];
                    
            ProgressiveSectionalEngine *progressiveSectionalEngine = [[ProgressiveSectionalEngine alloc] initwithParameterDictionary:paramList];
            progressiveSectionalEngine.user = _user;
            
            progressiveSectionalEngine.ItemList =  [self mergeSavedDataIntoItemList:[FlankerDataParser parseFormFile]];
            engine = progressiveSectionalEngine;
            
            break;
            
        }
        case NCSInstrumentTypePSM: {
            IBAMParser2 *parser = [[IBAMParser2 alloc] init];
            NSMutableDictionary *paramList = [[NSMutableDictionary alloc] init];
            [parser loadData:nil params:paramList];
            
            ProgressiveSectionalEngine2 *progressiveSectionalEngine = [[ProgressiveSectionalEngine2 alloc] initwithParameterDictionary:paramList];
            progressiveSectionalEngine.user = _user;
            
            progressiveSectionalEngine.ItemList = [self mergeSavedDataIntoItemList:[IBAMParser2 parseFormFile]];
            engine = progressiveSectionalEngine;
            
            break;
            
        }
        case NCSInstrumentTypePictureVocab: {
            
            VocabParser* parser = [[VocabParser alloc] init];
            NSMutableDictionary* paramList = [[NSMutableDictionary alloc] init];
            [parser loadData:nil params:paramList];
            
            DichotomousEngine *dichotomousEngine = [[DichotomousEngine alloc] initwithParameterDictionary:paramList];
            dichotomousEngine.user = _user;
       
            dichotomousEngine.ItemList = [self mergeSavedDataIntoItemList:[VocabParser parseFormFile]];
            engine = dichotomousEngine;
            
            break;
            
        }
        case NCSInstrumentTypePictureVocabPractice: {
            
            PracticeVocabParser* parser = [[PracticeVocabParser alloc] init];
            NSMutableDictionary* paramList = [[NSMutableDictionary alloc] init];
            [parser loadData:nil params:paramList];
            
            SequenceEngine *sequenceEngine = [[SequenceEngine alloc] initwithParameterDictionary:paramList];
            sequenceEngine.user = _user;
            
            sequenceEngine.ItemList = [self mergeSavedDataIntoItemList:[PracticeVocabParser parseFormFile]];;
            engine = sequenceEngine;
            
            break;
            
        }
    }
    return engine;
}
*/
#pragma mark - instrument view delegate

- (void)instrumentView:(InstrumentView *)instrumentView didStart:(BOOL)start
{
    if (start) {
        
        Instrument *instrument = _instruments[_currentIndex];
        
        if (!instrument.dateStarted) {
            instrument.dateStarted = [NSDate date];
        }
        // save to core data
        [self.delegate assessmentManagerViewControllerUserDidStartInstrument:instrument];
    }
    

    /*
    NSError *error;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
     */
    
}

- (void)instrumentView:(InstrumentView *)instrumentView didFinish:(BOOL)finish
{
    NSInteger index = instrumentView.tag;
    
    if (finish) {
        
        Instrument *instrument = _instruments[_currentIndex];
        
        if (!instrument.dateFinished) {
            instrument.dateFinished = [NSDate date];
        }
        
        // calculate the instrument score
        instrument.score = [instrumentView calculateScoreForInstrument:instrument withUser:_user];
        
        // get the next intrument
        index = index + 1;
        
       [self.delegate assessmentManagerViewControllerUserDidFinishInstrument:instrument];
    
    } else {
        
        // admin canceled instrument
        index = _instruments.count;
        
    }
    
    // save to core data
    /*
    NSError *error;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    */
    self.currentIndex = index;
}

- (void)instrumentView:(InstrumentView *)instrumentView didSendResponses:(NSArray *)responses withResponseTime:(NSTimeInterval)responseTime
{
    
    NSArray *sectionData = [instrumentView.engine processResponses:responses responsetime:responseTime];

    Instrument *instrument = _instruments[_currentIndex];

    for (ItemData *itemData in sectionData) {
        [self.delegate assessmentManagerViewControllerUserDidSaveItem:instrument itemData:itemData];
        //[self addItemData:itemData toInstrument:instrument];
    }
    
    // save to core data
    /*
    NSError *error;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    */
    [instrumentView nextItem];
}

- (void)addItemData:(ItemData *)itemData toInstrument:(Instrument *)instrument
{
    /*
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"NCSItem" inManagedObjectContext:_managedObjectContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"formItemOID == %@ AND instrument.uuid == %@", itemData.FormItemOID, instrument.uuid];
    
    NSError *error;
    NSArray *results = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NCSItem *item;
    
    if (results.count) {
        // edit existing item
        item = results[0];
    } else {
        // create new item
        item = [NSEntityDescription insertNewObjectForEntityForName:@"NCSItem" inManagedObjectContext:_managedObjectContext];
        item.dateCreated = [NSDate date];
    }
    
    item.formItemOID = itemData.FormItemOID;
    item.itemDataOID = itemData.ItemDataOID;
    item.itemResponseOID = itemData.ItemResponseOID;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    item.position = [numberFormatter numberFromString:itemData.Position];
    item.response = itemData.Response;
    item.responseTime = [numberFormatter numberFromString:itemData.ResponseTime];
    
    // add item to the instrument
    [instrument addItemsObject:item];
     */
}

@end
