//
//  NCSFlankerInstrumentView.m
//  NCS Admin
//
//  Created by Mike Rose on 10/28/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "NCSFlankerInstrumentView.h"
#import "NCSFlankerInstructionView.h"
#import "NCSLabelGroupView.h"
#import "NCSFlankerImageGroupView.h"

#import <AssessmentModel/TapView.h>

#define IMAGE_COUNT         5
#define FISH_IMAGE_SIZE     CGSizeMake(160.0, 160.0)
#define ARROW_IMAGE_SIZE    CGSizeMake(90.0, 80.0)
#define ANIMATION_TIME      0.3

@interface NCSFlankerInstrumentView ()

@property (strong, nonatomic) TapView *tapView;
@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) NSTimer *buttonFlashTimer;

@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UILabel *middleLabel;
@property (strong, nonatomic) UILabel *bottomLabel;
@property (strong, nonatomic) UIImageView *starImageView;

@property (strong, nonatomic) NCSFlankerInstructionView *instructionView;
@property (strong, nonatomic) NCSLabelGroupView *labelGroupView;
@property (strong, nonatomic) NCSFlankerImageGroupView *imageGroupView;
@property (strong, nonatomic) NSLayoutConstraint *imageGroupViewWidthCn;
@property (strong, nonatomic) NSLayoutConstraint *imageGroupViewHeightCn;

@property (nonatomic) BOOL isArrow;

@end

@implementation NCSFlankerInstrumentView

- (id)init
{
    
    self = [super init];
    if (self) {
        
        NSLayoutConstraint *cnX;
        NSLayoutConstraint *cnY;
        NSLayoutConstraint *cnWidth;
        NSLayoutConstraint *cnHeight;
        
        // self
        self.instrumentTitle = @"NIH Toolbox Flanker Inhibitory Control & Attention Test";
        self.backgroundColor = [UIColor whiteColor];
        
        self.engineName= @"ProgressiveSectionalEngine";
        self.parserName=@"FlankerDataParser";
        
        // image group view
        _imageGroupView = [[NCSFlankerImageGroupView alloc] initWithImageViewCount:IMAGE_COUNT];
        [self addSubview:_imageGroupView];
        
        _imageGroupView.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_imageGroupView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_imageGroupView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:0.9 constant:0];
        _imageGroupViewWidthCn = [NSLayoutConstraint constraintWithItem:_imageGroupView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:1.0];
        _imageGroupViewHeightCn = [NSLayoutConstraint constraintWithItem:_imageGroupView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:1.0];
        [self addConstraints:@[ cnX, cnY, _imageGroupViewWidthCn, _imageGroupViewHeightCn ]];
        
        // instruction view
        _instructionView = [[NCSFlankerInstructionView alloc] init];
        [self addSubview:_instructionView];
        
        _instructionView.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_instructionView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_instructionView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_instructionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_instructionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // label group view
        _labelGroupView = [[NCSLabelGroupView alloc] initWithTextColor:[UIColor blackColor]];
        [self addSubview:_labelGroupView];
        
        _labelGroupView.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_labelGroupView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_labelGroupView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_labelGroupView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_labelGroupView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // top label
        _topLabel = [[UILabel alloc] init];
        //_topLabel.backgroundColor = [UIColor yellowColor];
        _topLabel.font = [UIFont boldSystemFontOfSize:26.0];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.numberOfLines = 2;
        _topLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_topLabel];
        
        _topLabel.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_topLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_topLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeTop multiplier:1.0 constant:-50.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_topLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-100.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_topLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:125.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // middle label
        _middleLabel = [[UILabel alloc] init];
        //_middleLabel.backgroundColor = [UIColor yellowColor];
        _middleLabel.font = [UIFont boldSystemFontOfSize:26.0];
        _middleLabel.textAlignment = NSTextAlignmentCenter;
        _middleLabel.numberOfLines = 1;
        [self addSubview:_middleLabel];
        
        _middleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_middleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_middleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_middleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_middleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // bottom label
        _bottomLabel = [[UILabel alloc] init];
        //_bottomLabel.backgroundColor = [UIColor yellowColor];
        _bottomLabel.font = [UIFont boldSystemFontOfSize:26.0];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.numberOfLines = 2;
        _bottomLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:_bottomLabel];
        
        _bottomLabel.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_bottomLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_bottomLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:25.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_bottomLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-100.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_bottomLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:125.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // star image view
        _starImageView = [[UIImageView alloc] initWithImage:[self getImage:@"star-white.jpg"]];
        [self addSubview:_starImageView];
        
        _starImageView.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_starImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_starImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_imageGroupView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-4.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_starImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:50.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_starImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:46.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // left button
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [_leftButton setImage:[self getImage:@"left-button.png"] forState:UIControlStateNormal];
        [_leftButton setImage:[self getImage:@"left-button.png"] forState:UIControlStateDisabled];
        [_leftButton setImage:[self getImage:@"left-button-select.png"] forState:UIControlStateHighlighted];
        [_leftButton setImage:[self getImage:@"left-button-flash.png"] forState:UIControlStateSelected|UIControlStateDisabled];
        [_leftButton addTarget:self action:@selector(didTapResponseButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
        
        _leftButton.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_leftButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-75.0];
        cnY = [NSLayoutConstraint constraintWithItem:_leftButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-50.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_leftButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:140.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_leftButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:131.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // right button
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_rightButton setImage:[self getImage:@"right-button.png"] forState:UIControlStateNormal];
        [_rightButton setImage:[self getImage:@"right-button.png"] forState:UIControlStateDisabled];
        [_rightButton setImage:[self getImage:@"right-button-select.png"] forState:UIControlStateHighlighted];
        [_rightButton setImage:[self getImage:@"right-button-flash.png"] forState:UIControlStateSelected|UIControlStateDisabled];
        [_rightButton addTarget:self action:@selector(didTapResponseButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton];
        
        _rightButton.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_rightButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:75.0];
        cnY = [NSLayoutConstraint constraintWithItem:_rightButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-50.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_rightButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:140.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_rightButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:131.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // tap view
        _tapView = [[TapView alloc] init];
        _tapView.delegate = self;
        [self addSubview:_tapView];
        
        cnX = [NSLayoutConstraint constraintWithItem:_tapView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_tapView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_tapView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_tapView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // instrument title view
        self.instrumentTitleView.titleLabel.text = self.instrumentTitle;
        self.instrumentTitleView.titleLabel.textColor = [UIColor blackColor];
        
        [self resetUI];
    }
    return self;
}



- (UIImage*) getImage: (NSString*) name {

    NSBundle *staticBundle =[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Flanker" ofType:@"bundle"]];
    NSString *fileStr2 = [[staticBundle resourcePath] stringByAppendingPathComponent: name ];
    return [UIImage imageWithContentsOfFile: fileStr2 ];
}
#pragma mark - score

- (NSNumber *)calculateScoreForInstrument:(Instrument *)instrument withUser:(User *)user
{
    // NSSet > sorted NSArray
    NSSortDescriptor *sortByPosition = [NSSortDescriptor sortDescriptorWithKey:@"position" ascending:YES];
    NSArray *sortedItems = [[instrument.items allObjects] sortedArrayUsingDescriptors:@[ sortByPosition ]];
    for (Item *item in sortedItems) {
        NSLog(@"item position: %@", item.position);
    }
    
    // number formatter example
    /*
    NSNumber *myNumber = [NSNumber numberWithDouble:0.01234];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.maximumFractionDigits = 2;
    */
    return [NSNumber numberWithFloat:1.0];
}

#pragma mark - actions

- (void)didTapResponseButton:(UIButton *)button
{
    [self stopTimeout];
    [self stopResponseTime];
    [self enableButtons:NO];
    
    // cancel delayed flashing timer
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if (self.isInstruction) {
        
        [self sendResponse:-1];
        
    } else if (self.isPractice) {
        
        if (button.tag == 1) {
            
            [self playSound:@"Greatjob.mp3" bundle:@"Flanker"];
            [self performSelector:@selector(sendResponseAsNumber:) withObject:[NSNumber numberWithInteger:button.tag] afterDelay:1.13 + 0.25];
            
        } else {
            
            if (_isArrow) {
                [self playSound:@"Feedback_Arrow_8-17.mp3" bundle:@"Flanker"];
                [self performSelector:@selector(sendResponseAsNumber:) withObject:[NSNumber numberWithInteger:button.tag] afterDelay:3.87 + 0.25];
            } else {
                [self playSound:@"Feedback_Fish_3-7.mp3" bundle:@"Flanker"];
                [self performSelector:@selector(sendResponseAsNumber:) withObject:[NSNumber numberWithInteger:button.tag] afterDelay:3.85 + 0.25];
            }
            
            NSString *correctImageName = (_leftButton.tag == 1) ? @"left-button-flash" : @"right-button-flash";
            UIButton *correctButton = (_leftButton.tag == 1) ? _leftButton : _rightButton;
            [correctButton setImage:[UIImage imageNamed:correctImageName] forState:UIControlStateSelected|UIControlStateDisabled];
            
            [self flashButton:correctButton];
            
        }
        
        NSString *imageName = (_leftButton.tag == button.tag) ? @"left-button-select" : @"right-button-select";
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected|UIControlStateDisabled];
        button.selected = YES;
        
    } else {
        
        [self sendResponse:button.tag];
        
    }
}

- (void)flashButton:(UIButton *)button
{
    _buttonFlashTimer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(flashButtonEvent:) userInfo:button repeats:YES];
}

- (void)flashButtonEvent:(NSTimer *)timer {
    UIButton *button = timer.userInfo;
    button.selected = !button.selected;
}

#pragma mark - item managment

- (void)displayItem:(ItemData *)item
{
    [super displayItem:item];
    
    self.text = [[NSMutableArray alloc] initWithCapacity:10];
    self.images = [[NSMutableArray alloc] initWithCapacity:10];
    self.sounds = [[NSMutableArray alloc] initWithCapacity:10];
    
    self.isInstruction = ([item.ID rangeOfString:@"_INSTR"].location != NSNotFound) ? YES : NO;
    self.isPractice = ( ([item.ID rangeOfString:@"FLANKER_FISH_PRAC"].location != NSNotFound) || ([item.ID rangeOfString:@"FLANKER_ARROW_PRAC"].location != NSNotFound) ) ? YES : NO;
    self.isArrow = ([item.ID rangeOfString:@"ARROW"].location != NSNotFound) ? YES : NO;
    
    // dynamically adjust image size for fish or arrows
    CGSize imageSize = (self.isArrow) ? ARROW_IMAGE_SIZE : FISH_IMAGE_SIZE;
    _imageGroupViewWidthCn.constant = imageSize.width * IMAGE_COUNT;
    _imageGroupViewHeightCn.constant = imageSize.height;
    
    // parse the data
    for (Element *element in item.elements) {
        // text, image or sound
        if ([element.ElementType isEqualToString:NCSElemenTypeContext] || [element.ElementType isEqualToString:NCSElemenTypeStem]) {
            // get resources from the context and/or stem element
            for (Resource *resource in element.resources) {
                if ([resource.Type isEqualToString:NCSResourceText]) {
                    // text
                    [self.text addObject:resource.Description];
                } else if ([resource.Type isEqualToString:NCSResourceSound]) {
                    // sound
                    
                    
                    
                    [self.sounds addObject:resource.Description];
                    
                    
                    
                } else if ([resource.Type isEqualToString:NCSResourceImage]) {
                    // image
                    [self.images addObject:[self getImage:resource.Description]];
                }
                
             //  NSLog(@"Translation for %@ = %@",resource.ResourceOID,[self getText:resource.ResourceOID resource:@"Flanker.es"]);
            }
        }
        // button mapping
        else if ([element.ElementType isEqualToString:NCSElemenTypeResponseSet]) {
            // get mappings from the response set element to apply to buttons
            for (Map *map in element.mappings) {
                for (Resource *resource in map.resources) {
                    if ([resource.Type isEqualToString:NCSResourceText]) {
                        // left or right button
                        UIButton *button = ([resource.Description isEqualToString:@"Left"]) ? _leftButton : _rightButton;
                        button.tag = map.Description.integerValue;
                    }
                }
            }
        }
    }
    
    [self resetUI];
    [self startResponseTime];
    
    //
    
    if ([item.ID isEqualToString:@"FLANKER_INTRO"]) {
        
        self.instrumentTitleView.hidden = NO;
    
    } else if ([item.ID isEqualToString:@"FLANKER_INSTR1"]) {
    
        _instructionView.hidden = NO;
        _topLabel.hidden = NO;
        _bottomLabel.hidden = NO;
        _tapView.hidden = NO;

        _instructionView.leftLabel.text = self.text[1];
        _instructionView.rightLabel.text = self.text[2];
        _topLabel.text = self.text[0];
        _bottomLabel.text = self.text[3];
    
    } else if ([item.ID isEqualToString:@"FLANKER_INSTR2"] || [item.ID isEqualToString:@"FLANKER_INSTR3"] || [item.ID isEqualToString:@"FLANKER_INSTR4"]) {
        
        _imageGroupView.hidden = NO;
        _topLabel.hidden = NO;
        _tapView.hidden = NO;
        
        _imageGroupView.images = self.images;
        _topLabel.text = self.text[0];

    } else if ( ([item.ID rangeOfString:@"FLANKER_FISH_INSTR"].location != NSNotFound) || ([item.ID rangeOfString:@"FLANKER_ARROW_INSTR"].location != NSNotFound) ) {
        
        _imageGroupView.hidden = NO;
        _topLabel.hidden = NO;
        _leftButton.hidden = NO;
        _rightButton.hidden = NO;
        
        _leftButton.enabled = _leftButton.tag;
        _rightButton.enabled = _rightButton.tag;
        
        _imageGroupView.images = self.images;
        _topLabel.text = self.text[0];
        
        if ([item.ID isEqualToString:@"FLANKER_FISH_INSTR4"] || [item.ID isEqualToString:@"FLANKER_ARROW_INSTR4"]) {
            _bottomLabel.hidden = NO;
            _bottomLabel.text = self.text[1];
        }
        
        // flash button after delay
        NSInteger delay = (_topLabel.text.length < 100) ? 2.0 : 4.0;
        NSString *correctImageName = (_leftButton.tag == 1) ? @"left-button-flash" : @"right-button-flash";
        UIButton *correctButton = (_leftButton.tag == 1) ? _leftButton : _rightButton;
        [correctButton setImage:[UIImage imageNamed:correctImageName] forState:UIControlStateSelected];
        [self performSelector:@selector(flashButton:) withObject:correctButton afterDelay:delay];
        
    } else if ([item.ID isEqualToString:@"FLANKER_NOWTRY"] || [item.ID isEqualToString:@"FLANKER_NOWREADY"] || [item.ID isEqualToString:@"FLANKER_NOWARROWS"]) {
        
        _labelGroupView.hidden = NO;
        _tapView.hidden = NO;
        
        _labelGroupView.label1.text = self.text[0];
        _labelGroupView.label2.text = self.text[1];
        _labelGroupView.label3.text = self.text[2];
        _labelGroupView.label4.text = self.text[3];
        _labelGroupView.label5.text = self.text[4];
        
        CGRect rect = [_labelGroupView.label2.text boundingRectWithSize:_labelGroupView.label2.bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: _labelGroupView.label2.font } context:nil];
        
        _labelGroupView.imageView.image = [UIImage imageNamed:@"star-white.jpg"];
        _labelGroupView.imageViewCnX.constant = (rect.size.width * 0.5) + 15.0;
        
    } else {
        
        [self stopResponseTime]; // timer will restart after test animation is finished
        
        _imageGroupView.hidden = NO;
        _leftButton.hidden = NO;
        _rightButton.hidden = NO;
        
        [self enableButtons:NO];
        
        _middleLabel.text = @"MIDDLE";
        
        [self animation1];

    }
    
}

- (void)didTimeout
{
    [super didTimeout];
    
    [self stopResponseTime];
    [self enableButtons:NO];
    [self sendResponse:-1];
}

#pragma mark - display states

- (void)resetUI
{
    [super resetUI];
    
    _tapView.hidden = YES;
    
    _leftButton.hidden = YES;
    _leftButton.selected = _leftButton.highlighted = NO;
    _rightButton.hidden = YES;
    _rightButton.selected = _rightButton.highlighted = NO;
    
    [_leftButton setImage:[UIImage imageNamed:@"left-button-flash"] forState:UIControlStateSelected|UIControlStateDisabled];
    [_rightButton setImage:[UIImage imageNamed:@"right-button-flash"] forState:UIControlStateSelected|UIControlStateDisabled];
    [_buttonFlashTimer invalidate];
    
    _topLabel.hidden = YES;
    _middleLabel.hidden = YES;
    _bottomLabel.hidden = YES;
    _starImageView.hidden = YES;
    
    _instructionView.hidden = YES;
    _labelGroupView.hidden = YES;
    _imageGroupView.hidden = YES;
    [_imageGroupView clearImages];
}

- (void)enableButtons:(BOOL)enable
{
    _leftButton.enabled = enable;
    _rightButton.enabled = enable;
}

#pragma mark - animations

- (void)animation1
{
    _starImageView.hidden = NO;
    _starImageView.alpha = 0;
    
    [UIView animateWithDuration:ANIMATION_TIME delay:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _starImageView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self animation2];
    }];
}

- (void)animation2
{
    _middleLabel.hidden = NO;
    _middleLabel.alpha = 0;
    
    [UIView animateWithDuration:ANIMATION_TIME delay:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _starImageView.alpha = 0;
        _middleLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        _starImageView.hidden = YES;
        if (self.sounds.count && self.playRepetitiveSounds) {
            [self playSound:self.sounds[0] bundle:@"Flanker"];
        }
        [self animation3];
    }];
}

- (void)animation3
{
    _imageGroupView.hidden = NO;
    _imageGroupView.alpha = 1;

    [self performSelector:@selector(initImageGroup) withObject:self afterDelay:1.0];
    
    [UIView animateWithDuration:ANIMATION_TIME delay:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _middleLabel.alpha = 0;
    } completion:^(BOOL finished) {
        _middleLabel.hidden = YES;
        
        [self enableButtons:YES];
        if (!self.isPractice) [self startTimeout];
        [self startResponseTime];
    }];
}

-  (void)initImageGroup
{
    _imageGroupView.images = self.images;
}

@end
