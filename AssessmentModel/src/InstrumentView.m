//
//  InstrumentView.m
//  NCS Admin
//
//  Created by Mike Rose on 10/23/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "InstrumentView.h"

#define TIMEOUT_TIME            10.0

@interface InstrumentView ()
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) NSTimer *timeoutTimer;
@property (strong, nonatomic) NSDate *startTime;
@property (nonatomic) NSTimeInterval repsonseTime;
@end

@implementation InstrumentView

- (id)init
{
    self = [super init];
    if (self) {
        
        NSLayoutConstraint *cnX;
        NSLayoutConstraint *cnY;
        NSLayoutConstraint *cnWidth;
        NSLayoutConstraint *cnHeight;
        
        // self
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        // self.layer.cornerRadius = 10.0;
        
        _playRepetitiveSounds = YES;
        
        // instrument title view
        _instrumentTitleView = [[InstrumentTitleView alloc] init];
        _instrumentTitleView.tapView.delegate = self;
        _instrumentTitleView.tapView.tag = 1;
        [self addSubview:_instrumentTitleView];
        
        _instrumentTitleView.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_instrumentTitleView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_instrumentTitleView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_instrumentTitleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_instrumentTitleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        [self resetUI];
        
    }
    return self;
}

- (id <Engine>)engine
{
    if (!_engine) _engine = [_dataSource engineForInstrumentView:self];
    return _engine;
}

#pragma mark - score

- (NSNumber *)calculateScoreForInstrument:(Instrument *)instrument withUser:(User *)user
{
    return nil;
}

#pragma mark - item management

-(NSString*) getText:(NSString*) key resource:(NSString*) resource{
    
    return NSLocalizedStringFromTable(key, resource , nil);
}

- (void)start
{
    [self nextItem];
}

- (void)resetUI
{
    _instrumentTitleView.hidden = YES;
}

- (void)previousItem
{
    NSString *itemID = [self.engine getPreviousItem];
    ItemData *previousItem = [self.engine getItem:itemID];
    [self displayItem:previousItem];
}

- (void)nextItem
{
    NSString *itemID = [self.engine getNextItem];
    ItemData *nextItem = [self.engine getItem:itemID];
    
    if (nextItem == nil) {
        [_delegate instrumentView:self didFinish:YES];
    } else {
        [self displayItem:nextItem];
    }
}

- (void)displaySection:(NSArray *)section
{
    _currentSection = section;
}

- (void)displayItem:(ItemData *)item
{
    _currentItem = item;
}

- (void)startTimeout
{
    [self stopTimeout];
    _timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:TIMEOUT_TIME target:self selector:@selector(didTimeout) userInfo:nil repeats:NO];
}

- (void)stopTimeout
{
    [_timeoutTimer invalidate];
    _timeoutTimer = nil;
}

- (void)didTimeout
{
    [self stopTimeout];
}

- (void)startResponseTime
{
    _startTime = [NSDate date];
}

- (void)stopResponseTime
{
    NSDate *stopTime = [NSDate date];
    _repsonseTime = [stopTime timeIntervalSinceDate:_startTime];
}

- (void)sendResponse:(NSInteger)response
{

    NSArray*  myArray = [[NSArray alloc] initWithObjects: [NSNumber numberWithInteger:response], nil];
   	
    [_delegate instrumentView:self didSendResponses:myArray withResponseTime:_repsonseTime];
    _repsonseTime = 0;
}

- (void)sendResponseAsNumber:(NSNumber *)response
{
    [self sendResponse:response.integerValue];
}

- (void)sendResponses:(NSArray *)responses
{
    [_delegate instrumentView:self didSendResponses:responses withResponseTime:_repsonseTime];
    _repsonseTime = 0;
}

#pragma mark - media management

- (void)playSound:(NSArray *)filebundle;
{
    if (!filebundle || filebundle.count != 2) return;
    
    NSBundle *staticBundle =[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:filebundle[1] ofType:@"bundle"]];
    
    NSString *fileStr2 = [[staticBundle resourcePath] stringByAppendingPathComponent: filebundle[0]];
    NSData *data = [NSData dataWithContentsOfFile:fileStr2];
    
    
    
    // NSString *filenameWithoutExtension = [filename stringByDeletingPathExtension];
    // NSString *filepath = [[NSBundle mainBundle] pathForResource:filenameWithoutExtension ofType:@"mp3"];
    //NSData *data = [NSData dataWithContentsOfFile:filepath];
    
    if (data) {
        _audioPlayer = nil;
        _audioPlayer.delegate = nil;
        
        NSError *error;
        _audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&error];
        _audioPlayer.delegate = self;
        _audioPlayer.volume = 1.0;
        [_audioPlayer play];
    }
}

- (void)playSound:(NSString *)filename bundle:(NSString *) bundle
{
    if (!filename || filename.length == 0) return;
   
    NSBundle *staticBundle =[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundle ofType:@"bundle"]];
    
    NSString *fileStr2 = [[staticBundle resourcePath] stringByAppendingPathComponent: filename ];
    NSData *data = [NSData dataWithContentsOfFile:fileStr2];
    
    
    
   // NSString *filenameWithoutExtension = [filename stringByDeletingPathExtension];
   // NSString *filepath = [[NSBundle mainBundle] pathForResource:filenameWithoutExtension ofType:@"mp3"];
    //NSData *data = [NSData dataWithContentsOfFile:filepath];
    
    if (data) {
        _audioPlayer = nil;
        _audioPlayer.delegate = nil;
        
        NSError *error;
        _audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&error];
        _audioPlayer.delegate = self;
        _audioPlayer.volume = 1.0;
        [_audioPlayer play];
    }
}

- (NSTimeInterval)soundDuration:(NSString *)filename bundle:(NSString *) bundle
{
    if (!filename || filename.length == 0) return 0;
 
    NSBundle *staticBundle =[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundle ofType:@"bundle"]];
    
    NSString *fileStr2 = [[staticBundle resourcePath] stringByAppendingPathComponent: filename ];
    NSData *data = [NSData dataWithContentsOfFile:fileStr2];

    /*
    NSString *filenameWithoutExtension = [filename stringByDeletingPathExtension];
    NSString *filepath = [[NSBundle mainBundle] pathForResource:filenameWithoutExtension ofType:@"mp3"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    */
    NSTimeInterval duration = 0;
    if (data) {
        NSError *error;
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&error];
        duration = audioPlayer.duration;
    }
    
    return duration;
}

#pragma mark - av audio player delegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //
}

#pragma mark - tap view delegate

- (void)tapViewDidReceiveTap:(TapView *)tapView;
{
    [self stopResponseTime];
    [self sendResponse:-1];
    
    if (tapView.tag == 1) {
        // instrument title tap view
        [self.delegate instrumentView:self didStart:YES];
    }
}

@end
