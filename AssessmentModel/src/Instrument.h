//
//  Instrument.h
//
//  Created by Mike Rose on 10/22/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "Object.h"

@class Item;

/*
typedef NS_ENUM (NSInteger, NCSInstrumentType) {
    NCSInstrumentTypeDCCS,
    NCSInstrumentTypeFlanker,
    NCSInstrumentTypePSM,
    NCSInstrumentTypePictureVocab,
    NCSInstrumentTypePictureVocabPractice
};
 */

typedef NS_ENUM (NSInteger, NCSInstrumentStatus) {
    NCSInstrumentStatusScheduled,
    NCSInstrumentStatusInProgress,
    NCSInstrumentStatusCompleted,
    NCSInstrumentStatusUploaded
};

@interface Instrument : Object

@property (nonatomic, retain) NSDate *dateFinished;
@property (nonatomic, retain) NSString *dateFinishedString;
@property (nonatomic, retain) NSString *dateStartedString;
@property (nonatomic, retain) NSDate *dateStarted;
@property (nonatomic, retain) NSDate *dateUploaded;
@property (nonatomic, retain) NSNumber *index;
@property (nonatomic, retain) NSNumber *score;
@property (nonatomic, readonly) NSNumber *status;
@property (nonatomic, readonly) NSString *statusString;
//@property (nonatomic, retain) NSNumber *type;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, retain) NSString *view;
@property (nonatomic, retain) NSString *uploadOID;
@property (nonatomic, retain) NSSet *items;

+ (NSDateFormatter *)dateFormatter;
//+ (NSArray *)instrumentTypes;
//+ (NSString *)instrumentTitleForInstrumentType:(NSNumber *)type;
+ (NSString *)statusStringForStatus:(NSNumber *)status;

@end

@interface Instrument (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
