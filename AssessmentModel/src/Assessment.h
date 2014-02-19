//
//  Assessment.h
//  NCS Admin
//
//  Created by Mike Rose on 10/22/13.
//  Copyright (c) 2013 rosem inc. All rights reserved.
//

#import "Object.h"

@class Instrument, User;

typedef NS_ENUM (NSInteger, NCSBatteryType) {
    NCSBatteryType36Month,
    NCSBatteryTypeShortcut
};

typedef NS_ENUM (NSInteger, NCSAssessmentStatus) {
    NCSAssessmentStatusScheduled,
    NCSAssessmentStatusInProgress,
    NCSAssessmentStatusCompleted,
    NCSAssessmentStatusUploaded
};

@interface Assessment : Object

@property (nonatomic, retain) NSString *admin;
@property (nonatomic, retain) NSNumber *status;
@property (nonatomic, readonly) NSString *statusString;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSNumber *type;
@property (nonatomic, retain) NSSet *instruments;
@property (nonatomic, retain) User *user;

+ (NSArray *)batteryTypes;
+ (NSString *)batteryTitleForBatteryType:(NSNumber *)type;
//+ (NSArray *)instrumentTypesForBatteryType:(NSNumber *)type;
+ (NSString *)statusStringForStatus:(NSNumber *)status;
+ (NSArray *)statuses;
+ (NSArray *)statusTitles;

@end

@interface Assessment (CoreDataGeneratedAccessors)

- (void)addInstrumentsObject:(Instrument *)value;
- (void)removeInstrumentsObject:(Instrument *)value;
- (void)addInstruments:(NSSet *)values;
- (void)removeInstruments:(NSSet *)values;

@end
