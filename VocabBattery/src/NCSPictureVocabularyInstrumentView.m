//
//  NCSPictureVocabularyInstrumentView.b
//  NCS Admin
//
//  Created by Mike Rose on 12/3/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "NCSPictureVocabularyInstrumentView.h"
#import "NCSPictureVocabularyButton.h"

#define PHOTO_COUNT     4
#define RGB(r, g, b)                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface NCSPictureVocabularyInstrumentView ()
@property (strong, nonatomic) UILabel *instructionLabel1;
@property (strong, nonatomic) UILabel *instructionLabel2;
@property (strong, nonatomic) TapView *tapView;
@property (strong, nonatomic) NSMutableArray *buttons;
@property (strong, nonatomic) NSMutableArray *widthCns;
@property (strong, nonatomic) NSMutableArray *heightCns;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) UIButton *playAgainButton;
@property (strong, nonatomic) NSTimer *buttonFlashTimer;
@property (nonatomic) BOOL didGoBack;
@end

@implementation NCSPictureVocabularyInstrumentView

- (UIImage*) getImage: (NSString*) name {
    
    NSBundle *staticBundle =[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Vocab" ofType:@"bundle"]];
    NSString *fileStr2 = [[staticBundle resourcePath] stringByAppendingPathComponent: name ];
    return [UIImage imageWithContentsOfFile: fileStr2 ];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSLayoutConstraint *cnX;
        NSLayoutConstraint *cnY;
        NSLayoutConstraint *cnWidth;
        NSLayoutConstraint *cnHeight;
        
        _buttons = [NSMutableArray arrayWithCapacity:PHOTO_COUNT];
        _widthCns = [NSMutableArray arrayWithCapacity:PHOTO_COUNT];
        _heightCns = [NSMutableArray arrayWithCapacity:PHOTO_COUNT];
        
        // self
        self.instrumentTitle = @"NIH Toolbox Picture Vocabulary Test";
        self.backgroundColor = [UIColor darkGrayColor];

        self.engineName= @"DichotomousEngine";
        self.parserName= @"VocabParser";
        
        // labels
        _instructionLabel1 = [[UILabel alloc] init];
        // _instructionLabel1.backgroundColor = [UIColor blueColor];
        _instructionLabel1.font = [UIFont boldSystemFontOfSize:26.0];
        _instructionLabel1.textColor = [UIColor whiteColor];
        _instructionLabel1.textAlignment = NSTextAlignmentCenter;
        _instructionLabel1.numberOfLines = 0;
        [self addSubview:_instructionLabel1];
        
        _instructionLabel1.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_instructionLabel1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:40.0];
        cnY = [NSLayoutConstraint constraintWithItem:_instructionLabel1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:40.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_instructionLabel1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-40.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_instructionLabel1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-20.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        _instructionLabel2 = [[UILabel alloc] init];
        // _instructionLabel2.backgroundColor = [UIColor blueColor];
        _instructionLabel2.font = [UIFont boldSystemFontOfSize:26.0];
        _instructionLabel2.textColor = [UIColor whiteColor];
        _instructionLabel2.textAlignment = NSTextAlignmentCenter;
        _instructionLabel2.numberOfLines = 0;
        [self addSubview:_instructionLabel2];
        
        _instructionLabel2.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_instructionLabel2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:40.0];
        cnY = [NSLayoutConstraint constraintWithItem:_instructionLabel2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:20.0 - 210.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:_instructionLabel2 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-40.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_instructionLabel2 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-40.0];
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
        
        // buttons
        NCSPictureVocabularyButton *button1 = [NCSPictureVocabularyButton buttonWithType:UIButtonTypeCustom];
        button1.tag = 1;
        button1.layer.borderColor = [UIColor redColor].CGColor;
        
        [button1 addTarget:self action:@selector(didTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button1 addTarget:self action:@selector(didTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button1 addTarget:self action:@selector(didCancel:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchDragOutside|UIControlEventTouchCancel];
        
        [self addSubview:button1];
        
        button1.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-10.0];
        cnY = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-10.0 -40.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:408.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:272.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        [_buttons addObject:button1];
        [_widthCns addObject:cnWidth];
        [_heightCns addObject:cnHeight];
        
        NCSPictureVocabularyButton *button2 = [NCSPictureVocabularyButton buttonWithType:UIButtonTypeCustom];
        button2.tag = 2;
        button2.layer.borderColor = [UIColor redColor].CGColor;
        
        [button2 addTarget:self action:@selector(didTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button2 addTarget:self action:@selector(didTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button2 addTarget:self action:@selector(didCancel:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchDragOutside|UIControlEventTouchCancel];
        
        [self addSubview:button2];
        
        button2.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:button2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:10.0];
        cnY = [NSLayoutConstraint constraintWithItem:button2 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-10.0 -40.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:button2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:408.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:button2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:272.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        [_buttons addObject:button2];
        [_widthCns addObject:cnWidth];
        [_heightCns addObject:cnHeight];
        
        NCSPictureVocabularyButton *button3 = [NCSPictureVocabularyButton buttonWithType:UIButtonTypeCustom];
        button3.tag = 3;
        button3.layer.borderColor = [UIColor redColor].CGColor;
        
        [button3 addTarget:self action:@selector(didTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button3 addTarget:self action:@selector(didTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button3 addTarget:self action:@selector(didCancel:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchDragOutside|UIControlEventTouchCancel];
        
        [self addSubview:button3];
        
        button3.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:button3 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-10.0];
        cnY = [NSLayoutConstraint constraintWithItem:button3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:10.0 -40.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:button3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:408.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:button3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:272.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        [_buttons addObject:button3];
        [_widthCns addObject:cnWidth];
        [_heightCns addObject:cnHeight];
        
        NCSPictureVocabularyButton *button4 = [NCSPictureVocabularyButton buttonWithType:UIButtonTypeCustom];
        button4.tag = 4;
        button4.layer.borderColor = [UIColor redColor].CGColor;
        
        [button4 addTarget:self action:@selector(didTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button4 addTarget:self action:@selector(didTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button4 addTarget:self action:@selector(didCancel:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchDragOutside|UIControlEventTouchCancel];
        
        [self addSubview:button4];
        
        button4.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:button4 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:10.0];
        cnY = [NSLayoutConstraint constraintWithItem:button4 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:10.0 -40.0];
        cnWidth = [NSLayoutConstraint constraintWithItem:button4 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:408.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:button4 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:272.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        [_buttons addObject:button4];
        [_widthCns addObject:cnWidth];
        [_heightCns addObject:cnHeight];
        
        
        // go back button
        _goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _goBackButton.backgroundColor = [UIColor whiteColor];
        _goBackButton.layer.cornerRadius = 6.0;
        _goBackButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        _goBackButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15.0);
        [_goBackButton setTitle:@"Go Back" forState:UIControlStateNormal];
        [_goBackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_goBackButton setTitleColor:RGB(183, 183, 183) forState:UIControlStateHighlighted];
        [_goBackButton setTitleColor:RGB(183, 183, 183) forState:UIControlStateDisabled];
        [_goBackButton setImage:[self getImage:@"go-back-normal"] forState:UIControlStateNormal];
        [_goBackButton setImage:[self getImage:@"go-back-highlighted"] forState:UIControlStateHighlighted];
        [_goBackButton setImage:[self getImage:@"go-back-highlighted"]  forState:UIControlStateDisabled];
        [_goBackButton addTarget:self action:@selector(didTapGoBack:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_goBackButton];
        
        _goBackButton.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_goBackButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:button1 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_goBackButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-40];
        cnWidth = [NSLayoutConstraint constraintWithItem:_goBackButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:142.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_goBackButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:60.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // play again button
        _playAgainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playAgainButton.backgroundColor = [UIColor whiteColor];
        _playAgainButton.layer.cornerRadius = 6.0;
        _playAgainButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        _playAgainButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15.0);
        [_playAgainButton setTitle:@"Play Again" forState:UIControlStateNormal];
        [_playAgainButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_playAgainButton setTitleColor:RGB(183, 183, 183) forState:UIControlStateHighlighted];
        [_playAgainButton setTitleColor:RGB(183, 183, 183) forState:UIControlStateDisabled];
        [_playAgainButton setImage:[self getImage:@"ear-normal"]  forState:UIControlStateNormal];
        [_playAgainButton setImage:[self getImage:@"ear-highlighted"] forState:UIControlStateHighlighted];
        [_playAgainButton setImage:[self getImage:@"ear-highlighted"] forState:UIControlStateDisabled];
        [_playAgainButton addTarget:self action:@selector(didTapPlayAgain:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playAgainButton];
        
        _playAgainButton.translatesAutoresizingMaskIntoConstraints = NO;
        cnX = [NSLayoutConstraint constraintWithItem:_playAgainButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:button4 attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        cnY = [NSLayoutConstraint constraintWithItem:_playAgainButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-40];
        cnWidth = [NSLayoutConstraint constraintWithItem:_playAgainButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:142.0];
        cnHeight = [NSLayoutConstraint constraintWithItem:_playAgainButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:60.0];
        [self addConstraints:@[ cnX, cnY, cnWidth, cnHeight ]];
        
        // instrument title view
        self.instrumentTitleView.titleLabel.text = self.instrumentTitle;
        
        // reset UI
        [self resetUI];
        
    }
    return self;
}

#pragma mark - score

- (NSNumber *)calculateScoreForInstrument:(Instrument *)instrument withUser:(User *)user
{
    CGFloat score = ([self.engine getScore] +12) *100;    
    return [NSNumber numberWithFloat:(score)];
}

#pragma mark - action

- (void)didTouchDown:(UIButton *)button
{
    button.layer.borderWidth = 6.0;
}

- (void)didTouchUpInside:(NCSPictureVocabularyButton *)button
{
    [self enableButtons:NO];
    
    button.layer.borderWidth = 0;
    
    [self stopResponseTime];
    [self enableButtons:NO];
    
    if ([self.currentItem.ID rangeOfString:@"VOCAB_PRACT"].location != NSNotFound) {
        if (button.tag == 1) {
            // correct
            [self playSound:@"Vocabinst3-7_4.mp3" bundle:@"Vocab"];
            [self performSelector:@selector(sendResponseAsNumber:) withObject:[NSNumber numberWithInteger:button.position] afterDelay:0.79 + 0.25];
        } else {
            // incorrect
            NSTimeInterval delay;
            if ([self.currentItem.ID isEqualToString:@"VOCAB_PRACT1"]) {
                // banana
                [self playSound:@"Vocabinst3-7_5.mp3" bundle:@"Vocab"];
                delay = 2.91;
            } else {
                // spoon
                [self playSound:@"Vocabinst3-7_7.mp3" bundle:@"Vocab"];
                delay = 2.67;
            }
            
            // flash the correct button
            [self flashButton:[self correctButton]];
            
            // stop the button flash after the voice correction has played
            [self performSelector:@selector(stopFlashButton) withObject:nil afterDelay:delay + 0.25];
            
            // play the current item again after the voice correction has played
            // [self performSelector:@selector(playSound:) withObject:self.sounds.lastObject afterDelay:delay + 0.25];
        
        }
    } else {
        [self sendResponse:button.position];
    }
}

- (void)didCancel:(UIButton *)button
{
    button.layer.borderWidth = 0;
}

- (void)didTapGoBack:(UIButton *)button
{
    _didGoBack = YES;
    [self previousItem];
}

- (void)didTapPlayAgain:(UIButton *)button
{
    [self playSound:self.sounds.lastObject bundle:@"Vocab"];
}
    
- (UIButton *)correctButton
{
    for (UIButton *button in _buttons) {
        if (button.tag == 1) return button;
    }
    return nil;
}

- (void)stopFlashButton
{
    [_buttonFlashTimer invalidate];
    _buttonFlashTimer = nil;
    
    for (UIButton *button in _buttons) {
        button.selected = NO;
        button.layer.borderWidth = 0;
    }
    
    // FIXME: hack for practice, reusing an item
    [self startResponseTime];
    [self enableButtons:YES];
}

- (void)flashButton:(UIButton *)button
{
    _buttonFlashTimer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(flashButtonEvent:) userInfo:button repeats:YES];
}

- (void)flashButtonEvent:(NSTimer *)timer {
    UIButton *button = timer.userInfo;
    button.selected = !button.selected;
    button.layer.borderWidth = (button.selected) ? 6.0 : 0;
}

#pragma mark - item managment

- (void)displayItem:(ItemData *)item
{
    [super displayItem:item];
    
    // cancel delayed sound playback
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    self.text = [[NSMutableArray alloc] initWithCapacity:4];
    self.sounds = [[NSMutableArray alloc] initWithCapacity:4];
    // self.images = [[NSMutableArray alloc] initWithCapacity:4];
    
    // FIXME: not needed since we can get the current item
    // self.isInstruction = ([item.ID rangeOfString:@"_INSTR"].location != NSNotFound) ? YES : NO;
    // self.isPractice = ([item.ID rangeOfString:@"VOCAB_PRACT"].location == NSNotFound) ? NO : YES;
    
    // parse the data
    for (Element *element in item.elements) {
        
        // text
        if ([element.ElementType isEqualToString:NCSElemenTypeLabel]) {
            // text
            for (Resource *resource in element.resources) {
                if ([resource.Type isEqualToString:NCSResourceText]) {
                    // text
                    [self.text addObject:resource.Description];
                }
                
                //NSLog(@"translation for %@ = %@",resource.ResourceOID,[self getText:resource.ResourceOID resource:@"VOCAB.es"]);
            }
        }
        
        // sound
        else if ([element.ElementType isEqualToString:NCSElemenTypeStem]) {
            // sound
            for (Resource *resource in element.resources) {
                if ([resource.Type isEqualToString:NCSResourceText]) {
                    // sound
                    [self.sounds addObject: resource.Description];
                }
            }
        }
        
        // button mapping
        else if ([element.ElementType isEqualToString:NCSElemenTypeResponseSet]) {
            // get mappings from the response set element to apply to buttons
            for (Map *map in element.mappings) {
                for (Resource *resource in map.resources) {
                    if ([resource.Type isEqualToString:NCSResourceText]) {
                        
                        // image
                        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", resource.Description];
                        UIImage *image = [self getImage:imageName];
                        
                        for (NSInteger i = 0; i < _buttons.count; i++) {
                            NSLayoutConstraint *width = _widthCns[i];
                            width.constant = image.size.width;
                            
                            NSLayoutConstraint *height = _heightCns[i];
                            height.constant = image.size.height;
                        }
                        
                        // index
                        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
                        NSNumber *position = [numberFormatter numberFromString:map.Position];
                        NSInteger p = position.integerValue - 1;
                        
                        // button
                        NCSPictureVocabularyButton *button = _buttons[p];
                        button.tag = map.Description.integerValue;
                        button.position = map.Value.integerValue;
                        [button setImage:image forState:UIControlStateNormal];
                        [button setImage:image forState:UIControlStateHighlighted];
                        [button setImage:image forState:UIControlStateSelected];
                        [button setImage:image forState:UIControlStateDisabled];
                        [button setImage:image forState:UIControlStateSelected|UIControlStateDisabled];
                    }
                }
            }
        }
        
    }
    
   // NSLog(@"text: %@ // images: %@ // sounds: %@", self.text, self.images, self.sounds);
    
    // FIXME: hack because the real picture vobac doesn't have an intro button to start the test
    if (!_didStart) {
        _didStart = YES;
        [self.delegate instrumentView:self didStart:YES];
    }
    
    [self resetUI];
    
    //
    // custom methods here
    //
    
    if ([item.ID isEqualToString:@"VOCAB_INTRO"]) {
        
        self.instrumentTitleView.hidden = NO;
    
    } else if ([item.ID rangeOfString:@"VOCAB_INSTR"].location != NSNotFound) {
        
        _instructionLabel1.hidden = NO;
        _instructionLabel1.text = self.text[0];
        
        _instructionLabel2.hidden = NO;
        _instructionLabel2.text = self.text[1];
        
        _tapView.hidden = NO;
        
    } else {
        
        // show buttons and make sure they are disabled
        for (UIButton *button in _buttons) {
            button.hidden = NO;
        }
        _goBackButton.hidden = NO;
        _playAgainButton.hidden = NO;
        
        [self enableButtons:NO];
        
        NSTimeInterval delay = [self soundDuration:[NSString stringWithFormat:@"%@.mp3", self.sounds[0]] bundle:@"Vocab"] + 0.25;
        
        if ([item.ID isEqualToString:@"VOCAB_PRACT1"]) {
            
            NSLog(@"A- delay 1: %f", delay);
            
            // play first sound
            
            [self playSound:[NSString stringWithFormat:@"%@.mp3", self.sounds[0]] bundle:@"Vocab"];
            
            // play second sound after delay
            NSArray * arrayparams = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%@.mp3", self.sounds[1]], @"Vocab", nil];
            [self performSelector:@selector(playSound:) withObject:arrayparams afterDelay:delay];
            delay = delay + [self soundDuration:[NSString stringWithFormat:@"%@.mp3", self.sounds[1]] bundle:@"Vocab"];
            
            NSLog(@"A- delay 2: %f", delay);
            
            // enable buttons after second sound plays
            [self enableButtonsAfterDelay:delay];
            
        } else if ([item.ID isEqualToString:@"VOCAB_PRACT2"]) {
            
            NSLog(@"B- delay 1: %f", delay);
            
            // play sound
            [self playSound:[NSString stringWithFormat:@"%@.mp3", self.sounds[0]] bundle:@"Vocab"];
            
            // enable buttons after sound plays
            [self enableButtonsAfterDelay:delay];
        
        } else {
            
            NSString *intro = @"Vocabinst3-7_9.mp3";
            delay = [self soundDuration:intro bundle:@"Vocab"] + 0.25;
            
            NSLog(@"C- delay 1: %f", delay);
            
            // play sound
            [self playSound:intro bundle:@"Vocab"];
            
            // play second sound
            NSArray * arrayparams = [NSArray arrayWithObjects: [NSString stringWithFormat:@"%@.mp3", self.sounds[0]], @"Vocab", nil];
            [self performSelector:@selector(playSound:) withObject:arrayparams afterDelay:delay];
            delay = delay + [self soundDuration:[NSString stringWithFormat:@"%@.mp3", self.sounds[0]] bundle:@"Vocab"];
            
            NSLog(@"C- delay 2: %f", delay);
            
            // enable buttons after second sound plays
            [self enableButtonsAfterDelay:delay];
        
        }
        
        // start response timer
        [self startResponseTime];
        
    }
    
}

#pragma mark - display states

- (void)resetUI
{
    [super resetUI];
    
    _instructionLabel1.hidden = YES;
    _instructionLabel2.hidden = YES;
    _tapView.hidden = YES;
    
    for (UIButton *button in _buttons) {
        button.hidden = YES;
    }
    
    _goBackButton.hidden = YES;
    _goBackButton.enabled = YES;
    _playAgainButton.hidden = YES;
}

- (void)enableButtonsAfterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(enableButtonsWithNumber:) withObject:[NSNumber numberWithBool:YES] afterDelay:delay];
}

- (void)enableButtonsWithNumber:(NSNumber *)number
{
    [self enableButtons:number.boolValue];
}

- (void)enableButtons:(BOOL)enable
{
    for (UIButton *button in _buttons) {
        button.enabled = enable;
    }
    _goBackButton.enabled = enable;
    _playAgainButton.enabled = enable;
    
    if (enable) {
        // disable the go back button if any of these conditions are true
        BOOL disable = (self.engine.ResultSetList.count < 1) || _didGoBack || ([self.currentItem.ID rangeOfString:@"_PRACT"].location != NSNotFound);
        _goBackButton.enabled = !disable;
        _didGoBack = NO;
    }
}

@end
