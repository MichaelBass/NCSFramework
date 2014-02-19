//
//  InstrumentView.h
//  NCS Admin
//
//  Created by Mike Rose on 10/23/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "Engine.h"
#import "Instrument.h"
#import "Item.h"
#import "User.h"
#import "InstrumentTitleView.h"

// element type
static NSString *NCSElemenTypeStem = @"Stem";
static NSString *NCSElemenTypeContext = @"Context";
static NSString *NCSElemenTypeResponseSet = @"ResponseSet";
static NSString *NCSElemenTypeLabel = @"Label";

// resource type
static NSString *NCSResourceText = @"txt";
static NSString *NCSResourceImage = @"img";
static NSString *NCSResourceSound = @"snd";

@protocol InstrumentViewDataSource;
@protocol InstrumentViewDelegate;

@interface InstrumentView : UIView <AVAudioPlayerDelegate, TapViewDelegate>

@property (weak, nonatomic) id <InstrumentViewDataSource> dataSource;
@property (weak, nonatomic) id <InstrumentViewDelegate> delegate;

@property (strong, nonatomic) id <Engine> engine;
@property (nonatomic) NSInteger type;

@property (strong, nonatomic) NSString *engineName;
@property (strong, nonatomic) NSString *parserName;


@property (strong, nonatomic) NSArray *currentSection;
@property (strong, nonatomic) ItemData *currentItem;

@property (strong, nonatomic) NSMutableArray *text;
@property (strong, nonatomic) NSMutableArray *images;
@property (strong, nonatomic) NSMutableArray *sounds;

@property (strong, nonatomic) NSString *instrumentTitle;
@property (strong, nonatomic) InstrumentTitleView *instrumentTitleView;
@property (nonatomic) BOOL isInstruction;
@property (nonatomic) BOOL isPractice;
@property (nonatomic) BOOL playRepetitiveSounds;

-(NSString*) getText:(NSString*) key resource:(NSString*) resource;
- (void)start;

- (void)resetUI;
- (void)nextItem;
- (void)previousItem;
- (void)displaySection:(NSArray *)section;
- (void)displayItem:(ItemData *)item;

- (void)startTimeout;
- (void)stopTimeout;
- (void)didTimeout;

- (void)startResponseTime;
- (void)stopResponseTime;
- (void)sendResponse:(NSInteger)response;
- (void)sendResponseAsNumber:(NSNumber *)response;
- (void)sendResponses:(NSArray *)responses;
- (NSNumber *)calculateScoreForInstrument:(Instrument *)instrument withUser:(User *)user;

- (void)playSound:(NSString *)filename bundle:(NSString *) bundle;
- (void)playSound:(NSArray *)filebundle;
- (NSTimeInterval)soundDuration:(NSString *)filename bundle:(NSString *) bundle;

@end

@protocol InstrumentViewDataSource
@required
- (id <Engine>)engineForInstrumentView:(InstrumentView *)instrumentView;
@end

@protocol InstrumentViewDelegate
@required
- (void)instrumentView:(InstrumentView *)instrumentView didStart:(BOOL)start;
- (void)instrumentView:(InstrumentView *)instrumentView didFinish:(BOOL)finish;
- (void)instrumentView:(InstrumentView *)instrumentView didSendResponses:(NSArray *)responses withResponseTime:(NSTimeInterval)responseTime;
@end

